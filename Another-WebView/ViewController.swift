//
//  ViewController.swift
//  Another-WebView
//
//  Created by MGXA2 on 2/3/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView : UIProgressView!
    var websites  = ["apple.com", "microsoft.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://"+websites[0])!
        webView.load(NSURLRequest(url: url as URL) as URLRequest)
        webView.allowsBackForwardNavigationGestures = true
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(ViewController.openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(UIWebView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            
        }
    }

    func openTapped() {
        let alert = UIAlertController(title: "Open page", message: nil, preferredStyle: .alert)
        for website in websites {
            alert.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func openPage(sender: UIAlertAction) {
        let url = NSURL(string: "http://"+sender.title!)
        webView.load(NSURLRequest(url: url! as URL) as URLRequest)
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}

