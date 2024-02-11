import Foundation
import URLEncodedForm

extension Endpoint {
  enum HttpContent {
    case queryItemPath(Encodable)
    case bodyItem(Encodable)
    case bodyURLEncoded(Encodable)
  }
}
