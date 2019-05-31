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

    // Bar button
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
  }

  // MARK: - Public Methods

  @objc func openTapped() {
    let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "juanfdorado-dev.weebly.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: openPage))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }

  func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
  }
}

// MARK: - WKNavigation Delegate

extension ViewController: WKNavigationDelegate {

  // This is called when the navigation is complete
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
}
