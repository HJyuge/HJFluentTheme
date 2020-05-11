//
//  NSObject+ThemeModeKit.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "NSObject+ThemeModeKit.h"
@import ObjectiveC;
@import UIKit;

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

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if (signature == nil){
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    NSInteger paramsCount = signature.numberOfArguments - 2;
    paramsCount = MIN(paramsCount, objects.count);
    for (int i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        if ([object isKindOfClass:[NSNumber class]]) {
            const char *type = [signature getArgumentTypeAtIndex:i + 2];
            if (strcmp(type, "f") == 0){
                float value = [object floatValue];
                [invocation setArgument:&value atIndex:i+2];
            }else if (strcmp(type, "s") == 0){
                short value = [object shortValue];
                [invocation setArgument:&value atIndex:i+2];
            }else if (strcmp(type, "l") == 0){
                long value = [object longValue];
                [invocation setArgument:&value atIndex:i+2];
            }else if (strcmp(type, "q") == 0){
                long long value = [object longLongValue];
                [invocation setArgument:&value atIndex:i+2];
            }else if (strcmp(type, "d") == 0){
                double value = [object doubleValue];
                [invocation setArgument:&value atIndex:i+2];
            }else if (strcmp(type, "B") == 0){
                BOOL value = [object boolValue];
                [invocation setArgument:&value atIndex:i+2];
            }
        }else if ([object isKindOfClass:[NSString class]]){
            const char *type = [signature getArgumentTypeAtIndex:i + 2];
            if (strcmp(type, "{UIEdgeInsets=dddd}") == 0) {
                UIEdgeInsets insets = UIEdgeInsetsFromString(object);
                [invocation setArgument:&insets atIndex:i+2];
            }else if (strcmp(type, "{CGPoint=dd}") == 0) {
                CGPoint point = CGPointFromString(object);
                [invocation setArgument:&point atIndex:i+2];
            }else if (strcmp(type, "{CGSize=dd}") == 0) {
                CGSize size = CGSizeFromString(object);
                [invocation setArgument:&size atIndex:i+2];
            }else if (strcmp(type, "{CGRect={CGPoint=dd}{CGSize=dd}}") == 0) {
                CGRect rect = CGRectFromString(object);
                [invocation setArgument:&rect atIndex:i+2];
            }else if (strcmp(type, "{CGVector=dd}") == 0) {
                CGVector vector = CGVectorFromString(object);
                [invocation setArgument:&vector atIndex:i+2];
            }else if (strcmp(type, "{CGAffineTransform=dddddd}") == 0) {
                CGAffineTransform transform = CGAffineTransformFromString(object);
                [invocation setArgument:&transform atIndex:i+2];
            }
        }else {
            [invocation setArgument:&object atIndex:i+2];
        }
    }
    [invocation invoke];
    __autoreleasing id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    return  returnValue;
}
@end
