import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - RepoDetailSideEffect

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

  var isLike: (GithubEntity.Detail.Repository.Response) -> Effect<RepoDetailReducer.Action> {
    { item in
      .publisher {
        useCase.githubLikeUseCase
          .getLike()
          .map {
            $0.repoList.first(where: { $0 == item }) != .none
          }
          .mapToResult()
          .receive(on: main)
          .map(RepoDetailReducer.Action.fetchIsLike)
      }
    }
  }

  var updateIsLike: (GithubEntity.Detail.Repository.Response) -> Effect<RepoDetailReducer.Action> {
    { item in
      .publisher {
        useCase.githubLikeUseCase
          .saveRepository(item)
          .map {
            $0.repoList.first(where: { $0 == item }) != .none
          }
          .mapToResult()
          .receive(on: main)
          .map(RepoDetailReducer.Action.fetchIsLike)
      }
    }
  }
}
