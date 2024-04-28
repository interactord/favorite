import Foundation

public protocol ToastViewActionType {
  func send(message: String)
  func send(errorMessage: String)
  func clear()
}
