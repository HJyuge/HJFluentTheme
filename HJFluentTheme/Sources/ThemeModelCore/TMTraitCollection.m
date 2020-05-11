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

+ (TMTraitCollection *)traitCollectionWithUserInterfaceStyle:(TMUserInterfaceStyle)userInterfaceStyle themeConfiguration:(id<TMThemeConfiguration>)themeConfiguration;{
    TMTraitCollection *traitCollection = [[TMTraitCollection alloc] init];
    traitCollection->_userInterfaceStyle = userInterfaceStyle;
    traitCollection->_themeConfiguration = themeConfiguration;
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

@interface TMDynamicMethod ()
@property (nonatomic, strong) NSArray *parameters;
@property (nonatomic, copy) NSString *selector;
@end

@implementation TMDynamicMethod
+ (instancetype)dynamicMethodWithSelector:(NSString *)selector Parameters:(NSArray *)parameters {
    TMDynamicMethod *method = [[TMDynamicMethod alloc] init];
    [method setSelector:selector Parameters:parameters];
    return method;
}

- (void)setSelector:(NSString *)selector Parameters:(NSArray *)parameters {
    self.parameters = parameters;
    self.selector = selector;
}
@end
