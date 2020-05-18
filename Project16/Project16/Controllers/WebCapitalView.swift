//
//  WebCapitalView.swift
//  Project16
//
//  Created by Daniel Gx on 18/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import WebKit
import UIKit

class WebCapitalView: UIViewController {
    
    // MARK: - Properties
    
    var webView: WKWebView!
    var selectedURLParameter: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callURL(selectedURLParameter ?? "Main_Page")
    }
    
    // MARK: - Methods
    
    func callURL(_ parameter: String) {
        guard let url = URL(string: "https://en.wikipedia.org/wiki/\(parameter)") else  { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

// MARK: - WebView

extension WebCapitalView: WKNavigationDelegate {
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}
