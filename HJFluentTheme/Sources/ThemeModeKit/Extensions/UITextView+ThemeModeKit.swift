//
//  UITextView+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UITextView {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()
    
    keyboardAppearance = {
      if TMTraitCollection.current.userInterfaceStyle == .dark {
        return .dark
      }
      else {
        return .default
      }
    }()
  }
}
