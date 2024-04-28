import Foundation

public class ToastViewActionMock {

  public var event: Event = .init()

  public struct Event: Equatable, Sendable {
    public var sendMessage: Int = .zero
    public var sendErrorMessage: Int = .zero
    public var clear: Int = .zero

    public init(
      sendMessage: Int = .zero,
      sendErrorMessage: Int = .zero,
      clear: Int = .zero)
    {
      self.sendMessage = sendMessage
      self.sendErrorMessage = sendErrorMessage
      self.clear = clear
    }
  }

  public init(event: Event = .init()) {
    self.event = event
  }
}

extension ToastViewActionMock: ToastViewActionType {
  public func send(message: String) {
    event.sendMessage += 1
  }

  public func send(errorMessage: String) {
    event.sendErrorMessage += 1
  }

  public func clear() {
    event.clear += 1
  }
}
