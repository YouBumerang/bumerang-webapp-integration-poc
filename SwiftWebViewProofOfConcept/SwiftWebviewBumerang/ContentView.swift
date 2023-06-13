import SwiftUI

struct ContentView: View {
    @State private var isShowingWebView = false
    @State private var messageFromWebView = ""
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingWebView = true
            }) {
                Text("Open WebView")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingWebView, onDismiss: {
            }, content: {
                WebView(url: URL(string: "https://bumerang-webview.ew.r.appspot.com/"), onMessageReceived: { message in
                    print("Received message:", message)
                    messageFromWebView = message
                })
            })
            
            if !messageFromWebView.isEmpty {
                Text("Message from WebView: \(messageFromWebView)")
                    .padding()
            }
        }
    }
}
