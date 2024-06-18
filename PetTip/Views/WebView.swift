//
//  WebView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/17.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // 시작할 때 처리
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 완료될 때 처리
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // 오류가 발생했을 때 처리
        }
    }
}

#Preview {
    WebView(url: URL(string: "https://pettip.net/terms")!)
}
