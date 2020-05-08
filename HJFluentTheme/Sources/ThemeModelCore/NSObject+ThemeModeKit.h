//
//  NSObject+ThemeModeKit.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ThemeModeKit)
/// Swizzle two instance methods for class that calls this method.
///
/// Return NO if any selector cannot find corresponding method.
+ (BOOL)tm_swizzleInstanceMethod:(SEL)fromSelector to:(SEL)toSelector;
@end

NS_ASSUME_NONNULL_END
