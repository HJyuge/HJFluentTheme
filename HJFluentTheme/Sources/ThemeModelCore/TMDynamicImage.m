//
//  TMDynamicImage.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "TMDynamicImage.h"
#import "TMTraitCollection.h"
@import ObjectiveC;

@interface TMDynamicImageProxy ()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) NSString *themeMode;
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
    [proxy.currentImage resizableImageWithCapInsets:capInsets];
    return (UIImage *)proxy;
}

- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode {
    return [(UIImage *)[[TMDynamicImageProxy alloc] initWithImagePath:self.path] resizableImageWithCapInsets:capInsets resizingMode:resizingMode];;
}

- (UIImage *)imageWithAlignmentRectInsets:(UIEdgeInsets)alignmentInsets {
    UIImage *image = (UIImage *)[[TMDynamicImageProxy alloc] initWithImagePath:self.path];
    return [image imageWithAlignmentRectInsets:alignmentInsets];
}

- (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode {
    
    return [(UIImage *)[[TMDynamicImageProxy alloc] initWithImagePath:self.path] imageWithRenderingMode:renderingMode];
}

- (UIImage *)imageFlippedForRightToLeftLayoutDirection {
    
    return [(UIImage *)[[TMDynamicImageProxy alloc] initWithImagePath:self.path] imageFlippedForRightToLeftLayoutDirection];
}

- (UIImage *)imageWithHorizontallyFlippedOrientation {
    return [(UIImage *)[[TMDynamicImageProxy alloc] initWithImagePath:self.path] imageWithHorizontallyFlippedOrientation];
}

- (id)copy {
  return [self copyWithZone:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[TMDynamicImageProxy alloc] initWithImagePath:self.path];
}

@end

