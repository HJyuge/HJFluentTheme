//
//  UIColor+ThemeModeKit.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMNamespace.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ThemeModeKit)

+ (UIColor *)tm_colorWithPath:(NSString *)path NS_SWIFT_UNAVAILABLE("Use init(_:path) instead.");

#if __swift__
+ (UIColor *)tm_namespace:(TMNamespace)namespace
      colorWithPath:(NSString *)path NS_SWIFT_NAME(init(_:path:));
#endif

@end

NS_ASSUME_NONNULL_END
