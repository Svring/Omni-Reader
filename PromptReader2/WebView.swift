//
//  WebView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/8.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    var url: URL = Bundle.main.url(forResource: "index", withExtension: "html")!

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        return webView
    }

    func updateNSView(_ uiView: WKWebView, context: Context) {
        // 如果需要更新视图，可以在这里实现
    }
}

#Preview {
    WebView()
}
