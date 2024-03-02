import Architecture
import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - UserPage

struct UserPage {
  @Bindable var store: StoreOf<UserReducer>
  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)
}

extension UserPage {
  private var searchViewState: SearchBar.ViewState {
    .init(text: $store.query)
  }

  private var gridColumnList: [GridItem] {
    Array(
      repeating: .init(.flexible()),
      count: UIDevice.current.userInterfaceIdiom == .pad ? 6 : 3)
  }
}

// MARK: View

extension UserPage: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridColumnList, spacing: .zero) {
        ForEach(store.itemList, id: \.id) { item in
          UserItemComponent(
            viewState: .init(item: item),
            action: { _ in })
            .onAppear {
              guard let last = store.itemList.last, last.id == item.id else { return }
              guard !store.fetchSearchItem.isLoading else { return }
              store.send(.search(store.query))
            }
        }
      }
    }
    .scrollDismissesKeyboard(.immediately)
    .navigationBarTitleDisplayMode(.large)
    .navigationTitle("User")
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
