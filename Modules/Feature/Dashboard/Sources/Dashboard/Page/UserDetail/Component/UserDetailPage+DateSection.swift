import Domain
import Foundation
import SwiftUI

// MARK: - UserDetailPage.DateSection

extension UserDetailPage {
  struct DateSection {
    let viewState: ViewState
  }
}

extension UserDetailPage.DateSection {
  var createDate: String {
    viewState.item.createDate.toDate?.toFormatString ?? "N/A"
  }

  var updateDate: String {
    viewState.item.updateDate.toDate?.toFormatString ?? "N/A"
  }
}

// MARK: - UserDetailPage.DateSection + View

extension UserDetailPage.DateSection: View {
  var body: some View {
    VStack(spacing: 4) {
      Text("Created at: \(createDate)")
        .font(.footnote)

      Text("Created at: \(updateDate)")
        .font(.footnote)
    }
  }
}

// MARK: - UserDetailPage.DateSection.ViewState

extension UserDetailPage.DateSection {
  struct ViewState: Equatable {
    let item: GithubEntity.Detail.User.Response
  }
}

extension String {
  fileprivate var toDate: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter.date(from: self)
  }
}

extension Date {
  fileprivate var toFormatString: String? {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self)
  }
}
