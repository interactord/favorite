import Architecture
import Domain
import ComposableArchitecture
import Dispatch
import Foundation

@Reducer
struct RepoStore {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: RepoSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    var query: String = "swift"
    var itemList: [GithubEntity.Search.Item] = []
    var fetchSearchItem: FetchState.Data<GithubEntity.Search.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case search(String)
    case fetchSearchItem(Result<GithubEntity.Search.Response, CompositeErrorRepository>)
    case throwError(CompositeErrorRepository)
    case teardown
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestSearch
  }

  var body: some Reducer<State, Action> {
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
        let page = Int(state.itemList.count / 30) + 1
        return sideEffect.search(.init(query: query, page: page))
          .cancellable(pageID: pageID, id: CancelID.requestSearch, cancelInFlight: true)

      case .fetchSearchItem(let result):
        state.fetchSearchItem.isLoading = false
        guard !state.query.isEmpty else {
          state.itemList = []
          return .none
        }
        state.itemList = []
        switch result {
        case .success(let item):
          state.fetchSearchItem.value = item
          state.itemList = state.itemList + item.itemList
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error))}
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

  // MARK: Private

  private let pageID: String
  private let sideEffect: RepoSideEffect

}
