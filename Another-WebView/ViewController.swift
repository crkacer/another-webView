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
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://www.google.ca")!
        webView.load(NSURLRequest(url: url as URL) as URLRequest)
        webView.allowsBackForwardNavigationGestures = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(ViewController.openTapped))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: "reload")
    }

    func openTapped() {
        let alert = UIAlertController(title: "Open page", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "microsoft.com", style: .default, handler: openPage))
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

