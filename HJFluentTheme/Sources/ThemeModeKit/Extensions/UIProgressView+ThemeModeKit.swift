//
//  UIProgressView+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation

extension UIProgressView {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()

    if let dynamicProgressTintColor = progressTintColor?.copy() as? DynamicColor {
      progressTintColor = dynamicProgressTintColor
    }
    if let dynamicTrackTintColor = trackTintColor?.copy() as? DynamicColor {
      trackTintColor = dynamicTrackTintColor
    }
  }
}
