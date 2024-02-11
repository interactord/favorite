// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DesignSystem",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "DesignSystem",
      targets: ["DesignSystem"]),
  ],
  dependencies: [
    .package(
          url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git",
          from: "2.2.3"),
  ],
  targets: [
    .target(
      name: "DesignSystem",
      dependencies: [
        "SDWebImageSwiftUI",
      ]),
    .testTarget(
      name: "DesignSystemTests",
      dependencies: ["DesignSystem"]),
  ])
