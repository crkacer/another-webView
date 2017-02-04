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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

