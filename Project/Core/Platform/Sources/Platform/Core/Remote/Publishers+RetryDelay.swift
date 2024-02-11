import Combine
import Foundation

extension Publisher {

  public func retry<S: Scheduler>(
    _ max: Int = Int.max,
    delay: Publishers.RetryDelay<Self, S>.TimingFunction,
    scheduler: S) -> Publishers.RetryDelay<Self, S>
  {
    .init(upstream: self, max: max, delay: delay, scheduler: scheduler)
  }
}

// MARK: - Publishers.RetryDelay

extension Publishers {

  public struct RetryDelay<Upstream: Publisher, S: Scheduler>: Publisher {

    // MARK: Lifecycle

    public init(upstream: Upstream, retries: Int = 0, max: Int, delay: TimingFunction, scheduler: S) {
      self.upstream = upstream
      self.retries = retries
      self.max = max
      self.delay = delay
      self.scheduler = scheduler
    }

    // MARK: Public

    public typealias Output = Upstream.Output
    public typealias Failure = Upstream.Failure

    public let upstream: Upstream
    public let retries: Int
    public let max: Int
    public let delay: TimingFunction
    public let scheduler: S

    public func receive<T: Subscriber>(subscriber: T) where Upstream.Failure == T.Failure, Upstream.Output == T.Input {
      upstream.catch { e -> AnyPublisher<Output, Failure> in
        guard retries < max else { return Fail(error: e).eraseToAnyPublisher() }
        return Fail(error: e)
          .delay(for: .seconds(delay(retries + 1)), scheduler: scheduler)
          .catch { _ in
            RetryDelay(
              upstream: upstream,
              retries: retries + 1,
              max: max,
              delay: delay,
              scheduler: scheduler)
          }
          .eraseToAnyPublisher()
      }
      .subscribe(subscriber)
    }
  }
}

// MARK: - Publishers.RetryDelay.TimingFunction

extension Publishers.RetryDelay {
  public typealias TimingFunction = RetryDelayTimingFunction
}

// MARK: - RetryDelayTimingFunction

public struct RetryDelayTimingFunction {

  let function: (Int) -> TimeInterval

  public init(_ function: @escaping (Int) -> TimeInterval) {
    self.function = function
  }

  public func callAsFunction(_ n: Int) -> TimeInterval {
    function(n)
  }
}

extension Publishers.RetryDelay.TimingFunction {
  public static let immediate: Self = .after(seconds: 0)

  public static func after(seconds time: TimeInterval) -> Self { .init(time) }
  public static func exponential(unit: TimeInterval = 0.5) -> Self {
    .init { n in
      TimeInterval.random(in: unit ... unit * pow(2, TimeInterval(n - 1)))
    }
  }
}

// MARK: - Publishers.RetryDelay.TimingFunction + ExpressibleByFloatLiteral

extension Publishers.RetryDelay.TimingFunction: ExpressibleByFloatLiteral {

  public init(_ value: TimeInterval) {
    self.init { _ in value }
  }

  public init(floatLiteral value: TimeInterval) {
    self.init(value)
  }
}
