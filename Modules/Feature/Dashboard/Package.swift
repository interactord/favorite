// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Dashboard",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "Dashboard",
      targets: ["Dashboard"]),
  ],
  dependencies: [
    .package(path: "../../Core/Architecture"),
  ],
  targets: [
    .target(
      name: "Dashboard",
      dependencies: [
        "Architecture",
      ]),
    .testTarget(
      name: "DashboardTests",
      dependencies: ["Dashboard"]),
  ])
