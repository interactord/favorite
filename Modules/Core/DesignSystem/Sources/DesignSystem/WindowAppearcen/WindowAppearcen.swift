import Foundation
import UIKit

public enum WindowAppearance {
  static var safeArea: UIEdgeInsets {
    guard 
      let windowScene = UIApplication.shared.connectedScenes.first(where: {
        $0.activationState == .foregroundActive
          || $0.activationState == .foregroundInactive
      }) as? UIWindowScene,
      let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow })
    else { return .zero }
    return keyWindow.safeAreaInsets
  }
}
