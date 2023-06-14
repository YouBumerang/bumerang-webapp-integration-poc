import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if let messageBody = message.body as? String {
                print("Mensaje recibido: \(messageBody)")
                titleLabel.text = messageBody
                closeWebView()
            }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        openWebView()
    }
    
    func closeWebView() {
        webView?.removeFromSuperview()
        webView = nil
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
        let htmlString = """
        
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                /* Apply button styles */
                .apple-button {
                    width: 70vw;
                    height: 5vh;
                    border-radius: 8px;
                    display: inline-block;
                    padding: 10px 20px;
                    background-color: #000;
                    color: #fff;
                    border-radius: 5px;
                    border: none;
                    text-align: center;
                    text-decoration: none;
                    font-size: 40px;
                    cursor: pointer;
                    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.25);
                    transition: background-color 0.3s ease;
                }
        
                h1 {
                    
                    font-size: 48px;
                }

                .apple-button:hover {
                            background-color: #222;
                }

                .apple-button:active {
                    background-color: #444;
                }

                /* Center button horizontally */
                body {
                    font-family: 'Arial', sans-serif;
                    font-weight: bold;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
            </style>
        </head>
        <body>
        <h1>Swift WebView Proof of Concept</h1>
        <button id="miBoton" class="apple-button">Enviar mensaje</button>
        <script>
            document.getElementById("miBoton").addEventListener("click", function() {
                window.webkit.messageHandlers.bumerangListener.postMessage("B-23948295 example Bumerang code");
            });
        </script>
        </body>
        </html>

                
        """
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView?.frame = view.bounds
    }
}
