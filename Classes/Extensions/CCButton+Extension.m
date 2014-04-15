//
//  CCButton+Extension.m
//  EmotionalGame
//
//  Created by artoorix on 21.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCButton+Extension.h"

@implementation CCButton (Extension)


+ (CCButton *)createButtonWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCButton *button = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:image]];
    button.position = point;
    
    if (z && scene) {
        [scene addChild:button z:z];
    } else if (z==0 && scene) {
        [scene addChild:button];
    }
    
    button.scale = 0.5;
    
    return button;
}

//+ Selector
+ (CCButton *)createButtonWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andSelector:(SEL)selector
{
    CCButton *button = [CCButton createButtonWithImage:image andPosition:point andNode:scene andZ:z];
    
    [button setTarget:scene selector:selector];
    
    return button;
}

//+ String
+ (CCButton *)createButtonWithString:(NSString *)textString andImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andSelector:(SEL)selector
{
    CCButton *button = [CCButton buttonWithTitle:textString spriteFrame:[CCSpriteFrame frameWithImageNamed:image]];
    button.position = point;
    
   //[button setPositionType:CCPositionTypeNormalized];
    
    if (z && scene) {
        [scene addChild:button z:z];
    } else if (z==0 && scene) {
        [scene addChild:button];
    }
    
    button.scale = 0.5;
    
    [button setTarget:scene selector:selector];
    
    return button;
    
}

//+ String + PositionType
+ (CCButton *)createButtonWithString:(NSString *)textString andPositionType:(BOOL)positionType andImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andSelector:(SEL)selector
{
    CCButton *button = [CCButton buttonWithTitle:textString spriteFrame:[CCSpriteFrame frameWithImageNamed:image]];
    button.position = point;
    
    if (positionType == YES) {
        [button setPositionType:CCPositionTypeNormalized];
    }
    
    if (z && scene) {
        [scene addChild:button z:z];
    } else if (z==0 && scene) {
        [scene addChild:button];
    }
    
    button.scale = 0.5;
    
    [button setTarget:scene selector:selector];
    
    return button;
    
}

@end
