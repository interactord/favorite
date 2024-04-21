import Combine
import Domain
import Foundation

extension Endpoint {
  func fetch<D: Decodable>(
    session: URLSession = .shared,
    isDebug: Bool = false,
    forceIgnoreCache: Bool = false) -> AnyPublisher<D, CompositeErrorRepository>
  {
    makeRequest()
      .map { $0.apply(ignoreCache: forceIgnoreCache) }
      .flatMap(session.fetchData)
      .map {
        if isDebug { Logger.debug(.init(stringLiteral: String(data: $0, encoding: .utf8) ?? "nil")) }
        return $0
      }
      .decode(type: D.self, decoder: JSONDecoder())
      .catch { Fail(error: $0.serialized()) }
      .eraseToAnyPublisher()
  }

  func fetchData(session: URLSession = .shared) -> AnyPublisher<Data, CompositeErrorRepository> {
    makeRequest()
      .flatMap(session.fetchData)
      .eraseToAnyPublisher()
  }
}

extension URLSession {
  fileprivate var fetchData: (URLRequest) -> AnyPublisher<Data, CompositeErrorRepository> {
    {
      self.dataTaskPublisher(for: $0)
        .tryMap { data, response in
          Logger.debug(.init(stringLiteral: response.url?.absoluteString ?? ""))

          guard let urlResponse = response as? HTTPURLResponse
          else { throw CompositeErrorRepository.invalidTypeCasting }

          guard (200...299).contains(urlResponse.statusCode) else {
            if urlResponse.statusCode == 401 {
              throw CompositeErrorRepository.networkUnauthorized
            }

            if let remoteError = try? JSONDecoder().decode(RemoteError.self, from: data) {
              throw CompositeErrorRepository.remoteError(remoteError)
            }

            throw CompositeErrorRepository.networkUnknown
          }

          return data
        }
        .catch { Fail(error: $0.serialized()) }
        .eraseToAnyPublisher()
    }
  }
}

extension Endpoint {
  private var makeRequest: () -> AnyPublisher<URLRequest, CompositeErrorRepository> {
    {
      Future<URLRequest, CompositeErrorRepository> { promise in
        guard let request else { return promise(.failure(.invalidTypeCasting)) }

        return promise(.success(request))
      }
      .eraseToAnyPublisher()
    }
  }
}

extension Error {
  fileprivate func serialized() -> CompositeErrorRepository {
    guard let error = self as? CompositeErrorRepository else {
      return CompositeErrorRepository.other(self)
    }
    return error
  }
}

extension URLRequest {
  func apply(ignoreCache: Bool) -> URLRequest {
    var new = self
    new.cachePolicy = ignoreCache ? .reloadIgnoringCacheData : .useProtocolCachePolicy
    return new
  }
}
