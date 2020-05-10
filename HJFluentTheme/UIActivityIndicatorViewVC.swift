//
//  UIActivityIndicatorViewVC.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
final class UIActivityIndicatorViewVC: ViewController {
  let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView()
    activityIndicatorView.color = UIColor(.tm, path: kViewColor)
    activityIndicatorView.hidesWhenStopped = false
    return activityIndicatorView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(.tm, path: kVCBgMainColor)

    view.addSubview(activityIndicatorView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    activityIndicatorView.sizeToFit()
    activityIndicatorView.center = view.center
  }
}
