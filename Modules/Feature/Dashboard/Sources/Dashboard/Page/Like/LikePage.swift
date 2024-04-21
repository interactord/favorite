import ComposableArchitecture
import SwiftUI

// MARK: - LikePage

struct LikePage {
  @Bindable var store: StoreOf<LikeReducer>
}

// MARK: View

extension LikePage: View {
  var body: some View {
    Text("LikePage")
  }
}
