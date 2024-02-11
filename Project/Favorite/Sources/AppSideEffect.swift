import Architecture
import Domain
import Foundation
import LinkNavigator
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType {
  let toastViewModel: ToastViewModel
}
