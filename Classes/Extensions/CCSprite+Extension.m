//
//  CCSprite+Extension.m
//  EmotionalGame
//
//  Created by artoorix on 21.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCSprite+Extension.h"

@implementation CCSprite (Extension)

//SPRITE
+ (CCSprite *)createSpriteWithImage:(NSString *)image andPositionType:(BOOL)normalize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCSprite *sprite = [CCSprite spriteWithImageNamed:image];
    
    if (normalize == YES ) {
    [sprite setPositionType:CCPositionTypeNormalized];
    }
    
    sprite.position = point;
    
    
    
    if (z && scene) {
        
        [scene addChild:sprite z:z];
    } else if(z==0 && scene) {
        
        [scene addChild:sprite];
    }
    
    sprite.scale = 0.5;
    
    return sprite;
}
@end
