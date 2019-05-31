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
  var progressView: UIProgressView!

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

    // UIToolBar
    progressView = UIProgressView(progressViewStyle: .default) // Instantiate the progressView
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView) // Create a barbutton using the progressView

    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // This is just the flexibleWidth
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

    toolbarItems = [progressButton, spacer, refresh] // Here we add the buttons to the toolbar
    navigationController?.isToolbarHidden = false // We show the toolbar

    // KVO
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
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

  // KVO Observer Method

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
}

// MARK: - WKNavigation Delegate

extension ViewController: WKNavigationDelegate {

  // This is called when the navigation is complete
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
}
