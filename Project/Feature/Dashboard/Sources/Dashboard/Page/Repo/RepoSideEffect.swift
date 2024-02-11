import Architecture
import Domain
import ComposableArchitecture
import Foundation
import CombineExt

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
          .mapToResult()
          .map(RepoStore.Action.fetchSearchItem)
      }
    }
  }
}
