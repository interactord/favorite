import Architecture
import Domain
import Foundation
import LinkNavigator

@Observable
final class AppViewModel {

  // MARK: Lifecycle

  init(linkNavigator: SingleLinkNavigator) {
    self.linkNavigator = linkNavigator
  }

  // MARK: Internal

  let linkNavigator: SingleLinkNavigator
}
