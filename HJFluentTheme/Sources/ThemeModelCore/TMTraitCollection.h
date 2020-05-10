//
//  TMTraitCollection.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TMUserInterfaceStyle) {
  TMUserInterfaceStyleUnspecified,
  TMUserInterfaceStyleLight,
  TMUserInterfaceStyleDark
};
@protocol TMThemeConfiguration;

@interface TMTraitCollection : NSObject
@property (class, nonatomic, strong) TMTraitCollection *currentTraitCollection;

+ (TMTraitCollection *)traitCollectionWithUserInterfaceStyle:(TMUserInterfaceStyle)userInterfaceStyle themeConfiguration:(id<TMThemeConfiguration>)themeConfiguration;

@property (nonatomic, readonly) TMUserInterfaceStyle userInterfaceStyle;
@property (nonatomic, readonly) id<TMThemeConfiguration> themeConfiguration;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
@end

#pragma mark - TMTraitEnvironment

@protocol TMTraitEnvironment <NSObject>

- (void)tmTraitCollectionDidChange:(nullable TMTraitCollection *)previousTraitCollection;

@end

#pragma mark - TMThemeConfiguration

@protocol TMThemeConfiguration <NSObject>

@property (nonatomic, copy) NSString *themeMode;

- (nullable NSString *)resolveSpecificColorPath:(NSString *)path;

- (nullable NSString *)resolveSpecificImagePath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
