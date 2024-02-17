import Combine
import Domain

public struct GithubDetailUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.github.com") {
    self.baseURL = baseURL
  }
}

extension GithubDetailUseCasePlatform: GithubDetailUseCase {
  public var repository: (GithubEntity.Detail.Repository.Request) -> AnyPublisher<GithubEntity.Detail.Repository.Response, CompositeErrorRepository> {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["repos", item.ownerName, item.repositoryName],
        httpMethod: .get,
        content: .none)
        .fetch(isDebug: true)
    }
  }
}
