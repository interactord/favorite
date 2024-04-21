import Foundation

extension Encodable {
  public func json() throws -> String {
    String(data: try data(), encoding: .utf8) ?? ""
  }

  public func jsonPrettyPrinted() throws -> String? {
    let data = try dataPrettyPrinted()
    return data.prettyJson
  }

  public func jsonDateFormatted(with dateFormatter: DateFormatter) throws -> String {
    String(data: try dataDateFormatted(with: dateFormatter), encoding: .utf8) ?? ""
  }
}

extension Encodable {

  // MARK: Fileprivate

  fileprivate func data(using encoder: JSONEncoder = .iso8601) throws -> Data {
    try encoder.encode(self)
  }

  // MARK: Private

  private func dataPrettyPrinted() throws -> Data {
    try JSONEncoder.iso8601PrettyPrinted.encode(self)
  }

  // edit if you need the data using a custom date formatter
  private func dataDateFormatted(with dateFormatter: DateFormatter) throws -> Data {
    JSONEncoder.shared.dateEncodingStrategy = .formatted(dateFormatter)
    return try JSONEncoder.shared.encode(self)
  }
}

extension Data {
  fileprivate var prettyJson: String? {
    guard
      let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
      let prettyPrintedString = String(data: data, encoding: .utf8)
    else { return nil }

    return prettyPrintedString
  }
}
