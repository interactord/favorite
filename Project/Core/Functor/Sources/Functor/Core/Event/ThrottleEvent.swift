import SwiftUI
import Combine

@Observable
public final class ThrottleEvent<T: Hashable> {
  private var anyCancellable: Set<AnyCancellable> = .init()
  
  private let valueSubject: CurrentValueSubject<T, Never>
  private let delaySeconds: Double

  public init(value: T, delaySeconds: Double) {
    valueSubject = .init(value)
    self.delaySeconds = delaySeconds
  }
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
