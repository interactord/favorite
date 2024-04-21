import Foundation
import ProjectDescription

extension Target {
  static func previewTarget(
    projectName: String,
    dependencies: [TargetDependency],
    isDev: Bool)
    -> Self
  {
    .target(
      name: "\(projectName)Preview",
      destinations: .iOS,
      product: .app,
      productName: "\(projectName)Preview",
      bundleId: "io.interactord.groove.\(projectName.lowercased()).preview",
      deploymentTargets: .default,
      infoPlist: .defaultInfoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      copyFiles: .none,
      headers: .none,
      entitlements: .none,
      scripts: [],
      dependencies: dependencies,
      settings: .defaultConfig(isDev),
      coreDataModels: [],
      environmentVariables: [:],
      launchArguments: [],
      additionalFiles: [],
      buildRules: [],
      mergedBinaryType: .disabled,
      mergeable: false)
  }

  static func previewTestTarget(
    projectName: String)
    -> Self
  {
    .target(
      name: "\(projectName)PreviewTests",
      destinations: .iOS,
      product: .unitTests,
      productName: "\(projectName)PreviewTests",
      bundleId: "io.interactord.groove.\(projectName.lowercased()).preview.tests",
      deploymentTargets: .default,
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: .none,
      copyFiles: .none,
      headers: .none,
      entitlements: .none,
      scripts: [],
      dependencies: [
        .target(name: "\(projectName)Preview", condition: .none),
      ],
      settings: .none,
      coreDataModels: [],
      environmentVariables: [:],
      launchArguments: [],
      additionalFiles: [],
      buildRules: [],
      mergedBinaryType: .disabled,
      mergeable: false)
  }
}

extension Project {
  public static func preview(
    projectName: String,
    packages: [Package],
    dependencies: [TargetDependency])
    -> Self
  {
    .init(
      name: "\(projectName)Preview",
      organizationName: "ScottMoon",
      options: .options(),
      packages: packages,
      settings: .settings(),
      targets: [
        .previewTarget(
          projectName: projectName,
          dependencies: dependencies,
          isDev: true),
        .previewTestTarget(projectName: projectName),
      ],
      schemes: .testScheme(previewTestTarget: projectName),
      fileHeaderTemplate: .none,
      additionalFiles: [],
      resourceSynthesizers: [])
  }
}

extension [Scheme] {
  fileprivate static func testScheme(previewTestTarget: String) -> [Scheme] {
    [
      .scheme(
        name: "\(previewTestTarget)Preview",
        shared: true,
        hidden: false,
        buildAction: .buildAction(targets: ["\(previewTestTarget)Preview"]),
        testAction: .targets(["\(previewTestTarget)PreviewTests"]),
        runAction: .runAction(),
        archiveAction: .none,
        profileAction: .none,
        analyzeAction: .none),
    ]
  }
}
