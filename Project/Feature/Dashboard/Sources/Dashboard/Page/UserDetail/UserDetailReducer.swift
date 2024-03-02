import Architecture
import ComposableArchitecture
import Domain
import Dispatch
import Foundation

@Reducer
struct UserDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: UserDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    let user: GithubEntity.Detail.User.Request

    var fetchDetail: FetchState.Data<GithubEntity.Detail.User.Response?>

    init(id: UUID = UUID(), user: GithubEntity.Detail.User.Request) {
      self.id = id
      self.user = user
      fetchDetail = .init(isLoading: false, value: .none)
    }
  }

  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case getDetail(GithubEntity.Detail.User.Request)
    case fetchDetail(Result<GithubEntity.Detail.User.Response, CompositeErrorRepository>)
    case throwError(CompositeErrorRepository)
    case teardown
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestDetail
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getDetail(let requestModel):
        state.fetchDetail.isLoading = true
        return sideEffect.user(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestDetail, cancelInFlight: true)

      case .fetchDetail(let result):
        state.fetchDetail.isLoading = false
        switch result {
        case .success(let item):
          state.fetchDetail.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        Logger.error(.init(stringLiteral: error.displayMessage))
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: UserDetailSideEffect

}
