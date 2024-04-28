import Architecture
import Foundation
import LinkNavigator
import Platform
import Domain
import Dashboard

// MARK: - AppContainerMock

final class AppContainerMock: DashboardEnvironmentUsable {

  let toastViewActionMock: ToastViewActionMock
  let githubSearchUseCaseMock: GithubSearchUseCaseMock
  let githubDetailUseCase: GithubDetailUseCase
  let githubLikeUseCase: GithubLikeUseCase
  let linkNavigatorMock: TabLinkNavigatorMock

  var toastViewModel: ToastViewActionType {
    toastViewActionMock
  }
  var githubSearchUseCase: GithubSearchUseCase {
    githubSearchUseCaseMock
  }
  var linkNavigator: RootNavigatorType {
    linkNavigatorMock
  }

  private init(
    toastViewActionMock: ToastViewActionMock,
    githubSearchUseCaseMock: GithubSearchUseCaseMock,
    githubDetailUseCase: GithubDetailUseCase,
    githubLikeUseCase: GithubLikeUseCase,
    linkNavigatorMock: TabLinkNavigatorMock)
  {
    self.toastViewActionMock = toastViewActionMock
    self.githubSearchUseCaseMock = githubSearchUseCaseMock
    self.githubDetailUseCase = githubDetailUseCase
    self.githubLikeUseCase = githubLikeUseCase
    self.linkNavigatorMock = linkNavigatorMock
  }
}

extension AppContainerMock {
  class func generate() -> AppContainerMock {
     .init(
      toastViewActionMock: .init(),
      githubSearchUseCaseMock: .init(),
      githubDetailUseCase: GithubDetailUseCasePlatform(),
      githubLikeUseCase: GithubLikeUseCasePlatform(),
      linkNavigatorMock: TabLinkNavigatorMock())
  }
}
