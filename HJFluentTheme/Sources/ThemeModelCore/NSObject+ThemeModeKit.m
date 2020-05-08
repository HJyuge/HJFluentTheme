//
//  NSObject+ThemeModeKit.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "NSObject+ThemeModeKit.h"
@import ObjectiveC;

@implementation NSObject (ThemeModeKit)
+ (BOOL)tm_swizzleInstanceMethod:(SEL)selector1 to:(SEL)selector2 {
  Method method1 = class_getInstanceMethod(self, selector1);
  Method method2 = class_getInstanceMethod(self, selector2);

  if (!method1 || !method2) {
    return NO;
  }

  if (class_addMethod(self, selector1, method_getImplementation(method2), method_getTypeEncoding(method2))) {
    class_replaceMethod(self, selector2, method_getImplementation(method1), method_getTypeEncoding(method1));
  } else {
    method_exchangeImplementations(method1, method2);
  }

  return YES;
}
@end
