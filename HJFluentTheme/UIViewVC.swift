//
//  UIViewVC.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
final class UIViewVC: ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(.tm, path: kVCBgMainColor)
  }
}
