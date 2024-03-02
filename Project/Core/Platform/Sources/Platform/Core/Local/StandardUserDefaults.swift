import Foundation

// MARK: - StandardUseDefaults

@propertyWrapper
struct StandardUseDefaults<T: Codable> {
  private let key: String
  private let defaultValue: T

  init(defaultValue: T) {
    key = String(describing: T.self)
    self.defaultValue = defaultValue
  }

  var wrappedValue: T {
    get { UserDefaults.standard.get() ?? defaultValue }
    set { UserDefaults.standard.set(value: newValue) }
  }
}

extension UserDefaults {

  func get<D: Decodable>(key: String = String(describing: D.self)) -> D? {
    let loadData = UserDefaults.standard.object(forKey: key) as? Data ?? Data()
    return try? JSONDecoder().decode(D.self, from: loadData)
  }

  func set<E: Encodable>(value: E, key: String = String(describing: E.self)) {
    guard let rawData = try? JSONEncoder().encode(value) else { return }
    UserDefaults.standard.set(rawData, forKey: key)
  }
}
