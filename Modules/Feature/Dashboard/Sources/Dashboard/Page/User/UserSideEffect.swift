import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - UserSideEffect

struct UserSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension UserSideEffect {
  var searchUser: (GithubEntity.Search.User.Request) -> Effect<UserReducer.Action> {
    { item in
      .publisher {
        useCase.githubSearchUseCase.searchUser(item)
          .receive(on: main)
          .map {
            GithubEntity.Search.User.Composite(
              request: item,
              response: $0)
          }
          .mapToResult()
          .map(UserReducer.Action.fetchSearchItem)
      }
    }
  }

  var routeToDetail: (GithubEntity.Search.User.Item) -> Void {
    {
      let model = GithubEntity.Detail.User.Request(ownerName: $0.loginName)
      navigator.backOrNext(
        linkItem: .init(
          path: Link.Dashboard.Path.userDetail.rawValue,
          items: model),
        isAnimated: true)
    }
  }
}
