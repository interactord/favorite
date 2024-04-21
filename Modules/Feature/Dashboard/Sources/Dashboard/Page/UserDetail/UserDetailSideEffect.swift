import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - UserDetailSideEffect

struct UserDetailSideEffect {
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

extension UserDetailSideEffect {
  var user: (GithubEntity.Detail.User.Request) -> Effect<UserDetailReducer.Action> {
    { request in
      .publisher {
        useCase.githubDetailUseCase
          .user(request)
          .mapToResult()
          .receive(on: main)
          .map(UserDetailReducer.Action.fetchDetail)
      }
    }
  }
}
