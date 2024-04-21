import ComposableArchitecture
import Domain
import Platform
import Dashboard
import XCTest

final class RepoTests: XCTestCase {

  override func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_search_case1() async {

    let newState: RepoReducer.State = {
      let requestMock: GithubEntity.Search.Repository.Request = .init(query: "test", page: 1, perPage: 30)
      let responseMock = GithubEntity.Search.Repository.Composite(
        request: requestMock,
        response: ResponseMock().searchResponse.searchRepository.successValue)

      var newState = RepoReducer.State()
      newState.itemList = responseMock.response.itemList
      return newState
    }()

    let sut = SUT(state: newState)

    await sut.store.send(.search("")) { state in
      state.itemList = []
    }
  }

  @MainActor
  func test_sendSearchItem_success_case1() async {
    let sut = SUT()

    let requestMock: GithubEntity.Search.Repository.Request = .init(query: "test", page: 1, perPage: 30)
    let responseMock = GithubEntity.Search.Repository.Composite(
      request: requestMock,
      response: ResponseMock().searchResponse.searchRepository.successValue)

    await sut.store.send(.sendSearchItem(requestMock)) { state in
      state.fetchSearchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchItem) { state in
      state.fetchSearchItem.isLoading = false
      state.fetchSearchItem.value = responseMock
      state.itemList = responseMock.response.itemList
    }
  }

  @MainActor
  func test_sendSearchItem_failure_case1() async {
    let sut = SUT()
    sut.container.githubSearchUseCaseMock.type = .failure(.invalidTypeCasting)

    let requestMock: GithubEntity.Search.Repository.Request = .init(query: "test", page: 1, perPage: 30)

    await sut.store.send(.sendSearchItem(requestMock)) { state in
      state.fetchSearchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchItem) { state in
      state.fetchSearchItem.isLoading = false
    }
    await sut.store.receive(\.throwError)
  }

}

extension RepoTests {
  struct SUT {
    init(state: RepoReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.store = .init(initialState: state) {
        RepoReducer(sideEffect: .init(
          useCase: container,
          main: main.eraseToAnyScheduler(),
          navigator: container.linkNavigator))
      }
      self.container = container
      self.scheduler = main
    }

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<RepoReducer.State, RepoReducer.Action>
  }

  struct ResponseMock {
    let searchResponse: GithubSearchUseCaseMock.Response = .init()
    init() {}
  }
}
