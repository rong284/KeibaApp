//
// webページ表示のためのあれこれ
// Created by rong on 2024/05/24.
//

import SwiftUI
import WebKit
import Combine

class WebViewModel: NSObject, ObservableObject {
    @Published var currentURL: URL?
    @Published var canGoBack = false
    
    private var webView: WKWebView = WKWebView()
    
    override init() {
        super.init()
        webView.navigationDelegate = self
    }
    
    func load(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func getWebView() -> WKWebView {
        return webView
    }
}

extension WebViewModel: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        currentURL = webView.url
        canGoBack = webView.canGoBack
    }
}

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        return viewModel.getWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

