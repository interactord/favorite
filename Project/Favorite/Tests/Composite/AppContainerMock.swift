import Architecture
import Foundation
import LinkNavigator
import Platform

@testable import FavoritePreview

// MARK: - AppContainer

final class AppContainerMock {

  // MARK: Lifecycle

  private init(dependency: AppSideEffect, navigator: TabLinkNavigatorMock) {
    self.dependency = dependency
    self.navigator = navigator
  }

  // MARK: Internal

  let dependency: AppSideEffect
  let navigator: TabLinkNavigatorMock
}

extension AppContainerMock {
  class func build() -> AppContainerMock {
    let sideEffect = AppSideEffect(
      toastViewModel: .init(),
      githubSearchUseCase: GithubSearchUseCaseMock(),
      githubDetailUseCase: GithubDetailUseCasePlatform(),
      githubLikeUseCase: GithubLikeUseCasePlatform())

    return .init(
      dependency: sideEffect,
      navigator: TabLinkNavigatorMock())
  }
}
