//
//  UILabel+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UILabel {
  private enum Constants {
    static var currentThemeKey = "currentThemeKey"
  }

  static let swizzleDidMoveToWindowOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(didMoveToWindow), to: #selector(tm_didMoveToWindow)) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UILabel.self, selector: #selector(didMoveToWindow)))
    }
  }()

  private var currentUserInterfaceStyle: TMUserInterfaceStyle? {
    get { return objc_getAssociatedObject(self, &Constants.currentThemeKey) as? TMUserInterfaceStyle }
    set { objc_setAssociatedObject(self, &Constants.currentThemeKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
  }

  @objc private dynamic func tm_didMoveToWindow() {
    tm_didMoveToWindow()
    if currentUserInterfaceStyle != TMTraitCollection.current.userInterfaceStyle {
      currentUserInterfaceStyle = TMTraitCollection.current.userInterfaceStyle
      tmTraitCollectionDidChange(nil)
    }
  }

  open override func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
    super.tmTraitCollectionDidChange(previousTraitCollection)
  }

  private func updateDynamicColorInAttributedText() {
    guard let attributedText = attributedText else {
      return
    }

    // Why are we doing this?
    //
    // 1. In iOS 11, setNeedsDisplay() is not work well
    // 2. If you set UILabel.attributedText, UILabel.textColor will be foreground color at index 0 of the attributed text
    // 3. If you set UILabel.textColor, the entire attributed text will get a foreground color
    // 4. So if a label has a two or more colors attributed string, we can not simply reset text color
    // 5. The final solution is in below, we just update attributed text
    // 6. Luckliy we only need to do this in iOS 11.

    var updatedAttributedText: NSMutableAttributedString?

    var range = NSRange(location: 0, length: 0)
    while range.location + range.length < attributedText.length {
      let index = range.location + range.length
      // Don't panic, this call just make range an inout parameter.
      let attribute = withUnsafeMutablePointer(to: &range) {
        attributedText.attribute(.foregroundColor, at: index, effectiveRange: $0)
      }
      if let color = attribute as? DynamicColor {
        if updatedAttributedText == nil {
          updatedAttributedText = NSMutableAttributedString(attributedString: attributedText)
        }
        updatedAttributedText?.setAttributes([.foregroundColor: color.copy()], range: range)
      }
    }

    if let updatedAttributedText = updatedAttributedText {
      self.attributedText = updatedAttributedText
    }
  }
}
