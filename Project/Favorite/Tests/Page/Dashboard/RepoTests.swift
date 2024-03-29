import Dashboard
import ComposableArchitecture
import Domain
import XCTest

@MainActor
public final class RepoTests: XCTestCase {
  typealias State = RepoReducer.State
  typealias Action = RepoReducer.Action
  typealias Reducer = RepoReducer
}

extension RepoTests {
  struct SUT {

    init() {
      let container = AppContainerMock.build()
      let useCase = container.dependency
      let navigator = container.navigator
      let scheduler = DispatchQueue.test
      store = .init(
        initialState: State(), 
        reducer: {
          Reducer(sideEffect: .init(
            useCase: useCase,
            main: scheduler.eraseToAnyScheduler(),
            navigator: navigator))
        })

      self.useCase = useCase
      self.navigator = navigator
      self.scheduler = scheduler
    }

    let store: TestStore<State, Action>
    let useCase: DashboardEnvironmentUsable
    let navigator: TabLinkNavigatorMock
    let scheduler: TestSchedulerOf<DispatchQueue>
  }
}
