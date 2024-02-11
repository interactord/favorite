import Foundation

// MARK: - CompositeErrorRepository

public enum CompositeErrorRepository: Error {

  case notFoundFilePath
  case invalidTypeCast
  case other(Error)

  public var message: String {
    switch self {
    case .notFoundFilePath:
      "notFoundFilePath"
    case .invalidTypeCast:
      "invalidTypeCast"
    case .other(let error):
      "\(error)"
    }
  }

}

// MARK: Equatable

extension CompositeErrorRepository: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.message == rhs.message
  }
}
