import ComposableArchitecture
import SwiftUI

// MARK: - UserPage

struct UserPage {
  @Bindable var store: StoreOf<UserStore>
}

// MARK: View

extension UserPage: View {
  var body: some View {
    Text("UserPage")
  }
}
