import ComposableArchitecture
import SwiftUI

// MARK: - UserDetailPage

struct UserDetailPage {
  @Bindable var store: StoreOf<UserDetailStore>
}

// MARK: View

extension UserDetailPage: View {
  var body: some View {
    Text("UserDetailPage")
  }
}
