import SwiftUI

public enum DesignSystemIcon {

  case arrow
  case back
  case bell
  case memo
  case mic
  case setting
  case timer
  case todo
  case pencil
  case unChecked
  case checked
  case delete

  // MARK: Public

  public var image: Image {
    var image: Image {
      switch self {
      case .arrow: Asset.Icon.icArrow.swiftUIImage
      case .back: Asset.Icon.icBack.swiftUIImage
      case .bell: Asset.Icon.icBell.swiftUIImage
      case .memo: Asset.Icon.icMemo.swiftUIImage
      case .mic: Asset.Icon.icMic.swiftUIImage
      case .setting: Asset.Icon.icSetting.swiftUIImage
      case .timer: Asset.Icon.icTimer.swiftUIImage
      case .todo: Asset.Icon.icTodo.swiftUIImage
      case .pencil: Image(systemName: "pencil")
      case .unChecked: Image(systemName: "rectangle")
      case .checked: Image(systemName: "checkmark.rectangle")
      case .delete: Image(systemName: "trash")
      }
    }

    return image.renderingMode(.template)
  }

}
