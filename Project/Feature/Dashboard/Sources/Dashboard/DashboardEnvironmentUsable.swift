import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewModel { get }
  var githubSearchUseCase: GithubSearchUseCase { get }
  var githubDetailUseCase: GithubDetailUseCase { get }
}
