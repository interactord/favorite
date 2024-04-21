import ComposableArchitecture
import Dashboard
import Domain
import XCTest

// MARK: - RepoTests

@MainActor
public final class RepoTests: XCTestCase {
  typealias State = RepoReducer.State
  typealias Action = RepoReducer.Action
  typealias Reducer = RepoReducer
}

// MARK: RepoTests.SUT

extension RepoTests {
  struct SUT {

    // MARK: Lifecycle

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

    // MARK: Internal

    let store: TestStore<State, Action>
    let useCase: DashboardEnvironmentUsable
    let navigator: TabLinkNavigatorMock
    let scheduler: TestSchedulerOf<DispatchQueue>
  }
}
