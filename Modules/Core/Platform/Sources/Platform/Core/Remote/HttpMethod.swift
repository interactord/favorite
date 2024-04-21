import Foundation

// MARK: - HttpMethod

enum HttpMethod: Equatable {
  case get
  case post
  case put
  case delete
}

extension HttpMethod {
  var rawValue: String {
    switch self {
    case .get: "GET"
    case .post: "POST"
    case .put: "PUT"
    case .delete: "DELETE"
    }
  }
}
