//
//  TMDynamicColor.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "TMDynamicColor.h"

@interface TMDynamicColorProxy : NSProxy <NSCopying>

@property (nonatomic, readonly) UIColor *resolvedColor;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) NSString *path;

@end

@implementation TMDynamicColorProxy

- (instancetype)initWithColorPath:(NSString *)path {
    self.currentColor = [UIColor colorNamed:path];
    return self;
}

- (UIColor *)resolvedColor {
//  if (DMTraitCollection.currentTraitCollection.userInterfaceStyle == DMUserInterfaceStyleDark) {
//    return self.darkColor;
//  } else {
//    return self.lightColor;
//  }
    return self.currentColor;
}

// MARK: NSProxy
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.resolvedColor methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.resolvedColor];
}

// MARK: NSObject
- (BOOL)isKindOfClass:(Class)aClass {
  static TMDynamicColor *dynamicColor = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dynamicColor = [[TMDynamicColor alloc] init];
  });
  return [dynamicColor isKindOfClass:aClass];
}


// MARK: NSCopying
- (id)copy {
  return [self copyWithZone:nil];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [[TMDynamicColorProxy alloc] initWithColorPath:self.path];
}

@end

@implementation TMDynamicColor
- (instancetype)initWithColorPath:(NSString *)path {
    return (TMDynamicColor *)[[TMDynamicColorProxy alloc] initWithColorPath:path];
}

@end
