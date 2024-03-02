import Architecture
import ComposableArchitecture
import Domain
import Dispatch
import Foundation
import Functor

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
    case getMock
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

      case .getMock:
        state.fetchDetail.value = String.json
        return .none

      case .fetchDetail(let result):
        state.fetchDetail.isLoading = false
        switch result {
        case .success(let item):
          state.fetchDetail.value = item
          print((try? item.jsonPrettyPrinted()) ?? "nil")
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

extension String {
  fileprivate static var json: GithubEntity.Detail.User.Response? {
    let data = """
    {
      "login": "tkersey",
      "id": 217,
      "node_id": "MDQ6VXNlcjIxNw==",
      "avatar_url": "https://avatars.githubusercontent.com/u/217?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/tkersey",
      "html_url": "https://github.com/tkersey",
      "followers_url": "https://api.github.com/users/tkersey/followers",
      "following_url": "https://api.github.com/users/tkersey/following{/other_user}",
      "gists_url": "https://api.github.com/users/tkersey/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/tkersey/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/tkersey/subscriptions",
      "organizations_url": "https://api.github.com/users/tkersey/orgs",
      "repos_url": "https://api.github.com/users/tkersey/repos",
      "events_url": "https://api.github.com/users/tkersey/events{/privacy}",
      "received_events_url": "https://api.github.com/users/tkersey/received_events",
      "type": "User",
      "site_admin": false,
      "name": "Tim Kersey",
      "company": "@thisisartium",
      "blog": "http://k-t.im",
      "location": "Los Angeles, CA",
      "email": null,
      "hireable": null,
      "bio": "If you'd have asked me when I was 3 what I wanted to be when I grew up I would have said a bologna sandwich \\r\\n",
      "twitter_username": null,
      "public_repos": 33,
      "public_gists": 49,
      "followers": 411,
      "following": 1084,
      "created_at": "2008-02-13T12:57:00Z",
      "updated_at": "2023-12-22T14:34:02Z"
    }
    """.data(using: .utf8)!

    do {
      return try JSONDecoder().decode(GithubEntity.Detail.User.Response.self, from: data)
    } catch {
      print(error)
      return .none
    }
  }
}
