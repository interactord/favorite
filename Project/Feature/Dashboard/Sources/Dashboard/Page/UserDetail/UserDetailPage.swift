import ComposableArchitecture
import SwiftUI

// MARK: - UserDetailPage

struct UserDetailPage {
  @Bindable var store: StoreOf<UserDetailReducer>
}

// MARK: View

extension UserDetailPage: View {
  var body: some View {
    Text("UserDetailPage")
  }
}
