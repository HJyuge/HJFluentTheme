//
//  UIScrollView+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UIScrollView {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()

    indicatorStyle = {
      if TMTraitCollection.current.userInterfaceStyle == .dark {
        return .white
      }
      else {
        return .default
      }
    }()
  }
}
