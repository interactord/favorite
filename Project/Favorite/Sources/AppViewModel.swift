import Architecture
import Domain
import Foundation
import LinkNavigator

@Observable
final class AppViewModel {

  // MARK: Lifecycle

  init(linkNavigator: TabLinkNavigator) {
    self.linkNavigator = linkNavigator
  }

  // MARK: Internal

  let linkNavigator: TabLinkNavigator
}
