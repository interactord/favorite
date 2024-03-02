import ComposableArchitecture
import SwiftUI

// MARK: - UserDetailPage

struct UserDetailPage {
  @Bindable var store: StoreOf<UserDetailReducer>
}

// MARK: View

extension UserDetailPage: View {
  var body: some View {
    VStack {
      Spacer()
      Text("UserDetailPage")
      Spacer()
    }
    .onAppear {
      store.send(.getDetail(store.user))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
