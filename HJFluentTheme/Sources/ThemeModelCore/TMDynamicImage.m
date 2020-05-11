//
//  TMDynamicImage.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "TMDynamicImage.h"
#import "TMTraitCollection.h"
#import "NSObject+ThemeModeKit.h"
@import ObjectiveC;

@interface TMDynamicImageProxy ()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) NSString *themeMode;
@property (nonatomic, strong) TMDynamicMethod *method;
@end

@implementation TMDynamicImageProxy
- (instancetype)initWithImagePath:(NSString *)path {
    NSString *basePath = [NSString stringWithFormat:@"%@.%@",TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode,path];
    NSString *imageStr = [TMTraitCollection.currentTraitCollection.themeConfiguration resolveSpecificImagePath:basePath];
    self.currentImage = [UIImage imageNamed:imageStr];
    if (self.currentImage == nil) {
        self.currentImage = [UIImage new];
    }
    self.path = path;
    return self;
}

- (UIImage *)resolvedImage {
    if([_themeMode isEqualToString:TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode] && self.currentImage){
        return self.currentImage;
    }
    NSString *basePath = [NSString stringWithFormat:@"%@.%@",TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode,self.path];
    NSString *imageStr = [TMTraitCollection.currentTraitCollection.themeConfiguration resolveSpecificImagePath:basePath];
    UIImage *modeImage =[UIImage imageNamed:imageStr];
    if (modeImage == nil) {
        return self.currentImage;
    }
    self.themeMode = TMTraitCollection.currentTraitCollection.themeConfiguration.themeMode;
    if (_method){
        modeImage = [modeImage performSelector:NSSelectorFromString(_method.selector) withObjects:_method.parameters];
    }
    self.currentImage = modeImage;
    return self.currentImage;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
  return [self.resolvedImage methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
  [invocation invokeWithTarget:self.resolvedImage];
}

#pragma mark - Public Methods

/// Passing these public methods to both light and dark images
/// instead of only to the `resolvedImage`

- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets {
    TMDynamicImageProxy *proxy = [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    proxy.currentImage = [proxy.currentImage resizableImageWithCapInsets:capInsets];
    proxy.method = [TMDynamicMethod dynamicMethodWithSelector:NSStringFromSelector(@selector(resizableImageWithCapInsets:)) Parameters:@[NSStringFromUIEdgeInsets(capInsets)]];
    return (UIImage *)proxy;
}

- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode {
    TMDynamicImageProxy *proxy = [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    proxy.currentImage = [proxy.currentImage resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    proxy.method = [TMDynamicMethod dynamicMethodWithSelector:NSStringFromSelector(@selector(resizableImageWithCapInsets: resizingMode:)) Parameters:@[NSStringFromUIEdgeInsets(capInsets),@(resizingMode)]];
    return (UIImage *)proxy;
}

- (UIImage *)imageWithAlignmentRectInsets:(UIEdgeInsets)alignmentInsets {
    TMDynamicImageProxy *proxy = [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    proxy.currentImage = [proxy.currentImage imageWithAlignmentRectInsets:alignmentInsets];
    proxy.method = [TMDynamicMethod dynamicMethodWithSelector:NSStringFromSelector(@selector(imageWithAlignmentRectInsets:)) Parameters:@[NSStringFromUIEdgeInsets(alignmentInsets)]];
    return (UIImage *)proxy;
}

- (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode {
    TMDynamicImageProxy *proxy = [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    proxy.currentImage = [proxy.currentImage imageWithRenderingMode:renderingMode];
    proxy.method = [TMDynamicMethod dynamicMethodWithSelector:NSStringFromSelector(@selector(imageWithRenderingMode:)) Parameters:@[@(renderingMode)]];
    return (UIImage *)proxy;
}

- (UIImage *)imageFlippedForRightToLeftLayoutDirection {
    TMDynamicImageProxy *proxy = [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    proxy.currentImage = [proxy.currentImage imageFlippedForRightToLeftLayoutDirection];
    proxy.method = [TMDynamicMethod dynamicMethodWithSelector:NSStringFromSelector(@selector(imageFlippedForRightToLeftLayoutDirection)) Parameters:@[]];
    return (UIImage *)proxy;
}

- (UIImage *)imageWithHorizontallyFlippedOrientation {
    TMDynamicImageProxy *proxy = [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    proxy.currentImage = [proxy.currentImage imageWithHorizontallyFlippedOrientation];
    proxy.method = [TMDynamicMethod dynamicMethodWithSelector:NSStringFromSelector(@selector(imageWithHorizontallyFlippedOrientation)) Parameters:@[]];
    return (UIImage *)proxy;
}

- (id)copy {
  return [self copyWithZone:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
}

@end

