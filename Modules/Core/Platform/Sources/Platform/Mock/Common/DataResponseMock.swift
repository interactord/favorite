import Domain
import Foundation

public struct DataResponseMock<T: Codable & Sendable & Equatable>: Equatable, Sendable {
  let successValue: T
  let failureValue: CompositeErrorRepository
}
