import Combine

public protocol GithubDetailUseCase {
  var repository: (GithubEntity.Detail.Repository.Request) -> AnyPublisher<
    GithubEntity.Detail.Repository.Response,
    CompositeErrorRepository
  > { get }
  var user: (GithubEntity.Detail.User.Request)
    -> AnyPublisher<GithubEntity.Detail.User.Response, CompositeErrorRepository> { get }
}
