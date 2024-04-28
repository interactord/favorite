import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var githubSearchUseCase: GithubSearchUseCase { get }
  var githubDetailUseCase: GithubDetailUseCase { get }
  var githubLikeUseCase: GithubLikeUseCase { get }
}
