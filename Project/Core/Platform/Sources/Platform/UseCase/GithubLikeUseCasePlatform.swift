import Foundation
import Combine
import Domain

public struct GithubLikeUseCasePlatform {
  @StandardKeyArchiver(defaultValue: GithubEntity.Like.init())
  private var store: GithubEntity.Like

  public init() {}
}

extension GithubLikeUseCasePlatform: GithubLikeUseCase {
  public var getLike: () -> AnyPublisher<GithubEntity.Like, CompositeErrorRepository> {
    return Just(store)
      .setFailureType(to: CompositeErrorRepository.self)
      .eraseToAnyPublisher
  }

  public var saveRepository: (GithubEntity.Detail.Repository.Response) -> AnyPublisher<GithubEntity.Like, CompositeErrorRepository> {
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
    guard let _ = repoList.first(where: { $0.htmlURL == item.htmlURL }) else {
      return .init(
        repoList: repoList + [item],
        userList: userList)
    }

    return .init(
      repoList: repoList.filter { $0.htmlURL != item.htmlURL },
      userList: userList)
  }
}
