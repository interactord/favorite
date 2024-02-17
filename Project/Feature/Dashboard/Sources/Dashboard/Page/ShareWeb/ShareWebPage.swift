import ComposableArchitecture
import SwiftUI

// MARK: - ShareWebPage

struct ShareWebPage {
  @Bindable var store: StoreOf<ShareWebStore>
}

// MARK: View

extension ShareWebPage: View {
  var body: some View {
    VStack {
      Text("ShareWebPage \(store.item.desc ?? "")")
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: {}) {
          Text("나오냐?")
        }
      }
    }
  }
}
