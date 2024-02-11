import SwiftUI

// MARK: - AppFrontView

public struct AppFrontView {
  let viewModel: ToastViewModel

  public init(viewModel: ToastViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: View

extension AppFrontView: View {

  public var body: some View {
    ZStack {
      Toast(message: viewModel.message, type: .default)
        .onTapGesture {
          viewModel.clear()
        }

      Toast(message: viewModel.errorMessage, type: .error)
        .onTapGesture {
          viewModel.clear()
        }
    }
  }
}
