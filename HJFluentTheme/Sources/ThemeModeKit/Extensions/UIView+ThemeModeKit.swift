//
//  UIView+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import UIKit

extension UIView: TMTraitEnvironment {
    open func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
      subviews.forEach { $0.tmTraitCollectionDidChange(previousTraitCollection) }
      setNeedsLayout()
      setNeedsDisplay()
      tm_updateDynamicColors()
      tm_updateDynamicImages()
    }

    @objc func tm_updateDynamicColors() {
      if let dynamicBackgroundColor = tm_dynamicBackgroundColor {
        backgroundColor = dynamicBackgroundColor
      }
      if let dynamicTintColor = tm_dynamicTintColor {
        tintColor = dynamicTintColor
      }
    }

    @objc func tm_updateDynamicImages() {
      // For subclasses to override.
    }
    
}

extension UIView {
  static let swizzleWillMoveToWindowOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(willMove(toWindow:)), to: #selector(tm_willMove(toWindow:))) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UIView.self, selector: #selector(willMove(toWindow:))))
    }
  }()

  @objc private dynamic func tm_willMove(toWindow window: UIWindow?) {
    tm_willMove(toWindow: window)
    if window != nil {
      tm_updateDynamicColors()
      tm_updateDynamicImages()
    }
  }
}

extension UIView {
  private struct Constants {
    static var dynamicTintColorKey = "dynamicTintColorKey"
  }

  static let swizzleSetTintColorOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(setter: tintColor), to: #selector(tm_setTintColor)) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UIView.self, selector: #selector(setter: tintColor)))
    }
  }()

  private var tm_dynamicTintColor: DynamicColor? {
    get { return objc_getAssociatedObject(self, &Constants.dynamicTintColorKey) as? DynamicColor }
    set { objc_setAssociatedObject(self, &Constants.dynamicTintColorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
  }

  @objc private dynamic func tm_setTintColor(_ color: UIColor) {
    tm_dynamicTintColor = color as? DynamicColor
    tm_setTintColor(color)
  }
}
