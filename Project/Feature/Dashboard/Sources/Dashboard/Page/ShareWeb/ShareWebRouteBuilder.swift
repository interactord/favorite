import Architecture
import Domain
import LinkNavigator

struct ShareWebRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.shareWeb.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let query: GithubEntity.Search.Item = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        ShareWebPage(store: .init(
          initialState: ShareWebStore.State(item: query),
          reducer: {
            ShareWebStore(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
