//
//  UIButton.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
final class UIButtonVC: ViewController {
  let button: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Test", for: .normal)
    button.setTitleColor(UIColor(.tm, path: kViewColor), for: .normal)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(.tm, path: kVCBgMainColor)

    view.addSubview(button)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    button.sizeToFit()
    button.center = view.center
  }
}
