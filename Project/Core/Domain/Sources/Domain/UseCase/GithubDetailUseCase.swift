import Combine

public protocol GithubDetailUseCase {
  var repository: (GithubEntity.Detail.Repository.Request) -> AnyPublisher<GithubEntity.Detail.Repository.Response, CompositeErrorRepository> { get }
}
