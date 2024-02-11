import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - RepoPage

struct RepoPage {
  @Bindable var store: StoreOf<RepoStore>
}

extension RepoPage {
  private var searchViewState: SearchBar.ViewState {
    .init(text: $store.query)
  }
}

// MARK: View

extension RepoPage: View {
  var body: some View {
    NavigationStack {
      VStack {
        SearchBar(viewState: searchViewState, throttleAction: {
          store.send(.search(store.query))
        })
        ScrollView {
          LazyVStack(spacing: .zero, content: {
            ForEach(store.itemList, id: \.id) {
              RepositoryItemComponent(
                action: { print($0) },
                viewState: .init(item: $0))
            }
          })
        }
      }
      .scrollDismissesKeyboard(.immediately)
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Repository")
    .onAppear {
      store.send(.search(store.query))
    }
  }
}
