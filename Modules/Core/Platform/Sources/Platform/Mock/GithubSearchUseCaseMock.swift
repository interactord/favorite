import Combine
import Domain
import Foundation

// MARK: - GithubSearchUseCaseMock

public final class GithubSearchUseCaseMock {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public var type: ResponseType = .success
  public var response: Response = .init()
}

// MARK: GithubSearchUseCase

extension GithubSearchUseCaseMock: GithubSearchUseCase {
  public var searchRepository: (GithubEntity.Search.Repository.Request) -> AnyPublisher<
    GithubEntity.Search.Repository.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().searchRepository.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }

  public var searchUser: (GithubEntity.Search.User.Request) -> AnyPublisher<
    GithubEntity.Search.User.Response,
    CompositeErrorRepository
  > {
    { [weak self] _ in
      guard let self else {
        return Fail(error: CompositeErrorRepository.invalidTypeCasting)
          .eraseToAnyPublisher()
      }

      switch type {
      case .success:
        return Just(Response().searchUser.successValue)
          .setFailureType(to: CompositeErrorRepository.self)
          .eraseToAnyPublisher()

      case .failure(let error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
  }
}

extension GithubSearchUseCaseMock {
  public enum ResponseType: Equatable, Sendable {
    case success
    case failure(CompositeErrorRepository)
  }

  public struct Response: Equatable, Sendable {
    public init() { }

    var searchRepository = DataResponseMock<GithubEntity.Search.Repository.Response>(
      successValue:
      URLSerializedMockFunctor
        .serialized(url: Files.searchRepositoriesSuccessJson.url)!,
      failureValue: CompositeErrorRepository.remoteError(
        URLSerializedMockFunctor
          .serialized(url: Files.searchRepositoriesFailureJson.url)!))

    var searchUser = DataResponseMock<GithubEntity.Search.User.Response>(
      successValue:
      URLSerializedMockFunctor
        .serialized(url: Files.searchUsersSuccessJson.url)!,
      failureValue: CompositeErrorRepository.remoteError(
        URLSerializedMockFunctor
          .serialized(url: Files.searchUsersFailureJson.url)!))
  }
}
