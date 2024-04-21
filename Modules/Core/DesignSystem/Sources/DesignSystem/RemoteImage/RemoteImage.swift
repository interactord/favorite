import SDWebImage
import SDWebImageSwiftUI
import SwiftUI

// MARK: - RemoteImage

public struct RemoteImage<Content: View> {

  // MARK: Lifecycle

  public init(
    url: String,
    isLoading: Binding<Bool> = .constant(false),
    aspectRatio: CGFloat? = .none,
    contentMode: ContentMode = .fit)
  {
    self.url = url
    self.isLoading = isLoading
    self.aspectRatio = aspectRatio
    self.contentMode = contentMode
    placeholder = .none

    _ = IsolateImageCoderManager.declare
  }

  public init(
    url: String,
    isLoading: Binding<Bool> = .constant(false),
    aspectRatio: CGFloat? = .none,
    contentMode: ContentMode = .fit,
    @ViewBuilder placeholder: @escaping () -> Content?)
  {
    self.url = url
    self.isLoading = isLoading
    self.aspectRatio = aspectRatio
    self.contentMode = contentMode
    self.placeholder = placeholder()

    _ = IsolateImageCoderManager.declare
  }

  // MARK: Internal

  let url: String
  let isLoading: Binding<Bool>
  let aspectRatio: CGFloat?
  let contentMode: ContentMode
  let placeholder: Content?
}

// MARK: View

extension RemoteImage: View {

  public var body: some View {
    if let placeholder {
      WebImage(url: .init(string: url))
        .placeholder(content: { placeholder })
        .onSuccess { _, _, _ in
          isLoading.wrappedValue = false
        }
        .onProgress { _, _ in
          isLoading.wrappedValue = true
        }
        .resizable()
        .aspectRatio(aspectRatio, contentMode: contentMode)
    } else {
      WebImage(url: .init(string: url))
        .onSuccess { _, _, _ in
          isLoading.wrappedValue = false
        }
        .onProgress { _, _ in
          isLoading.wrappedValue = true
        }
        .resizable()
        .aspectRatio(aspectRatio, contentMode: contentMode)
    }
  }
}

// MARK: - IsolateImageCoderManager

private final class IsolateImageCoderManager {

  // MARK: Lifecycle

  private init() { }

  // MARK: Internal

  static let declare = IsolateImageCoderManager()

}
