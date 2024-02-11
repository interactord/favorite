import Architecture
import LinkNavigator

struct RepoRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.repo.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      return DebugWrappingController(matchPath: matchPath) {
        RepoPage(store: .init(
          initialState: RepoStore.State(),
          reducer: {
            RepoStore(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
