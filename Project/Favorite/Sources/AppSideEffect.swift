import Architecture
import Dashboard
import Domain
import Foundation
import LinkNavigator
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, DashboardEnvironmentUsable {
  let toastViewModel: ToastViewModel
  let githubSearchUseCase: GithubSearchUseCase
  let githubDetailUseCase: GithubDetailUseCase
  let githubLikeUseCase: GithubLikeUseCase
}
