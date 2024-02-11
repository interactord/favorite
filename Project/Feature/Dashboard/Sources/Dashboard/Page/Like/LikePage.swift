import SwiftUI
import ComposableArchitecture

struct LikePage {
  @Bindable var store: StoreOf<LikeStore>
}

extension LikePage: View {
  var body: some View {
    Text("LikePage")
  }
}
