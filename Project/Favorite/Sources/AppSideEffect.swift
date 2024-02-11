import Architecture
import Domain
import Foundation
import LinkNavigator
import Platform
import Dashboard

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, DashboardEnvironmentUsable {
  let toastViewModel: ToastViewModel
}
