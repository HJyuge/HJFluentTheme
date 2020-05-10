//
//  ainViewController.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation

final class MainViewController: ViewController {
  struct Row {
    var name: String
    var vcType: UIViewController.Type
  }

  let rows = [
    Row(name: "UIView", vcType: UIViewVC.self),
    Row(name: "UIActivityIndicatorView", vcType: UIActivityIndicatorViewVC.self),
    Row(name: "UIButton", vcType: UIButtonVC.self),
    Row(name: "UIPageControl", vcType: UIPageControlVC.self),
    Row(name: "RedMode", vcType: UIViewVC.self),
    Row(name: "LightMode", vcType: UIViewVC.self),
    Row(name: "DarkMode", vcType: UIViewVC.self),
    Row(name: "discuss", vcType: UIViewVC.self),
    Row(name: "guide", vcType: UIViewVC.self),
  ]

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.dataSource = self
    tableView.backgroundColor = UIColor(.tm, path: kVCBgMainColor)
    tableView.delegate = self
    return tableView
  }()

  override func loadView() {
    view = tableView
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    rows.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = rows[indexPath.row]

    let cell = UITableViewCell()
    cell.textLabel?.text = row.name
    cell.accessoryType = .disclosureIndicator
    cell.backgroundColor = UIColor(.tm, path: "")
    if row.name == "discuss"{
        cell.imageView?.image = UIImage(.tm, path: kWorkItemDiscussHomeImage)
    }else if row.name == "guide"{
        cell.imageView?.image = UIImage(.tm, path: kWorkItemGuideHomeImage)
    }
    return cell
  }
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = rows[indexPath.row]
    if indexPath.row <= 3{
        let vc = row.vcType.init()
        show(vc, sender: self)
    }else {
        if row.name == "RedMode"{
            configuration.themeMode = "red"
            TMTraitCollection.current = TMTraitCollection(userInterfaceStyle: .light, themeConfiguration: configuration)
        }else if row.name == "LightMode"{
            configuration.themeMode = "light"
            TMTraitCollection.current = TMTraitCollection(userInterfaceStyle: .light, themeConfiguration: configuration)
        }else if row.name == "DarkMode"{
            configuration.themeMode = "dark"
            TMTraitCollection.current = TMTraitCollection(userInterfaceStyle: .light, themeConfiguration: configuration)
        }else if row.name == "discuss" || row.name == "guide"{
            return;
        }
        ThemeModeManager.updateAppearance(for: .shared, animated: true)
    }
  }
}
