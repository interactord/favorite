import Architecture
import Foundation
import LinkNavigator
import Dashboard

struct AppRouteBuilderGroup<RootNavigator: RootNavigatorType> {

  var release: [RouteBuilderOf<RootNavigator>] {
    DashboardRouteBuilderGroup.release
  }
}
