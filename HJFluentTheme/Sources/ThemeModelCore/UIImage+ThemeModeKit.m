//
//  UIImage+ThemeModeKit.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "UIImage+ThemeModeKit.h"
#import "TMDynamicImage.h"
#import "NSObject+ThemeModeKit.h"
@import ObjectiveC;

@implementation UIImage (ThemeModeKit)
+ (void)load {
  [UIImage tm_swizzleInstanceMethod:@selector(isEqual:) to:@selector(tm_isEqual:)];
}

+ (UIImage *)tm_imageWitPath:(NSString *)path {
    return (UIImage *)[[TMDynamicImageProxy alloc] initWithImagePath:path];
}

+ (UIImage *)tm_namespace:(TMNamespace)namespace
            imageWithPath:(NSString *)path {
  return [UIImage tm_imageWitPath:path];
}

- (BOOL)tm_isEqual:(UIImage *)other {
  /// On iOS 13, UIImage `isEqual:` somehow changes internally and doesn't work for `NSProxy`,
  /// here we forward the message to internal images manually
  UIImage *realSelf = self;
  UIImage *realOther = other;
  if (object_getClass(self) == TMDynamicImageProxy.class) {
    realSelf = ((TMDynamicImageProxy *)self).resolvedImage;
  }
  if (object_getClass(other) == TMDynamicImageProxy.class) {
    realOther = ((TMDynamicImageProxy *)other).resolvedImage;
  }
  return [realSelf tm_isEqual:realOther];
}

@end
