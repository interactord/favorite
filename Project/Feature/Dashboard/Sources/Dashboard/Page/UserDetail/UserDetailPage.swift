import ComposableArchitecture
import Domain
import SwiftUI

// MARK: - UserDetailPage

struct UserDetailPage {
  @Bindable var store: StoreOf<UserDetailReducer>
}

extension UserDetailPage {
  private var profileSectionViewState: ProfileSection.ViewState? {
    guard let item = store.fetchDetail.value else { return .none }
    return .init(item: item)
  }

  private var infoSectionViewState: InfoSection.ViewState? {
    guard let item = store.fetchDetail.value else { return .none }
    return .init(item: item)
  }

  private var dateSectionViewState: DateSection.ViewState? {
    guard let item = store.fetchDetail.value else { return .none }
    return .init(item: item)
  }
}

// MARK: View

extension UserDetailPage: View {
  var body: some View {
    VStack {
      if let viewState = profileSectionViewState {
        ProfileSection(viewState: viewState)
      }
      if let viewState = infoSectionViewState {
        InfoSection(viewState: viewState)
      }
      if let viewState = dateSectionViewState {
        DateSection(viewState: viewState)
      }
    }
    .onAppear {
//      store.send(.getDetail(store.user))
      store.send(.getMock)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}

