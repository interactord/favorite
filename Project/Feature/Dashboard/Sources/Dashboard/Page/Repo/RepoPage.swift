import ComposableArchitecture
import SwiftUI

// MARK: - RepoPage

struct RepoPage {
  @Bindable var store: StoreOf<RepoStore>
}

// MARK: View

extension RepoPage: View {
  var body: some View {
    Text("RepoPage")
  }
}
