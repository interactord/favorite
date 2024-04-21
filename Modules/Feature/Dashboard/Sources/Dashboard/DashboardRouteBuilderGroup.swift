import Architecture
import LinkNavigator

// MARK: - DashboardRouteBuilderGroup

public struct DashboardRouteBuilderGroup<RootNavigator: RootNavigatorType> {
  public init() { }
}

extension DashboardRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      RepoRouteBuilder.generate(),
      RepoDetailRouteBuilder.generate(),
      UserRouteBuilder.generate(),
      UserDetailRouteBuilder.generate(),
      LikeRouteBuilder.generate(),
    ]
  }
}
