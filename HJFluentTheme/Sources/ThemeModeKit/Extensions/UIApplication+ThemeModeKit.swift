//
//  UIApplication+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation


extension UIApplication: TMTraitEnvironment {
  open func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
    windows.forEach { $0.tmTraitCollectionDidChange(previousTraitCollection) }
  }
}
