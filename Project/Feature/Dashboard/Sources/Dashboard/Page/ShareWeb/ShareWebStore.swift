import ComposableArchitecture
import Domain
import Dispatch
import Foundation

@Reducer
struct ShareWebStore {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: ShareWebSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    let item: GithubEntity.Search.Item

    init(
      id: UUID = UUID(),
      item: GithubEntity.Search.Item)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case teardown
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .binding:
        .none
      case .teardown:
        .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: ShareWebSideEffect

}
