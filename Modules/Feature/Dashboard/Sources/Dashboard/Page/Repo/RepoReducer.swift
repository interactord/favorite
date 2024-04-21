import Architecture
import ComposableArchitecture
import Dispatch
import Domain
import Foundation

// MARK: - RepoReducer

@Reducer
public struct RepoReducer {

  // MARK: Lifecycle

  public init(
    pageID: String = UUID().uuidString,
    sideEffect: RepoSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Public

  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID
    public let perPage = 40

    public var query = "swift"
    public var itemList: [GithubEntity.Search.Repository.Item] = []
    public var fetchSearchItem: FetchState.Data<GithubEntity.Search.Repository.Composite?> = .init(isLoading: false, value: .none)

    public init(id: UUID = UUID()) {
      self.id = id
    }
  }

  public enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case search(String)
    case routeToDetail(GithubEntity.Search.Repository.Item)

    /// - Note: In-Action
    case sendSearchItem(GithubEntity.Search.Repository.Request)

    case fetchSearchItem(Result<GithubEntity.Search.Repository.Composite, CompositeErrorRepository>)
    case throwError(CompositeErrorRepository)
    case teardown
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .search(let query):
        guard !query.isEmpty else {
          state.itemList = []
          return .none
        }

        if state.query != state.fetchSearchItem.value?.request.query { state.itemList = [] }
        if let totalCount = state.fetchSearchItem.value?.response.totalCount, totalCount < state.itemList.count {
          return .none
        }

        let page = Int(state.itemList.count / state.perPage) + 1
        let sendItem = GithubEntity.Search.Repository.Request.init(query: query, page: page, perPage: state.perPage)
        return .run { await $0(.sendSearchItem(sendItem))}

      case .routeToDetail(let item):
        sideEffect.routeToDetail(item)
        return .none

      case .sendSearchItem(let item):
        state.fetchSearchItem.isLoading = true
        return sideEffect
          .search(item)
          .cancellable(pageID: pageID, id: CancelID.requestSearch, cancelInFlight: true)

      case .fetchSearchItem(let result):
        state.fetchSearchItem.isLoading = false
        guard !state.query.isEmpty else {
          state.itemList = []
          return .none
        }
        switch result {
        case .success(let item):
          state.fetchSearchItem.value = item
          state.itemList = state.itemList.merge(item.response.itemList)
          if state.itemList.isEmpty {
            sideEffect.useCase.toastViewModel.send(message: "검색결과가 없습니다")
          }
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })
      }
    }
  }

  // MARK: Internal

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestSearch
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: RepoSideEffect

}

extension [GithubEntity.Search.Repository.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }

    return Array(new)
  }
}
