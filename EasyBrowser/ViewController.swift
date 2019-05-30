//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Juan Francisco Dorado Torres on 5/30/19.
//  Copyright © 2019 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

  // MARK: - Public Properties

  var webView: WKWebView!

  // MARK: - View cycle

  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let url = URL(string: "https://juanfdorado-dev.weebly.com")!
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true // This enabled property of the web view allows users to swipe from the left or right edge to move backward or forward in their web browsing.
  }
}

extension ViewController: WKNavigationDelegate {

}
