//
//  UIView+ThemeModeKit.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMDynamicColor;
NS_ASSUME_NONNULL_BEGIN

@interface UIView (ThemeModeKit)
+ (void)tm_swizzleSetBackgroundColor;

@property (nonatomic, copy, nullable) TMDynamicColor *tm_dynamicBackgroundColor;
@end

NS_ASSUME_NONNULL_END
