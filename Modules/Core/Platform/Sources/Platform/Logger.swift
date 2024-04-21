import Domain
import Foundation
import Logging

private let logging = Logging.Logger(label: "com.myCompany.platform")

// MARK: - Logger

public struct Logger: Equatable {
  public static func debug(_ message: Logger.Message) {
    logging.debug(.init(stringLiteral: message.description))
  }

  public static func trace(_ message: Logger.Message) {
    logging.trace(.init(stringLiteral: message.description))
  }

  public static func error(_ message: Logger.Message) {
    logging.error(.init(stringLiteral: message.description))
  }

  public static func error(_ error: CompositeErrorRepository) {
    logging.error(.init(stringLiteral: error.displayMessage))
  }
}

// MARK: Logger.Message

extension Logger {
  public struct Message: ExpressibleByStringLiteral, Equatable, CustomStringConvertible, ExpressibleByStringInterpolation {
    public typealias StringLiteralType = String

    private var value: String

    public init(stringLiteral value: String) {
      self.value = value
    }

    public var description: String {
      value
    }
  }
}
