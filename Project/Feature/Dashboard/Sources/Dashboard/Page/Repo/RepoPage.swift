import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - RepoPage

struct RepoPage {
  @Bindable var store: StoreOf<RepoReducer>
  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)
}

extension RepoPage {
  private var searchViewState: SearchBar.ViewState {
    .init(text: $store.query)
  }
}

// MARK: View

extension RepoPage: View {
  var body: some View {
    ScrollView {
      LazyVStack(spacing: .zero, content: {
        ForEach(store.itemList, id: \.id) { item in
          RepositoryItemComponent(
            action: { store.send(.routeToDetail($0)) },
            viewState: .init(item: item))
            .onAppear {
              guard let last = store.itemList.last, last.id == item.id else { return }
              guard !store.fetchSearchItem.isLoading else { return }
              store.send(.search(store.query))
            }
        }
      })
    }
    .scrollDismissesKeyboard(.immediately)
    .navigationBarTitleDisplayMode(.large)
    .navigationTitle("Repository")
    .searchable(text: $store.query, placement: .automatic)
    .onChange(of: store.query) { _, new in
      throttleEvent.update(value: new)
    }
    .onAppear {
      throttleEvent.apply { _ in
        store.send(.search(store.query))
      }
    }
    .onDisappear {
      throttleEvent.reset()
      store.send(.teardown)
    }
  }
}
