import SwiftUI

// MARK: - DesignSystemNavigationBar

public struct DesignSystemNavigationBar {

  let backAction: (() -> Void)?
  let moreActionList: [MoreAction]

  public init(
    backAction: (() -> Void)? = .none,
    moreActionList: [MoreAction] = [])
  {
    self.backAction = backAction
    self.moreActionList = moreActionList
  }
}

extension DesignSystemNavigationBar {
  var tintColor: Color {
    DesignSystemColor.system(.black).color
  }

  var maxHeight: Double { 44 }
}

// MARK: View

extension DesignSystemNavigationBar: View {

  public var body: some View {
    Rectangle()
      .fill(.white)
      .overlay(alignment: .topLeading) {
        if let backAction {
          Button(action: backAction) {
            DesignSystemIcon.back.image
              .resizable()
              .frame(width: 34, height: 34, alignment: .top)
              .foregroundStyle(tintColor)
          }
          .padding(.top, 5)

        } else {
          EmptyView()
        }
      }
      .overlay(alignment: .trailing) {
        HStack(spacing: 8) {
          ForEach(moreActionList, id: \.id) { item in
            Button(action: item.action) {
              Text(item.title)
                .font(.system(size: 14, weight: .regular, design: .default))
                .multilineTextAlignment(.trailing)
                .foregroundStyle(tintColor)
                .fixedSize(horizontal: false, vertical: true)
                .frame(minWidth: 40)
            }
          }
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: maxHeight)
  }
}

// MARK: DesignSystemNavigationBar.MoreAction

extension DesignSystemNavigationBar {
  public struct MoreAction: Equatable, Identifiable {
    let title: String
    let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
      self.title = title
      self.action = action
    }

    public var id: String { title }

    public static func == (lhs: Self, rhs: Self) -> Bool {
      lhs.title == rhs.title
    }
  }
}

#Preview(body: {
  VStack {
    DesignSystemNavigationBar(
      backAction: { },
      moreActionList: [
        .init(title: "Create", action: { }),
        .init(title: "Done", action: { }),
      ])
    Spacer()
  }
})
