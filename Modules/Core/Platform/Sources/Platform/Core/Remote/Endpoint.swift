import Foundation

struct Endpoint {
  let baseURL: String
  let pathList: [String]
  let header: [String: String]
  let httpMethod: HttpMethod
  let content: HttpContent?

  init(
    baseURL: String,
    pathList: [String],
    header: [String: String] = [:],
    httpMethod: HttpMethod = .get,
    content: HttpContent?)
  {
    self.baseURL = baseURL
    self.pathList = pathList
    self.header = header
    self.httpMethod = httpMethod
    self.content = content
  }
}
