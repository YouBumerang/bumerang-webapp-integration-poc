import SwiftUI
import UIKit
import WebKit

struct WebViewContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<WebViewContainer>) -> WebViewController {
        return WebViewController()
    }
    
    func updateUIViewController(_ uiViewController: WebViewController, context: UIViewControllerRepresentableContext<WebViewContainer>) {
    }
}

class WebViewController: UIViewController, WKScriptMessageHandler {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        userContentController.add(self, name: "messageHandler")
        
        webConfiguration.userContentController = userContentController
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let url = URL(string: "https://google.es")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "messageHandler", let messageBody = message.body as? String {
            print("Message from WebView: \(messageBody)")
            
            webView.evaluateJavaScript("window.postMessage('Hello from Swift!', '*')") { (result, error) in
                if let error = error {
                    print("Failed to post message to WebView: \(error)")
                }
            }
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    // Implement any necessary WKNavigationDelegate methods
}
