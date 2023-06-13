import SwiftUI
import WebKit

struct WebView: UIViewControllerRepresentable {
    let url: URL?
    let onMessageReceived: (String) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> WKWebViewViewController {
        let webView = WKWebViewViewController(url: url, onMessageReceived: onMessageReceived)
        return webView
    }
    
    func updateUIViewController(_ uiViewController: WKWebViewViewController, context: UIViewControllerRepresentableContext<WebView>) {
    }
}
