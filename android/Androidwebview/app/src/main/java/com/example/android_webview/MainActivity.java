package com.example.android_webview;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebChromeClient;
import android.webkit.JavascriptInterface;
import android.widget.Button;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private WebView webView;
    private Button openButton;

    @SuppressLint("SetJavaScriptEnabled")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webView = findViewById(R.id.webView);
        openButton = findViewById(R.id.openButton);

        openButton.setOnClickListener(v -> openWebView());

        webView.setWebViewClient(new WebViewClient());
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setDomStorageEnabled(true);
        webView.setWebChromeClient(new WebChromeClient());
        webView.setWebViewClient(new WebViewClient());
        webView.setWebChromeClient(new WebChromeClient());

    }

    @SuppressLint("SetJavaScriptEnabled")
    private void openWebView() {
        webView.setVisibility(View.VISIBLE);
        openButton.setVisibility(View.GONE);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.setWebChromeClient(new WebChromeClient());
        webView.setWebViewClient(new WebViewClient());
        webView.getSettings().setDomStorageEnabled(true);
        webView.addJavascriptInterface(new JavaScriptInterface(), "AndroidInterface");
        webView.loadUrl("https://bumerang-webview.ew.r.appspot.com/test");
    }

    private class JavaScriptInterface {
        @JavascriptInterface
        public void receiveMessage(String message) {
            // Handle the received post message here
            Log.i("mensaje", "test");
            Toast.makeText(MainActivity.this, "Received Post Message: " + message, Toast.LENGTH_SHORT).show();
        }
    }
}
