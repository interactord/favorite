import ComposableArchitecture
import Dispatch
import Foundation

@Reducer
struct RepoStore {
  private let pageID: String
  private let sideEffect: RepoSideEffect

  init(
    pageID: String = UUID().uuidString,
    sideEffect: RepoSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case teardown
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) }
        )
      }
    }
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
  }
}
