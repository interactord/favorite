// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "favorite",
  products: [
    .library(
      name: "favorite",
      targets: ["favorite"]),
  ],
  dependencies: [
    .package(url: "https://github.com/airbnb/swift", from: "1.0.6"),
  ],
  targets: [
    .target(
      name: "favorite"),
    .testTarget(
      name: "favoriteTests",
      dependencies: ["favorite"]),
  ])
