import Architecture
import Domain
import ComposableArchitecture
import Foundation

struct RepoDetailSideEffect {
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

extension RepoDetailSideEffect {
  var detail: (GithubEntity.Detail.Repository.Request) -> Effect<RepoDetailReducer.Action> {
    { item in
        .publisher {
          useCase.githubDetailUseCase.repository(item)
            .receive(on: main)
            .mapToResult()
            .map(RepoDetailReducer.Action.fetchDetailItem)
        }
    }
  }
}
