import Combine
import Foundation

public protocol GithubLikeUseCase {
  var getLike: () -> AnyPublisher<GithubEntity.Like, CompositeErrorRepository> { get }
  var saveRepository: (GithubEntity.Detail.Repository.Response)
    -> AnyPublisher<GithubEntity.Like, CompositeErrorRepository> { get }
}
