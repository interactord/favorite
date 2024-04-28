import Foundation
import Functor

// MARK: - ToastViewModel

@Observable
public final class ToastViewModel {

  // MARK: Lifecycle

  public init(message: String = "", errorMessage: String = "") {
    self.message = message
    self.errorMessage = errorMessage
  }

  deinit {
    Logger.trace("ToastViewModel deinit...")
    clear()
  }

  // MARK: Public

  public var message: String
  public var errorMessage: String
  public var changeAction: ((Bool) -> Void)?

  // MARK: Private

  private let defaultEvent = DebounceFunctor(delay: 2.5)
  private let errorEvent = DebounceFunctor(delay: 2.5)

}

extension ToastViewModel: ToastViewActionType {
  public func send(message: String) {
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      changeAction?(true)
      self.message = message

      defaultEvent.run {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          self.changeAction?(false)
        }
        self.message = ""
      }
    }
  }

  public func send(errorMessage: String) {
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.errorMessage = errorMessage
      changeAction?(true)

      defaultEvent.run {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          self.changeAction?(false)
        }
        self.errorMessage = ""
      }
    }
  }

  public func clear() {
    defaultEvent.cancel()
    errorEvent.cancel()

    message = ""
    errorMessage = ""

    changeAction?(false)
  }
}
