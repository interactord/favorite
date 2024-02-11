import SwiftUI

// MARK: - DesignSystemNavigation

public struct DesignSystemNavigation<Content: View> {
  let barItem: DesignSystemNavigationBar?
  let title: String?
  let content: Content

  public init(
    barItem: DesignSystemNavigationBar? = .none,
    title: String?,
    @ViewBuilder content: @escaping () -> Content)
  {
    self.barItem = barItem
    self.title = title
    self.content = content()
  }
}

extension DesignSystemNavigation {
  var titleTopMargin: Double {
    barItem == nil ? 48 : 32
  }
}

// MARK: View

extension DesignSystemNavigation: View {
  public var body: some View {
    VStack(alignment: .leading) {
      if let barItem {
        barItem
          .padding(.leading, 32)
          .padding(.trailing, 32)
      }
      ScrollView {
        if let title {
          Text(title)
            .font(.system(size: 30, weight: .bold, design: .default))
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, titleTopMargin)
        }
        content
          .padding(.top, 16)

//        Spacer(minLength: .zero)
      }
    }
    .frame(minWidth: .zero, maxWidth: .infinity)
    .frame(minHeight: .zero, maxHeight: .infinity)
  }
}

#Preview("Case1") {
  DesignSystemNavigation(
    barItem: .init(
      backAction: { },
      moreActionList: [
        .init(title: "more", action: { }),
      ]),
    title: "메모장")
  {
//      Text("asdjkasldjkasda")
//      Text("asdjkasldjkasda")
  }
}

#Preview("Case2") {
  DesignSystemNavigation(
    title: "메모장")
  {
//      Text("asdjkasldjkasda")
//      Text("asdjkasldjkasda")
  }
}
