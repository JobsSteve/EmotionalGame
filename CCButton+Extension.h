//
//  CCButton+Extension.h
//  EmotionalGame
//
//  Created by artoorix on 21.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCButton.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface CCButton (Extension)

+ (CCButton *)createButtonWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

// +Selector
+ (CCButton *)createButtonWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andSelector:(SEL)selector;

// +String +Selector
+ (CCButton *)createButtonWithString:(NSString *)textString andImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andSelector:(SEL)selector;

//+ String + PositionType
+ (CCButton *)createButtonWithString:(NSString *)textString andPositionType:(BOOL)positionType andImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andSelector:(SEL)selector;

@end
