//
//  WinScene.h
//  EmotionalGame
//
//  Created by artoorix on 09.04.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface WinScene : CCScene

@property (nonatomic, assign) NSInteger pointsNumber;

+ (WinScene *)scene;
- (id)init;

- (void)pointsLabel;

- (void)setWinBackground;

//- (void)setLooseBackground;

//- (void)setPointsLabelWithString:(NSString *)string;



@end
