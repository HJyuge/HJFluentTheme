//
//  UIWindow+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UIWindow {
  open override func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
    super.tmTraitCollectionDidChange(previousTraitCollection)
    rootViewController?.tmTraitCollectionDidChange(previousTraitCollection)
  }
}

