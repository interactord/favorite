import Combine

public protocol GithubSearchUseCase {
  var search: (GithubEntity.Search.Request) -> AnyPublisher<GithubEntity.Search.Response, CompositeErrorRepository> { get }
}
