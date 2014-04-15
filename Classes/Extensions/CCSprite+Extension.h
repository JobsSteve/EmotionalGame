//
//  CCSprite+Extension.h
//  EmotionalGame
//
//  Created by artoorix on 21.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCSprite.h"

@interface CCSprite (Extension)

//+ (CCSprite *)createSpriteWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

//SPRITE
+ (CCSprite *)createSpriteWithImage:(NSString *)image andPositionType:(BOOL)normalize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

@end
