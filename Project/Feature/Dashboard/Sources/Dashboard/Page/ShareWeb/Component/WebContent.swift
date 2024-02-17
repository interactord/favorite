import Domain
import SwiftUI
import UIKit
import WebKit

// MARK: - ShareWebPage.WebContent

extension ShareWebPage {
  struct WebContent {
    let viewState: ViewState
  }
}

// MARK: - ShareWebPage.WebContent + UIViewRepresentable

extension ShareWebPage.WebContent: UIViewRepresentable {
  func makeUIView(context _: Context) -> WKWebView {
    let webView = WKWebView(frame: .zero, configuration: .init())

    if let url = URL(string: viewState.item.htmlURL ?? "") {
      webView.load(.init(url: url))
    }
    return webView
  }

  func updateUIView(_: WKWebView, context _: Context) { }
}

// MARK: - ShareWebPage.WebContent.ViewState

extension ShareWebPage.WebContent {
  struct ViewState: Equatable {
    let item: GithubEntity.Search.Repository.Item
  }
}
