import Domain
import SwiftUI
import UIKit
import WebKit

// MARK: - RepoDetailPage.WebContent

extension RepoDetailPage {
  struct WebContent {
    let viewState: ViewState
  }
}

// MARK: - RepoDetailPage.WebContent + UIViewRepresentable

extension RepoDetailPage.WebContent: UIViewRepresentable {
  func makeUIView(context _: Context) -> WKWebView {
    let webView = WKWebView(frame: .zero, configuration: .init())

    if
      let htmlURL = viewState.item.htmlURL,
      let url = URL(string: htmlURL)
    {
      webView.load(.init(url: url))
    }
    return webView
  }

  func updateUIView(_: WKWebView, context _: Context) { }
}

// MARK: - RepoDetailPage.WebContent.ViewState

extension RepoDetailPage.WebContent {
  struct ViewState: Equatable {
    let item: GithubEntity.Detail.Repository.Response
  }
}
