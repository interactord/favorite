import ComposableArchitecture
import Domain
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
      if let detailItem = store.fetchDetailItem.value {
        ToolbarItem(placement: .topBarTrailing) {
          LikeComponent(
            viewState: .init(
              isLike: store.fetchIsLike.value,
              item: detailItem),
            likeAction: { store.send(.updateIsLike($0)) })
        }
      }

      if let shareURL {
        ToolbarItem(placement: .topBarTrailing) {
          ShareLink(item: shareURL) {
            Image(systemName: "square.and.arrow.up")
          }
        }
      }
    }
    .onChange(of: store.fetchDetailItem.value) { _, new in
      store.send(.getIsLike(new))
    }
    .onAppear {
      store.send(.getDetail)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}

// MARK: RepoDetailPage.LikeComponent

extension RepoDetailPage {
  struct LikeComponent {
    let viewState: ViewState
    let likeAction: (GithubEntity.Detail.Repository.Response) -> Void
  }
}

extension RepoDetailPage.LikeComponent {
  private var likeImage: Image {
    Image(systemName: viewState.isLike ? "heart.fill" : "heart")
  }
}

// MARK: - RepoDetailPage.LikeComponent + View

extension RepoDetailPage.LikeComponent: View {
  var body: some View {
    Button(action: { likeAction(viewState.item) }) {
      likeImage
        .resizable()
    }
  }
}

// MARK: - RepoDetailPage.LikeComponent.ViewState

extension RepoDetailPage.LikeComponent {
  struct ViewState: Equatable {
    let isLike: Bool
    let item: GithubEntity.Detail.Repository.Response
  }
}
