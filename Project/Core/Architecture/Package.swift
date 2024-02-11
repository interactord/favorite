// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Architecture",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "Architecture",
      targets: ["Architecture"]),
  ],
  dependencies: [
    .package(path: "../DesignSystem"),
    .package(path: "../Domain"),
    .package(path: "../Platform"),
    .package(path: "../Functor"),
    .package(
      url: "https://github.com/interactord/LinkNavigator",
      .upToNextMajor(from: "1.0.2")),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      .upToNextMajor(from: "1.5.5")),
    .package(
      url: "https://github.com/google/GoogleSignIn-iOS",
      .upToNextMajor(from: "7.0.0")),
    .package(
      url: "https://github.com/apple/swift-log.git",
      .upToNextMajor(from: "1.5.3")),
  ],
  targets: [
    .target(
      name: "Architecture",
      dependencies: [
        "DesignSystem",
        "Domain",
        "Platform",
        "Functor",
        "LinkNavigator",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
        .product(name: "GoogleSignInSwift", package: "GoogleSignIn-iOS"),
        .product(name: "Logging", package: "swift-log"),
      ]),
    .testTarget(
      name: "ArchitectureTests",
      dependencies: ["Architecture"]),
  ])
