//
//  ThemeModeManager.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
public final class ThemeModeManager: NSObject {
    public static func setup() {
        // Colors
        UIView.swizzleWillMoveToWindowOnce
        UIView.tm_swizzleSetBackgroundColor()
        UIView.swizzleSetTintColorOnce
        UITextField.swizzleTextFieldWillMoveToWindowOnce
        UILabel.swizzleDidMoveToWindowOnce

        // Images
        UIImageView.swizzleSetImageOnce
        UIImageView.swizzleInitImageOnce
        UITabBarItem.swizzleSetImageOnce
        UITabBarItem.swizzleSetSelectedImageOnce
    }
    
    /// Update application's appearance based on current theme (This method is for main app.)
    ///
    /// - Parameters:
    ///   - application: The application needs to update.
    ///   - animated: Use animation or not.
    @objc public static func updateAppearance(for application: UIApplication, animated: Bool) {
      application.updateAppearance(with: application.windows, animated: animated)
    }

    // MARK: - Internal

    static func messageForSwizzlingFailed(class cls: AnyClass, selector: Selector) -> String {
      return "Method swizzling for theme failed! Class: \(cls), Selector: \(selector)"
    }
    
}

// MARK: -

extension TMTraitEnvironment {
  /// Trigger `themeDidChange()`.
  ///
  /// - Parameters:
  ///   - views: Views visiable by user, will be snapshoted if use animation.
  ///   - animated: Use animation or not.
  fileprivate func updateAppearance(with views: [UIView], animated: Bool) {
    assert(Thread.isMainThread)

    if animated {
      var snapshotViews: [UIView] = []
      views.forEach { view in
        guard let snapshotView = view.snapshotView(afterScreenUpdates: false) else {
          return
        }
        view.addSubview(snapshotView)
        snapshotViews.append(snapshotView)
      }

      tmTraitCollectionDidChange(nil)

      UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [], animations: {
        snapshotViews.forEach { $0.alpha = 0 }
      }) { _ in
        snapshotViews.forEach { $0.removeFromSuperview() }
      }
    }
    else {
      tmTraitCollectionDidChange(nil)
    }
  }
}
