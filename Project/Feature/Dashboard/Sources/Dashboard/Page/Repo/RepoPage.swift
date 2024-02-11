import SwiftUI
import ComposableArchitecture

struct RepoPage {
  @Bindable var store: StoreOf<RepoStore>
}

extension RepoPage: View {
  var body: some View {
    Text("RepoPage")
  }
}
