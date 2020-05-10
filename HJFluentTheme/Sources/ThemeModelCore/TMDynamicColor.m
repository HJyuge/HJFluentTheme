//
//  TMDynamicColor.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "TMDynamicColor.h"
#import "TMTraitCollection.h"
#import "UIColor+ThemeModeKit.h"

@interface TMDynamicColorProxy : NSProxy <NSCopying>

@property (nonatomic, strong) UIColor *resolvedColor;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *themeMode;
@property (nonatomic, assign) CGFloat alpha;
@end

@implementation TMDynamicColorProxy

- (instancetype)initWithColorPath:(NSString *)path {
    NSString *basePath = [NSString stringWithFormat:@"%@.%@",TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode,path];
    NSString *colorStr = [TMTraitCollection.currentTraitCollection.themeConfiguration resolveSpecificColorPath:basePath];
    self.path = path;
    self.currentColor = [UIColor tm_colorWithHexString:colorStr];
    return self;
}

- (UIColor *)resolvedColor {
    if([_themeMode isEqualToString:TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode] && self.currentColor){
        return self.currentColor;
    }
    NSString *basePath = [NSString stringWithFormat:@"%@.%@",TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode,self.path];
    NSString *colorStr = [TMTraitCollection.currentTraitCollection.themeConfiguration resolveSpecificColorPath:basePath];
    UIColor *modeColor = [UIColor tm_colorWithHexString:colorStr];
    if (modeColor == nil) {
        return self.currentColor;
    }
    self.themeMode = TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode;
    if (self.alpha) {
        modeColor = [modeColor colorWithAlphaComponent:self.alpha];
    }
    self.currentColor = modeColor;
    return self.currentColor;
}

// MARK: UIColor
- (void)changeColorWithAlphaComponent:(CGFloat)alpha{
    self.alpha = alpha;
    self.currentColor = [self.currentColor colorWithAlphaComponent:alpha];
}
- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
    TMDynamicColorProxy *proxy = (TMDynamicColorProxy *)[[TMDynamicColor alloc] initWithColorPath:self.path];
    [proxy changeColorWithAlphaComponent:alpha];
    return (TMDynamicColor *)proxy;
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
