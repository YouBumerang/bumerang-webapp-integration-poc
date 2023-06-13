import UIKit
import WebKit

class WKWebViewViewController: UIViewController, WKScriptMessageHandler {
    private let webView: WKWebView
    private let url: URL?
    private let onMessageReceived: (String) -> Void
    
    init(url: URL?, onMessageReceived: @escaping (String) -> Void) {
        self.url = url
        self.webView = WKWebView()
        self.onMessageReceived = onMessageReceived
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.bounds
        view.addSubview(webView)
        
        let request = URLRequest(url: url!)
        webView.load(request)
        
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "messageHandler")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        webView.configuration.userContentController = userContentController
        webView.navigationDelegate = self
        
        view.addSubview(webView)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "messageHandler", let messageBody = message.body as? String {
            onMessageReceived(messageBody)
        }
    }
}

extension WKWebViewViewController: WKNavigationDelegate {
    // Implement any necessary WKNavigationDelegate methods
}
