//
//  UITabBar+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UITabBar {
  open override func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
    super.tmTraitCollectionDidChange(previousTraitCollection)
    items?.forEach { $0.tmTraitCollectionDidChange(previousTraitCollection) }
  }

  override func tm_updateDynamicImages() {
    super.tm_updateDynamicImages()
    items?.forEach { $0._updateDynamicImages() }
  }
}

extension UITabBarItem: TMTraitEnvironment {

  private struct Constants {
    static var UIImageKey = "UIImageKey"
    static var dynamicSelectedImageKey = "dynamicSelectedImageKey"
  }

  var tm_dynamicImage: UIImage? {
    get { return objc_getAssociatedObject(self, &Constants.UIImageKey) as? UIImage }
    set { objc_setAssociatedObject(self, &Constants.UIImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  var tm_dynamicSelectedImage: UIImage? {
    get { return objc_getAssociatedObject(self, &Constants.dynamicSelectedImageKey) as? UIImage }
    set { objc_setAssociatedObject(self, &Constants.dynamicSelectedImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  static let swizzleSetImageOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(setter: image), to: #selector(tm_setImage(_:))) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UITabBarItem.self, selector: #selector(setter: image)))
    }
  }()

  static let swizzleSetSelectedImageOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(setter: selectedImage), to: #selector(tm_setSelectedImage(_:))) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UITabBarItem.self, selector: #selector(setter: selectedImage)))
    }
  }()

  open func tmTraitCollectionDidChange(_ previousTraitCollection: TMTraitCollection?) {
    // For subclasses to override
  }

  fileprivate func _updateDynamicImages() {
    if let dynamicImage = tm_dynamicImage {
      image = dynamicImage
    }

    if let dynamicImage = tm_dynamicSelectedImage {
      selectedImage = dynamicImage
    }
  }

  @objc dynamic func tm_setImage(_ image: UIImage?) {
    if object_getClass(image) == TMDynamicImageProxy.self {
      tm_dynamicImage = image
    }
    else {
      tm_dynamicImage = nil
    }
    tm_setImage(image)
  }

  @objc dynamic func tm_setSelectedImage(_ image: UIImage?) {
    if object_getClass(image) == TMDynamicImageProxy.self {
      tm_dynamicSelectedImage = image
    }
    else {
      tm_dynamicSelectedImage = nil
    }
    tm_setSelectedImage(image)
  }

}
