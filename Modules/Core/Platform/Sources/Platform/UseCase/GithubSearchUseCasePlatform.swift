import Combine
import Domain

// MARK: - GithubSearchUseCasePlatform

public struct GithubSearchUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.github.com") {
    self.baseURL = baseURL
  }
}

// MARK: GithubSearchUseCase

extension GithubSearchUseCasePlatform: GithubSearchUseCase {
  public var searchRepository: (GithubEntity.Search.Repository.Request) -> AnyPublisher<
    GithubEntity.Search.Repository.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["search", "repositories"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }

  public var searchUser: (GithubEntity.Search.User.Request) -> AnyPublisher<
    GithubEntity.Search.User.Response,
    CompositeErrorRepository
  > {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["search", "users"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
}
