//
//  UItextField+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UITextField {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()

    if let dynamicTextColor = textColor?.copy() as? DynamicColor {
      textColor = dynamicTextColor
    }

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

extension UITextField {

  /// `UITextField` will not call `super.willMove(toWindow:)` in its implementation, so we need to swizzle it separately.
  static let swizzleTextFieldWillMoveToWindowOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(willMove(toWindow:)), to: #selector(tm_textFieldWillMove(toWindow:))) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UITextField.self, selector: #selector(willMove(toWindow:))))
    }
  }()

  @objc private dynamic func tm_textFieldWillMove(toWindow window: UIWindow?) {
    tm_textFieldWillMove(toWindow: window)
    if window != nil {
      tm_updateDynamicColors()
      tm_updateDynamicImages()
    }
  }
}
