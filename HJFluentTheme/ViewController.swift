//
//  ViewController.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/7.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import UIKit
let configuration = ThemeConfiguration()

class ViewController: UIViewController {
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(.tm, path: kVCBgMainColor)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .refresh,
      target: self,
      action: #selector(refresh)
    )
  }

  @objc
  private func refresh() {
    if TMTraitCollection.current.userInterfaceStyle == .dark {
        configuration.themeMode = "light"
        TMTraitCollection.current = TMTraitCollection(userInterfaceStyle: .light, themeConfiguration: configuration)
    }
    else {
        configuration.themeMode = "dark"
        TMTraitCollection.current = TMTraitCollection(userInterfaceStyle: .dark, themeConfiguration: configuration)
    }
    ThemeModeManager.updateAppearance(for: .shared, animated: true)
  }
}

