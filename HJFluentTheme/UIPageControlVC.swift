//
//  UIPageControlVC.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
final class UIPageControlVC: ViewController {
  let pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.currentPageIndicatorTintColor = UIColor(.tm, path: kViewColor)
    pageControl.pageIndicatorTintColor = UIColor(.tm, path: kTextMainColor)
    pageControl.numberOfPages = 3
    return pageControl
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(.tm, path: kVCBgMainColor)
    view.addSubview(pageControl)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    pageControl.sizeToFit()
    pageControl.center = view.center
  }
}
