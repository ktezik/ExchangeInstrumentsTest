//
//  WebView.swift
//  TestGrishin
//
//  Created by Иван Гришин on 16.03.2024.
//

import SwiftUI
import WebKit

// MARK: - Error

enum WebViewError: LocalizedError {
    case loadingFailed
    
    var errorDescription: String? {
        switch self {
        case .loadingFailed:
            "Sorry, there was an error loading the chart."
        }
    }
}

// MARK: - WebView

struct WebView: UIViewRepresentable {
    
    // MARK: - Private Properties
    
    private let webView = WKWebView()
    
    // MARK: - Public Properties
    
    func makeUIView(context: Context) -> WKWebView {
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func loadURL(urlString: String) -> Error? {
        guard let url = URL(string: urlString) else { return WebViewError.loadingFailed }
        webView.load(URLRequest(url: url))
        return nil
    }
}
