import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .previewProject(
  projectName: "Favorite",
  packages: [
    .local(path: "../../Project/Core/Architecture"),
    .local(path: "../../Project/Core/DesignSystem"),
    .local(path: "../../Project/Core/Domain"),
    .local(path: "../../Project/Core/Platform"),
    .local(path: "../../Project/Core/Functor"),
    .local(path: "../../Project/Feature/Dashboard"),
  ] + .defaultItemList,
  dependencies: [
    .package(product: "Dashboard"),
  ] + .defaultItemList)
