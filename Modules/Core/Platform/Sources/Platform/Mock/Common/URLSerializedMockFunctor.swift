import Foundation

// MARK: - URLSerializedMockFunctor

enum URLSerializedMockFunctor {
  static func serialized<T: Codable & Sendable & Equatable>(url: URL) -> T? {
    url.serialized()
  }
}

extension URL {
  fileprivate func serialized<T: Codable & Sendable & Equatable>() -> T? {
    do {
      let data = try Data(contentsOf: self)
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      return .none
    }
  }
}
