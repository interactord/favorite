import Foundation
import Domain

public struct DataResponseMock<T: Codable & Sendable & Equatable>: Equatable, Sendable {
  let successValue: T
  let failureValue: CompositeErrorRepository
}
