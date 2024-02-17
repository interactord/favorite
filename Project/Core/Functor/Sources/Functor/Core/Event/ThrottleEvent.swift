import Combine
import SwiftUI

// MARK: - ThrottleEvent

@Observable
public final class ThrottleEvent<T: Hashable> {

  // MARK: Lifecycle

  public init(value: T, delaySeconds: Double) {
    valueSubject = .init(value)
    self.delaySeconds = delaySeconds
  }

  // MARK: Private

  private var anyCancellable: Set<AnyCancellable> = .init()

  private let valueSubject: CurrentValueSubject<T, Never>
  private let delaySeconds: Double

}

extension ThrottleEvent {
  public func apply(throttleEvent: @escaping ((T) -> Void)) {
    valueSubject
      .receive(on: RunLoop.main)
      .throttle(
        for: .seconds(delaySeconds),
        scheduler: RunLoop.main,
        latest: true)
      .sink {
        throttleEvent($0)
      }
      .store(in: &anyCancellable)
  }

  public func update(value: T) {
    valueSubject.send(value)
  }

  public func reset() {
    anyCancellable = .init()
  }
}
