import Domain
import Foundation
import SwiftUI

// MARK: - UserDetailPage.InfoSection

extension UserDetailPage {
  struct InfoSection {
    let viewState: ViewState
  }
}

extension UserDetailPage.InfoSection { }

// MARK: - UserDetailPage.InfoSection + View

extension UserDetailPage.InfoSection: View {
  var body: some View {
    VStack(spacing: 16) {
      VStack(spacing: 8) {
        HStack(alignment: .top, spacing: 8) {
          IconTitle(
            iconName: "folder",
            title: "Public repos",
            count: viewState.item.publicRepoCount)
            .background(.cyan)
          Spacer(minLength: 16)
          IconTitle(
            iconName: "text.alignleft",
            title: "Public gists",
            count: viewState.item.publicGistCount)
            .background(.red)
        }

        Button(action: { }) {
          Text("Github Profile")
            .foregroundStyle(.purple)
        }
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(.purple.opacity(0.8)))
        .padding(8)
        .frame(maxWidth: .infinity)
      }
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(.black.opacity(0.8)))

      VStack(spacing: 8) {
        HStack(alignment: .top, spacing: 8) {
          IconTitle(
            iconName: "heart",
            title: "Followers",
            count: viewState.item.followerListCount)

          Spacer(minLength: 16)

          IconTitle(
            iconName: "person.2",
            title: "Following",
            count: viewState.item.followingListCount)
        }

        Button(action: { }) {
          Text("Github Profile")
            .foregroundStyle(.green)
        }
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(.green.opacity(0.8)))
        .padding(8)
        .frame(maxWidth: .infinity)
      }
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(.black.opacity(0.8)))
    }
  }
}

// MARK: - UserDetailPage.InfoSection.ViewState

extension UserDetailPage.InfoSection {
  struct ViewState: Equatable {
    let item: GithubEntity.Detail.User.Response
  }
}

// MARK: - IconTitle

private struct IconTitle: View {
  let iconName: String
  let title: String
  let count: Int

  var body: some View {
    VStack(spacing: 4) {
      HStack(alignment: .center) {
        Image(systemName: iconName)
          .resizable()
          .frame(width: 14, height: 14)
        Text(title)
          .font(.headline)

        Spacer(minLength: .zero)
      }
      Text("\(count)")
        .font(.headline)
    }
  }
}
