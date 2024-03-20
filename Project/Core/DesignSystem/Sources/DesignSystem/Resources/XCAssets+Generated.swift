// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#elseif os(tvOS) || os(watchOS)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
typealias AssetColorTypeAlias = ColorAsset.Color

// MARK: - Asset

// swiftlint:disable superfluous_disable_command file_length implicit_return

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  enum ColorChip {
    enum Background {
      static let backgroundGreen = ColorAsset(name: "BackgroundGreen")
      static let backgroundSky = ColorAsset(name: "BackgroundSky")
    }

    enum Error {
      static let errorDefault = ColorAsset(name: "ErrorDefault")
    }

    enum Label {
      static let labelDefault = ColorAsset(name: "LabelDefault")
      static let labelGradient100 = ColorAsset(name: "LabelGradient100")
      static let labelGradient200 = ColorAsset(name: "LabelGradient200")
    }

    enum Overlay {
      static let overlayDefault = ColorAsset(name: "OverlayDefault")
    }

    enum Palette {
      enum Gray {
        static let paletteGray100 = ColorAsset(name: "PaletteGray100")
        static let paletteGray200 = ColorAsset(name: "PaletteGray200")
        static let paletteGray250 = ColorAsset(name: "PaletteGray250")
        static let paletteGray300 = ColorAsset(name: "PaletteGray300")
        static let paletteGray400 = ColorAsset(name: "PaletteGray400")
      }
    }

    enum System {
      static let systemBlack = ColorAsset(name: "SystemBlack")
      static let systemWhite = ColorAsset(name: "SystemWhite")
    }

    enum Tint {
      static let tintDefault = ColorAsset(name: "TintDefault")
    }
  }
}

// MARK: - ColorAsset

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

final class ColorAsset {

  // MARK: Lifecycle

  fileprivate init(name: String) {
    self.name = name
  }

  // MARK: Internal

  fileprivate(set) var name: String

  #if os(macOS)
  typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  private(set) lazy var swiftUIColor = SwiftUI.Color(asset: self)
  #endif

}

extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// MARK: - BundleToken

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
