//
//  TMDynamicColor.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DynamicColor)
@interface TMDynamicColor : UIColor

@property (nonatomic, readonly) UIColor *lightColor;
@property (nonatomic, readonly) UIColor *darkColor;
- (instancetype)initWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
