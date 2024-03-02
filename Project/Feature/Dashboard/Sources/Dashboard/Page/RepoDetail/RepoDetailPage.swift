import ComposableArchitecture
import SwiftUI

// MARK: - RepoDetailPage

struct RepoDetailPage {
  @Bindable var store: StoreOf<RepoDetailReducer>
}

extension RepoDetailPage {
  var shareURL: URL? {
    guard let str = store.fetchDetailItem.value?.htmlURL else { return .none }
    return .init(string: str)
  }

  var navigationTitle: String {
    store.fetchDetailItem.value?.fullName ?? ""
  }
}

// MARK: View

extension RepoDetailPage: View {
  var body: some View {
    VStack {
      if let item = store.fetchDetailItem.value {
        WebContent(viewState: .init(item: item))
      } else {
        Text("로딩중...")
      }

    }
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      if let shareURL {
        ToolbarItem(placement: .topBarTrailing) {
          ShareLink(item: shareURL) {
            Image(systemName: "square.and.arrow.up")
          }
        }
      }
    }
    .onAppear {
      store.send(.getDetail)
    }
    .onDisappear {
      store.send(.teardown)
    }

  }
}
