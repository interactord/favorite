import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - RepoSideEffect

struct RepoSideEffect {
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

extension RepoSideEffect {
  var search: (GithubEntity.Search.Request) -> Effect<RepoStore.Action> {
    { item in
      .publisher {
        useCase.githubSearchUseCase.search(item)
          .receive(on: main)
          .map {
            GithubEntity.Search.Composite(
              request: item,
              response: $0)
          }
          .mapToResult()
          .map(RepoStore.Action.fetchSearchItem)
      }
    }
  }

  var routeToDetail: (GithubEntity.Search.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.shareWeb.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}
