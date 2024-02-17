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
  public var search: (GithubEntity.Search.Request) -> AnyPublisher<GithubEntity.Search.Response, CompositeErrorRepository> {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: ["search", "repositories"],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
}
