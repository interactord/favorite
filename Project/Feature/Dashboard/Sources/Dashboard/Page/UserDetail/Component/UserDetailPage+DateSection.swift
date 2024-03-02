import Foundation
import Domain
import SwiftUI

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
