//
//  UIImageView+ThemeModeKit.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation
extension UIImageView {

  private struct Constants {
    static var dynamicImageKey = "dynamicImageKey"
  }

  var tm_dynamicImage: UIImage? {
    get { return objc_getAssociatedObject(self, &Constants.dynamicImageKey) as? UIImage }
    set { objc_setAssociatedObject(self, &Constants.dynamicImageKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
  }

  static let swizzleSetImageOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(setter: image), to: #selector(tm_setImage(_:))) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UIImageView.self, selector: #selector(setter: image)))
    }
  }()

  static let swizzleInitImageOnce: Void = {
    if !tm_swizzleInstanceMethod(#selector(UIImageView.init(image:)), to: #selector(UIImageView.tm_init(image:))) {
      assertionFailure(ThemeModeManager.messageForSwizzlingFailed(class: UIImageView.self, selector: #selector(setter: image)))
    }
  }()

  @objc dynamic func tm_init(image: UIImage?) -> UIImageView {
    if object_getClass(image) == TMDynamicImageProxy.self {
      tm_dynamicImage = image
    }
    return tm_init(image: image)
  }

  override func tm_updateDynamicImages() {
    super.tm_updateDynamicImages()

    if let dynamicImage = tm_dynamicImage {
      image = dynamicImage
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
}
