import CasePaths
import Domain
import SwiftUI

extension View {

  // MARK: Public

  public func sheet<Enum, Case>(
    unwrapping enum: Binding<Enum?>,
    case casePath: AnyCasePath<Enum, Case>,
    onDismiss: (() -> Void)? = .none,
    @ViewBuilder content: @escaping (Binding<Case>) -> some View)
    -> some View
  {
    sheet(
      unwrapping: `enum`.case(casePath),
      onDismiss: onDismiss,
      content: content)
  }

  // MARK: Private

  private func sheet<Value>(
    unwrapping value: Binding<Value?>,
    onDismiss: (() -> Void)? = .none,
    @ViewBuilder content: @escaping (Binding<Value>) -> some View)
    -> some View
  {
    sheet(isPresented: value.isPresent(), onDismiss: onDismiss) {
      Binding(wrapping: value).map(content)
    }
  }

}

extension View {

  // MARK: Public

  public func fullScreenCover<Enum, Case>(
    unwrapping enum: Binding<Enum?>,
    case casePath: AnyCasePath<Enum, Case>,
    @ViewBuilder content: @escaping (Binding<Case>) -> some View)
    -> some View
  {
    fullScreenCover(
      unwrapping: `enum`.case(casePath),
      content: content)
  }

  // MARK: Private

  private func fullScreenCover<Value>(
    unwrapping value: Binding<Value?>,
    @ViewBuilder content: @escaping (Binding<Value>) -> some View)
    -> some View
  {
    fullScreenCover(isPresented: value.isPresent()) {
      Binding(wrapping: value).map(content)
    }
  }

}
