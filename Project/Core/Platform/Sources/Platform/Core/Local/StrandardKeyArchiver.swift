import Domain
import Foundation

// MARK: - StandardKeyArchiver

@propertyWrapper
struct StandardKeyArchiver<T: Codable> {

  // MARK: Lifecycle

  init(defaultValue: T) {
    key = String(describing: T.self)
    self.defaultValue =
    (try? KeyArchiver().load(name: key))
    ?? (try? KeyArchiver().saved(model: defaultValue, name: key))
    ?? defaultValue
  }

  // MARK: Internal

  var wrappedValue: T {
    get {
      do {
        return try KeyArchiver().load(name: key)
      } catch {
        print("Error \(#function) ", error)
        return defaultValue
      }
    }

    set {
      do {
        try KeyArchiver().saved(model: newValue, name: key)
      } catch {
        print("Error \(#function) ", error)
      }
    }
  }

  var sync: (T) -> Void {
    {
      var newStore = self
      newStore.wrappedValue = $0
    }
  }

  // MARK: Private

  private let key: String
  private let defaultValue: T

}

// MARK: - KeyArchiver

private struct KeyArchiver {

  // MARK: Internal

  @discardableResult
  func saved<T: Encodable>(model: T, name: String) throws -> T {
    let fullPath = try documentDirectory().appendingPathComponent(name)
    let data = try JSONEncoder().encode(model)
    let archiveData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
    try archiveData.write(to: fullPath)
    return model
  }

  func load<T: Decodable>(name: String) throws -> T {
    let fullPath = try documentDirectory().appendingPathComponent(name)
    let fileData = try NSData(contentsOf: fullPath) as Data
    guard let data = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSData.self, from: fileData) as? Data
    else { throw CompositeErrorRepository.invalidTypeCasting }
    let model = try JSONDecoder().decode(T.self, from: data)
    return model
  }

  // MARK: Private

  private func documentDirectory() throws -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    guard let path = paths.first else {
      throw CompositeErrorRepository.invalidTypeCasting
    }
    return path
  }
}
