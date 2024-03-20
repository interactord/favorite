import Combine
import Domain
import Foundation

// MARK: - GithubLikeUseCasePlatform

public struct GithubLikeUseCasePlatform {
  @StandardKeyArchiver(defaultValue: GithubEntity.Like())
  private var store: GithubEntity.Like

  public init() { }
}

// MARK: GithubLikeUseCase

extension GithubLikeUseCasePlatform: GithubLikeUseCase {
  public var getLike: () -> AnyPublisher<GithubEntity.Like, CompositeErrorRepository> {
    Just(store)
      .setFailureType(to: CompositeErrorRepository.self)
      .eraseToAnyPublisher
  }

  public var saveRepository: (GithubEntity.Detail.Repository.Response) -> AnyPublisher<
    GithubEntity.Like,
    CompositeErrorRepository
  > {
    { model in
      _store.sync(store.mutate(item: model))
      return Just(store)
        .setFailureType(to: CompositeErrorRepository.self)
        .eraseToAnyPublisher()
    }
  }
}

extension GithubEntity.Like {
  fileprivate func mutate(item: GithubEntity.Detail.Repository.Response) -> Self {
    guard repoList.first(where: { $0.htmlURL == item.htmlURL }) != .none else {
      return .init(
        repoList: repoList + [item],
        userList: userList)
    }

    return .init(
      repoList: repoList.filter { $0.htmlURL != item.htmlURL },
      userList: userList)
  }
}
