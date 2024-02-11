import CasePaths
import SwiftUI

extension Binding {

  // MARK: Lifecycle

  public init?(wrapping base: Binding<Value?>) {
    self.init(wrapping: base, case: /Optional.some)
  }

  public init?<Enum>(wrapping enum: Binding<Enum>, case casePath: AnyCasePath<Enum, Value>) {
    guard var `case` = casePath.extract(from: `enum`.wrappedValue) else { return nil }

    self.init(
      get: {
        `case` = casePath.extract(from: `enum`.wrappedValue) ?? `case`
        return `case`
      },
      set: {
        `case` = $0
        `enum`.transaction($1).wrappedValue = casePath.embed($0)
      })
  }

  // MARK: Public

  public func `case`<Enum, Case>(_ casePath: AnyCasePath<Enum, Case>) -> Binding<Case?> where Value == Enum? {
    .init(
      get: { wrappedValue.flatMap(casePath.extract(from:)) },
      set: { newValue, transaction in
        self.transaction(transaction).wrappedValue = newValue.map(casePath.embed)
      })
  }

  public func isPresent<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
    .init(
      get: { wrappedValue != nil },
      set: { isPresent, transaction in
        if !isPresent {
          self.transaction(transaction).wrappedValue = .none
        }
      })
  }

  public func isPresent<Enum, Case>(_ casePath: AnyCasePath<Enum, Case>) -> Binding<Bool> where Value == Enum? {
    self.case(casePath).isPresent()
  }

}
