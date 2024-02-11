// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Platform",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "Platform",
      targets: ["Platform"]),
  ],
  dependencies: [
    .package(path: "../../Core/Domain"),
    .package(
      url: "https://github.com/CombineCommunity/CombineExt.git",
      .upToNextMajor(from: "1.8.1")),
    .package(
      url: "https://github.com/apple/swift-log.git",
      .upToNextMajor(from: "1.5.3")),
  ],
  targets: [
    .target(
      name: "Platform",
      dependencies: [
        "Domain",
        "CombineExt",
        .product(name: "Logging", package: "swift-log"),
      ],
      resources: [
        .copy("Resources/Mock/dummy.json"),
      ]),
    .testTarget(
      name: "PlatformTests",
      dependencies: ["Platform"]),
  ])
