import Architecture
import Domain
import LinkNavigator
import Foundation

struct UserDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.userDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
//      guard let query: GithubEntity.Detail.User.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        UserDetailPage(store: .init(
          initialState: UserDetailReducer.State(user: GithubEntity.Detail.User.Request.init(ownerName: "test")),
          reducer: {
            UserDetailReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
