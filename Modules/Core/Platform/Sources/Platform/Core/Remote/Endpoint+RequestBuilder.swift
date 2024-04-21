import Foundation
import URLEncodedForm

extension Endpoint {
  var request: URLRequest? {
    baseURL
      .component?
      .apply(pathList: pathList)
      .apply(content: content)
      .request?
      .apply(header: header)
      .apply(httpMethod: httpMethod)
      .apply(content: content)
  }
}

extension String {
  fileprivate var component: URLComponents? {
    .init(string: self)
  }
}

extension URLComponents {
  fileprivate var request: URLRequest? {
    guard let url else { return .none }
    return .init(url: url)
  }

  fileprivate func apply(pathList: [String]) -> Self {
    var new = self
    new.path = ([path] + pathList).joined(separator: "/")
    return new
  }

  fileprivate func apply(content: Endpoint.HttpContent?) -> Self {
    guard let content else { return self }
    guard case .queryItemPath(let item) = content
    else { return self }

    var new = self
    let newQuery = item.encodeString()
    new.query = newQuery

    return new
  }
}

extension URLRequest {
  fileprivate func apply(content: Endpoint.HttpContent?) -> Self {
    guard let content else { return self }

    switch content {
    case .queryItemPath: return self
    case .bodyItem(let item):
      return {
        guard let data = try? JSONEncoder().encode(item) else { return self }

        var new = self
        new.setValue("application/json", forHTTPHeaderField: "Content-Type")
        new.httpBody = data
        return new
      }()
    case .bodyURLEncoded(let item):
      return {
        guard let data = item.encodeString().data(using: .utf8) else { return self }
        var new = self
        new.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        new.httpBody = data
        return new
      }()
    }
  }

  fileprivate func apply(httpMethod: HttpMethod) -> Self {
    var new = self
    new.httpMethod = httpMethod.rawValue
    return new
  }

  fileprivate func apply(header: [String: String]) -> Self {
    var new = self

    for headerItem in header {
      new.setValue(headerItem.value, forHTTPHeaderField: headerItem.key)
    }
    return new
  }
}
