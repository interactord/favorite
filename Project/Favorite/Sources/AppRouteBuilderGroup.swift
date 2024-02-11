import Architecture
import Dashboard
import Foundation
import LinkNavigator

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    DashboardRouteBuilderGroup.release
  }
}
