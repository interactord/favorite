import Architecture
import Foundation
import LinkNavigator
import Platform
import Domain
import Dashboard

// MARK: - AppContainerMock

final class AppContainerMock: DashboardEnvironmentUsable {
  let toastViewModel: ToastViewModel
  let githubSearchUseCaseMock: GithubSearchUseCaseMock
  let githubDetailUseCase: GithubDetailUseCase
  let githubLikeUseCase: GithubLikeUseCase
  let linkNavigator: RootNavigatorType

  var githubSearchUseCase: GithubSearchUseCase {
    githubSearchUseCaseMock
  }

  private init(
    toastViewModel: ToastViewModel,
    githubSearchUseCaseMock: GithubSearchUseCaseMock,
    githubDetailUseCase: GithubDetailUseCase,
    githubLikeUseCase: GithubLikeUseCase,
    linkNavigator: RootNavigatorType)
  {
    self.toastViewModel = toastViewModel
    self.githubSearchUseCaseMock = githubSearchUseCaseMock
    self.githubDetailUseCase = githubDetailUseCase
    self.githubLikeUseCase = githubLikeUseCase
    self.linkNavigator = linkNavigator
  }
}

extension AppContainerMock {
  class func generate() -> AppContainerMock {
     .init(
      toastViewModel: .init(),
      githubSearchUseCaseMock: .init(),
      githubDetailUseCase: GithubDetailUseCasePlatform(),
      githubLikeUseCase: GithubLikeUseCasePlatform(),
      linkNavigator: TabLinkNavigatorMock())
  }
}
