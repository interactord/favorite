import ComposableArchitecture
import SwiftUI

// MARK: - ShareWebPage

struct ShareWebPage {
  @Bindable var store: StoreOf<ShareWebStore>
}

extension ShareWebPage {
  var shareURL: URL? {
    guard let str = store.item.htmlURL else { return .none }
    return .init(string: str)
  }
}

// MARK: View

extension ShareWebPage: View {
  var body: some View {
    VStack {
      WebContent(viewState: .init(item: store.item))
    }
    .toolbar {
      if let shareURL {
        ToolbarItem(placement: .topBarTrailing) {
          ShareLink(item: shareURL) {
            Image(systemName: "square.and.arrow.up")
          }
        }
      }
    }
    .navigationTitle(store.item.fullName)
    .navigationBarTitleDisplayMode(.inline)
  }
}
