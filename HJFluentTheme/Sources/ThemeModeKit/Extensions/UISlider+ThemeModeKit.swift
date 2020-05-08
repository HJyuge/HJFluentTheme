//
//  UISlider+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation

extension UISlider {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()

    if let dynamicMinimumTrackTintColor = minimumTrackTintColor?.copy() as? DynamicColor {
      minimumTrackTintColor = dynamicMinimumTrackTintColor
    }
    if let dynamicMaximumTrackTintColor = maximumTrackTintColor?.copy() as? DynamicColor {
      maximumTrackTintColor = dynamicMaximumTrackTintColor
    }
  }
}
