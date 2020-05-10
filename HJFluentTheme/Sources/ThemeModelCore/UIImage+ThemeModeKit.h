//
//  UIImage+ThemeModeKit.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMNamespace.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ThemeModeKit)
+ (UIImage *)tm_imageWitPath:(NSString *)path NS_SWIFT_UNAVAILABLE("Use init(_:path:) instead.");

#if __swift__
+ (UIImage *)tm_namespace:(TMNamespace)namespace
      imageWithPath:(NSString *)path NS_SWIFT_NAME(init(_:path:));
#endif
@end

NS_ASSUME_NONNULL_END
