import Foundation

// MARK: - DebounceFunctor

public class DebounceFunctor {

  // MARK: Lifecycle

  public init(delay: TimeInterval, queue: DispatchQueue = .main) {
    self.delay = delay
    self.queue = queue
  }

  // MARK: Private

  private let delay: TimeInterval
  private var workItem: DispatchWorkItem?
  private let queue: DispatchQueue
}

extension DebounceFunctor {
  public func run(action: @escaping () -> Void) {
    workItem?.cancel()
    let workItem = DispatchWorkItem(block: action)
    queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    self.workItem = workItem
  }

  public func cancel() {
    workItem?.cancel()
  }
}
