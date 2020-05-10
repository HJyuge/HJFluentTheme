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

+ (UIColor *) tm_colorWithHexString: (NSString *) string
{
    return [UIColor tm_colorWithHexString:string alpha:255];
}

+ (UIColor *) tm_colorWithHexString: (NSString *)stringToConvert alpha:(int)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha: (float)alpha/255.0];
}

@end
