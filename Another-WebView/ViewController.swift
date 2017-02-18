//
//  ViewController.swift
//  Another-WebView
//
//  Created by MGXA2 on 2/3/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import Social
import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView : UIProgressView!
    var websites  = ["google.ca","apple.com", "microsoft.com"]
    var openedWebsite = URL(string: "google.ca")
    
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(ViewController.openTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ViewController.shareButton))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(UIWebView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    
    func shareButton () {
        // Option 1: Open activities associated with Item
//        let activity = UIActivityViewController(activityItems: [openedWebsite!], applicationActivities: [])
//        present(activity, animated: true, completion: nil)
        
        // Option 2: Sharing in facebook, twitter...
        if let openedWebsite = openedWebsite {
            let social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            social?.setInitialText("Hello friends, check out my link!")
            social?.add(openedWebsite)
            present(social!, animated: true, completion: nil)
        }
        
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
        let url = URL(string: "http://"+sender.title!)
        openedWebsite = url
        webView.load(NSURLRequest(url: url! as URL) as URLRequest)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let host = navigationAction.request.url?.host {
            for website in websites {
                if host.range(of: website) != nil {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}

