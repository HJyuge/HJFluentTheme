//
//  TMTraitCollection.h
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TMUserInterfaceStyle) {
  TMUserInterfaceStyleUnspecified,
  TMUserInterfaceStyleLight,
  TMUserInterfaceStyleDark,
  TMUserInterfaceStyleOther,
};

@interface TMTraitCollection : NSObject
@property (class, nonatomic, strong) TMTraitCollection *currentTraitCollection;

+ (TMTraitCollection *)traitCollectionWithUserInterfaceStyle:(TMUserInterfaceStyle)userInterfaceStyle;

@property (nonatomic, readonly) TMUserInterfaceStyle userInterfaceStyle;

- (instancetype)init NS_DESIGNATED_INITIALIZER;
@end

#pragma mark - TMTraitEnvironment

@protocol TMTraitEnvironment <NSObject>

- (void)tmTraitCollectionDidChange:(nullable TMTraitCollection *)previousTraitCollection;

@end


NS_ASSUME_NONNULL_END
