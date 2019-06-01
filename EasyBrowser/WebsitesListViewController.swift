//
//  WebsitesListViewController.swift
//  EasyBrowser
//
//  Created by Juan Francisco Dorado Torres on 5/31/19.
//  Copyright © 2019 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class WebsitesListViewController: UITableViewController {

  // MARK: - Public Properties

  var websites = [String]()

  // MARK: - View cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    if let websitesPath = Bundle.main.path(forResource: "websites", ofType: "txt") {
      if let websitesURLS = try? String(contentsOfFile: websitesPath) {
        websites = websitesURLS.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
      }
    } else {
      websites = ["apple.com"]
    }
  }
}

// MARK: - Table view data source

extension WebsitesListViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return websites.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
    cell.textLabel?.text = websites[indexPath.row]
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let browserViewController = storyboard?.instantiateViewController(withIdentifier: "Browser") as? BrowserViewController {
      browserViewController.websites = websites
      browserViewController.selectedWebsiteIndex = indexPath.row
      navigationController?.pushViewController(browserViewController, animated: true)
    }
  }
}
