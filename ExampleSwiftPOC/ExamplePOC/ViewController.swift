import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView?.frame = view.bounds
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        openWebView()
    }
    
    func openWebView() {
        if webView == nil {
            let webViewConfiguration = WKWebViewConfiguration()
            webViewConfiguration.userContentController.add(self, name: "bumerangListener")
            webView = WKWebView(frame: view.bounds, configuration: webViewConfiguration)
            webView.navigationDelegate = self
            webView.uiDelegate = self
            view.addSubview(webView)
        }
        
        let url = URL(string: "https://bumerang-webview.ew.r.appspot.com/test") // Replace with your desired URL
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let messageBody = message.body as? String, let data = messageBody.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String], let event = json["event"], let value = json["value"] {
                    print("Received post message - Event: \(event), Value: \(value)")
                    titleLabel.text = value
                    closeWebView()
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    func closeWebView() {
        webView?.removeFromSuperview()
        webView = nil
    }
}
