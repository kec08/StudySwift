//
//  2025_09_20_SiteView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/21/25.
//

import SwiftUI
import WebKit

// WKWebView 래핑
struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated,
               let linkURL = navigationAction.request.url {
                print("링크 클릭: \(linkURL)")
            }
            decisionHandler(.allow)
        }
    }
}

struct SiteView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.apple.com")!)
    }
}

#Preview {
    SiteView()
}

