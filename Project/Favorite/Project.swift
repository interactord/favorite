import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.preview(
  projectName: "Favorite",
  packages: [
    .local(path: .relativeToRoot("Modules/Core/Architecture")),
    .local(path: .relativeToRoot("Modules/Core/DesignSystem")),
    .local(path: .relativeToRoot("Modules/Core/Domain")),
    .local(path: .relativeToRoot("Modules/Core/Platform")),
    .local(path: .relativeToRoot("Modules/Core/Functor")),
    .local(path: .relativeToRoot("Modules/Feature/Dashboard")),
  ],
  dependencies: [
    .package(product: "Dashboard", type: .runtime, condition: .none),
  ])
