//
//  FailScene.h
//  ThreeButtonProject
//
//  Created by artoorix on 14.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface FailScene : CCScene

@property (nonatomic, assign) NSInteger pointsNumber;

+ (FailScene *)scene;
- (id)init;

- (void)pointsLabel;
- (void)setLooseBackground;

- (void)setWinBackground;
- (void)setPointsLabelWithString:(NSString *)string;

@end
