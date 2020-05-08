//
//  TMDynamicImage.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface TMDynamicImageProxy : NSProxy

@property (nonatomic, readonly) UIImage *resolvedImage;

- (instancetype)initWithLightImage:(UIImage *)lightImage darkImage:(UIImage *)darkImage;

@end

NS_ASSUME_NONNULL_END
