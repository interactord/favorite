import DesignSystem
import Domain
import SwiftUI

// MARK: - UserPage.UserItemComponent

extension UserPage {
  struct UserItemComponent {
    let viewState: ViewState
    let action: (GithubEntity.Search.User.Item) -> Void
  }
}

extension UserPage.UserItemComponent { }

// MARK: - UserPage.UserItemComponent + View

extension UserPage.UserItemComponent: View {
  var body: some View {
    VStack(spacing: 8) {
      RemoteImage(
        url: viewState.item.avatarUrl,
        placeholder: {
          Rectangle()
            .fill(DesignSystemColor.palette(.gray(.lv100)).color)
        })
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 10))

      Text(viewState.item.loginName)
        .font(.system(size: 14, weight: .bold))
        .foregroundStyle(DesignSystemColor.system(.black).color)
    }
    .frame(width: 80, height: 120)
    .padding(4)
    .onTapGesture {
      action(viewState.item)
    }
  }
}

// MARK: - UserPage.UserItemComponent.ViewState

extension UserPage.UserItemComponent {
  struct ViewState: Equatable {
    let item: GithubEntity.Search.User.Item
  }

}
