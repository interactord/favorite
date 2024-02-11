import DesignSystem
import SwiftUI

// MARK: - Toast

public struct Toast {

  private let message: String
  private let type: ToastType

  public init(
    message: String,
    type: ToastType)
  {
    self.message = message
    self.type = type
  }

}

// MARK: Toast.ToastType

extension Toast {
  public enum ToastType: Equatable {
    case `default`
    case error

    var backgroundColor: Color {
      switch self {
      case .default:
        DesignSystemColor.overlay(.default).color
      case .error:
        DesignSystemColor.error(.default).color
      }
    }
  }
}

// MARK: View

extension Toast: View {
  public var body: some View {
    VStack {
      Spacer()

      if !message.isEmpty {
        HStack {
          Text(message)
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .background(type.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .padding(.horizontal, 16)
      }
    }
    .padding(.bottom, 24)
    .transition(.opacity)
    .animation(.spring(), value: message.isEmpty)
  }
}
