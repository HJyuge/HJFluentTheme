//
//  UIColor+ThemeModeKit.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "UIColor+ThemeModeKit.h"
#import "TMDynamicColor.h"

@implementation UIColor (ThemeModeKit)
+ (UIColor *)tm_colorWithPath:(NSString *)path {
    return (UIColor *)[[TMDynamicColor alloc] initWithColorPath:path];
}

+ (UIColor *)tm_namespace:(TMNamespace)namespace
            colorWithPath:(NSString *)path {
    return [UIColor tm_colorWithPath:path];
}
@end
