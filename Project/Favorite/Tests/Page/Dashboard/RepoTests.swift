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
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.set(\.itemList, []))
  }

  @MainActor
  func test_binding_query_case1() async {
    var newState = RepoReducer.State()
    newState.query = "apple"
    newState.itemList = []
    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "")) { state in
      state.query = ""
    }
  }

  @MainActor
  func test_binding_query_case2() async {
    var newState = RepoReducer.State()
    newState.query = "apple"
    newState.itemList = ResponseMock().searchResponse.searchRepository.successValue.itemList

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "")) { state in
      state.query = ""
      state.itemList = []
    }
  }

  @MainActor
  func test_binding_query_case3() async {

    var newState = RepoReducer.State()
    newState.query = ""
    newState.itemList = []

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }
  }

  @MainActor
  func test_binding_query_case4() async {

    var newState = RepoReducer.State()
    newState.query = "apple"
    let rep = ResponseMock().searchResponse.searchRepository.successValue
    let res = GithubEntity.Search.Repository.Request(query: "apple")
    newState.itemList = rep.itemList
    newState.fetchSearchItem.value = .init(request: res, response: rep)

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
      state.itemList = []
    }
  }

  @MainActor
  func test_search_case_success_1() async {
    let sut = SUT()

    let keyword = "swift"
    let requestMock: GithubEntity.Search.Repository.Request = .init(query: keyword, page: 1, perPage: 40)
    let responseMock = GithubEntity.Search.Repository.Composite(
      request: requestMock,
      response: ResponseMock().searchResponse.searchRepository.successValue)

    await sut.store.send(.set(\.query, keyword)) {
      $0.query = keyword
    }
    await sut.store.send(.search(keyword)) { state in
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
  func test_search_case_failure() async {
    let sut = SUT()
    sut.container.githubSearchUseCaseMock.type = .failure(.invalidTypeCasting)

    let keyword = "swift"

    await  sut.store.send(.set(\.query, keyword)) {
      $0.query = keyword
    }
    await sut.store.send(.search(keyword)) { state in
      state.fetchSearchItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchItem) { state in
      state.fetchSearchItem.isLoading = false
    }
    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_fetchSearchItem_case() async {
    let sut = SUT()
    let mock = GithubEntity.Search.Repository.Composite(
      request: .init(query: "test"),
      response: .init(totalCount: .zero, itemList: []))

    await sut.store.send(.fetchSearchItem(.success(mock))) { state in
      state.fetchSearchItem.isLoading = false
      state.fetchSearchItem.value = mock
    }

    XCTAssertEqual(sut.container.toastViewActionMock.event.sendMessage, 1)

  }

  @MainActor
  func test_routeToDetail() async {
    let sut = SUT()

    let pick = ResponseMock().searchResponse.searchRepository.successValue.itemList.first

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, .zero)

    await sut.store.send(.routeToDetail(pick!))

    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
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
