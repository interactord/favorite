import Domain
import Foundation

public struct DataResponseMock<T: Codable & Sendable & Equatable>: Equatable, Sendable {
  public let successValue: T
  public let failureValue: CompositeErrorRepository
}
