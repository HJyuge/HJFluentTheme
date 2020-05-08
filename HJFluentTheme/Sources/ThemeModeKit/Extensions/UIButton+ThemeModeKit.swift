//
//  UIButton+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UIButton {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()

    [UIControl.State.normal, .highlighted, .disabled, .selected, .focused].forEach { state in
      if let color = titleColor(for: state)?.copy() as? DynamicColor {
        setTitleColor(color, for: state)
      }
    }
  }
}
