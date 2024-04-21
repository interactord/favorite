import Architecture
import Domain
import LinkNavigator

struct RepoDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Dashboard.Path.repoDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: DashboardEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let query: GithubEntity.Detail.Repository.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        RepoDetailPage(store: .init(
          initialState: RepoDetailReducer.State(item: query),
          reducer: {
            RepoDetailReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
