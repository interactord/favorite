import ComposableArchitecture
import SwiftUI

// MARK: - RepoPage

struct RepoPage {
  @Bindable var store: StoreOf<RepoStore>
}

// MARK: View

extension RepoPage: View {
  var body: some View {
    NavigationStack {
      ScrollView {
        Text("AAAA")
      }
    }
    .searchable(text: $store.query)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Repository")
    .onAppear {
      store.send(.search(store.query))
    }
  }
}
