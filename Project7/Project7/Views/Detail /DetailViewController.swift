//
//  DetailViewController.swift
//  Project7
//
//  Created by Daniel Gx on 09/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: DetailFlow?
    var webView: WKWebView!
    var detailItem: Petition?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHTMLView()
    }
    
    // MARK: - Methods
    
    func setHTMLView() {
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content"width=device-width, initial-scale=1">
        <style> body { font-size: 300%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
