import Architecture
import LinkNavigator

struct UserRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.user.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      return DebugWrappingController(matchPath: matchPath) {
        UserPage(store: .init(
          initialState: UserStore.State(),
          reducer: {
            UserStore(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
