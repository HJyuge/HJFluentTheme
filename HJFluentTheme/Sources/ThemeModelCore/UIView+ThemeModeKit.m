//
//  UIView+ThemeModeKit.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "UIView+ThemeModeKit.h"
#import "TMDynamicColor.h"
@import ObjectiveC;

@implementation UIView (ThemeModeKit)

static void (*tm_original_setBackgroundColor)(UIView *, SEL, UIColor *);

static void tm_setBackgroundColor(UIView *self, SEL _cmd, UIColor *color) {
  if ([color isKindOfClass:[TMDynamicColor class]]) {
    self.tm_dynamicBackgroundColor = (TMDynamicColor *)color;
  } else {
    self.tm_dynamicBackgroundColor = nil;
  }
  tm_original_setBackgroundColor(self, _cmd, color);
}

// https://stackoverflow.com/questions/42677534/swizzling-on-properties-that-conform-to-ui-appearance-selector
+ (void)tm_swizzleSetBackgroundColor {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Method method = class_getInstanceMethod(self, @selector(setBackgroundColor:));
    tm_original_setBackgroundColor = (void *)method_getImplementation(method);
    method_setImplementation(method, (IMP)tm_setBackgroundColor);
  });
}

- (TMDynamicColor *)tm_dynamicBackgroundColor {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setTm_dynamicBackgroundColor:(TMDynamicColor *)tm_dynamicBackgroundColor {
  objc_setAssociatedObject(self,
                           @selector(tm_dynamicBackgroundColor),
                           tm_dynamicBackgroundColor,
                           OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
