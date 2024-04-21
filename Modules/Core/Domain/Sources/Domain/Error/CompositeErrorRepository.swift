import Foundation

// MARK: - CompositeErrorRepository

public enum CompositeErrorRepository: Error {

  case invalidTypeCasting
  case timeout
  case networkOffline
  case networkUnauthorized
  case networkUnknown
  case networkNotFound
  case other(Error)
  case remoteError(RemoteError)
  case userCancelled
  case stopSpeech
  case webSocketDisconnect

  // MARK: Public

  public var displayMessage: String {
    switch self {
    case .networkOffline:
      "Wifi is offline. please reconnect the wifi."
    case .userCancelled:
      "User Canceled"
    case .stopSpeech: ""
    case .remoteError(let error):
      error.message
    default:
      localizedDescription
    }
  }
}

// MARK: Equatable

extension CompositeErrorRepository: Equatable {
  public var isNetworkUnauthorized: Bool {
    switch self {
    case .networkUnauthorized:
      true
    default:
      false
    }
  }

  public var isNetworkOffline: Bool {
    switch self {
    case .networkOffline:
      true
    case .other(let domain) where (domain as NSError).code == -1009:
      true
    default:
      false
    }
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.displayMessage == rhs.displayMessage
  }

}

extension Error {
  public func serialized() -> CompositeErrorRepository {
    guard let err = self as? CompositeErrorRepository
    else { return .other(self) }
    return err
  }
}

// MARK: - RemoteError

public struct RemoteError: Codable, Equatable {
  public let message: String
}
