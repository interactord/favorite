import Foundation
import Domain
import SwiftUI
import DesignSystem

extension UserDetailPage {
  struct ProfileSection {
    let viewState: ViewState
  }
}

extension UserDetailPage.ProfileSection {
}

extension UserDetailPage.ProfileSection: View {
  var body: some View {
    VStack(spacing: 8) {
      HStack(alignment: .top, spacing: 8) {
        RemoteImage<EmptyView>(url: viewState.item.avatarURL)
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 8))

        VStack(alignment: .leading, spacing: 4) {
          Text(viewState.item.login)
            .font(.title)
          if let name = viewState.item.name {
            Text(name)
              .font(.body)
          }
          if let location = viewState.item.location {
            HStack {
              Image(systemName: "mappin.and.ellipse")
                .resizable()
                .frame(width: 12, height: 12)

              Text(location)
                .font(.footnote)
            }
          }
        }

        Spacer(minLength: .zero)
      }

      Text(viewState.item.bio)
    }

  }
}

extension UserDetailPage.ProfileSection {
  struct ViewState: Equatable {
    let item: GithubEntity.Detail.User.Response
  }
}


