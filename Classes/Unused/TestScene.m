//
//  TestScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 12.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "TestScene.h"


@implementation TestScene

+ (TestScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithWhite:0.7 alpha:0.9]];
    [self addChild:background];
    
    
    [self setTimerLabel];
    
    return self;
}

- (void)setTimerLabel {
    
    CCSprite *_labelSprite = [CCSprite spriteWithImageNamed:@"default-white.png"];
    [_labelSprite setColor:[CCColor colorWithWhite:0.5 alpha:0.5]];
    _labelSprite.position  = ccp(0+_labelSprite.contentSize.width*0.5,HEIGHT*0.5);
    [self addChild:_labelSprite];
    

    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"1234" fontName:@"Minnie.TTF" fontSize:100.0f];
    label.positionType = CCPositionTypeNormalized;
    //label.color = [CCColor greenColor];
    label.position = ccp(0.5, 0.5f); // Middle of screen
    [_labelSprite addChild:label z:1000];
    //_labelSprite.scaleX = 1.2;
    _labelSprite.scale = 1.2;
    
    _labelSprite.rotation = 20;
}

@end
