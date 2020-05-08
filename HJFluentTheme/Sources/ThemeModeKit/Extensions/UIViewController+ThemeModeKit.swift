//
//  UIViewController+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UIViewController: TMTraitEnvironment {
  open func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
    setNeedsStatusBarAppearanceUpdate()
    presentedViewController?.tmTraitCollectionDidChange(previousTraitCollection)
    children.forEach { $0.tmTraitCollectionDidChange(previousTraitCollection) }
    if isViewLoaded {
      view.tmTraitCollectionDidChange(previousTraitCollection)
    }
  }
}
