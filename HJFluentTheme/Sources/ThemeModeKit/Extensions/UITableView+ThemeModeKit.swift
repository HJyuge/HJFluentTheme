//
//  UITableView+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UITableView {
  override func tm_updateDynamicColors() {
    super.tm_updateDynamicColors()
    
    if let dynamicSectionIndexColor = sectionIndexColor?.copy() as? DynamicColor {
      sectionIndexColor = dynamicSectionIndexColor
    }
    if let dynamicSeparatorColor = separatorColor?.copy() as? DynamicColor {
      separatorColor = dynamicSeparatorColor
    }
  }
}
