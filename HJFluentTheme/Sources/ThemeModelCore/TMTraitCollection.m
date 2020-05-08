//
//  TMTraitCollection.m
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

#import "TMTraitCollection.h"

@implementation TMTraitCollection
static TMTraitCollection *_currentTraitCollection = nil;

+ (TMTraitCollection *)currentTraitCollection {
  return _currentTraitCollection;
}

+ (void)setCurrentTraitCollection:(TMTraitCollection *)currentTraitCollection {
  _currentTraitCollection = currentTraitCollection;
}

+ (TMTraitCollection *)traitCollectionWithUserInterfaceStyle:(TMUserInterfaceStyle)userInterfaceStyle {
  TMTraitCollection *traitCollection = [[TMTraitCollection alloc] init];
  traitCollection->_userInterfaceStyle = userInterfaceStyle;
  return traitCollection;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _userInterfaceStyle = TMUserInterfaceStyleUnspecified;
  }
  return self;
}
@end
