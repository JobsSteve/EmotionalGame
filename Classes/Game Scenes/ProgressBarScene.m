//
//  ProgressBarScene.m
//  EmotionalGame
//
//  Created by artoorix on 13.04.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "ProgressBarScene.h"

#import "CCScene+Extension.h"
#import "CCSprite+Extension.h"

#import "Extensions.h"

@interface ProgressBarScene()

@property (nonatomic, strong) CCSprite *kvadratSet;
@property (nonatomic, strong) CCSprite *kvadrat;

@end

@implementation ProgressBarScene

+ (ProgressBarScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    [self setBackButton];
    
//    CCSprite *bkg = [CCSprite spriteWithImageNamed:@"orange-background.jpg"];
//    bkg.position = ccp(WIDTH/2,HEIGHT/2);
//    [self addChild:bkg z:0];
    
    [self setProgressLayer];
    
    return self;
}

- (void)setProgressLayer
{
    CCSprite *layer = [CCSprite createSpriteWithImage:@"kvadrat-layer.png" andPositionType:NO andPosition:ccp(WIDTH*0.5,HEIGHT*0.5) andNode:self andZ:100];
    
   
    
    self.kvadratSet = [CCSprite createSpriteWithImage:@"kvadrat-set.png" andPositionType:NO andPosition:ccp(WIDTH*0.5,HEIGHT*0.7) andNode:self andZ:0];
    
    _kvadratSet.scaleX = 0.5;
    _kvadratSet.scaleY = 0.5;
    
    [self scalingByX];
    
}

- (void)scalingByX
{
//    [_kvadratSet setAnchorPoint:ccp(1.0, 0.5)];
//    CCActionScaleBy *scale = [CCActionScaleTo actionWithDuration:2.0 scaleX:0.5 scaleY:0.5];
//    CCAction *action = [CCActionRepeat actionWithAction:scale times:1];
//    [_kvadratSet runAction:scale];
    

//    CCClippingNode *nodd = [CCClippingNode clippingNodeWithStencil:_kvadratSet];
//    nodd.alphaThreshold = 0;
//    [nodd addChild:self.kvadrat];
//    [self addChild:nodd];
    
    
    CCNode *touchNode = [CCNode node];
    touchNode.userInteractionEnabled = YES;
    touchNode.multipleTouchEnabled = YES;
    touchNode.contentSize = CGSizeMake(100, 100);
    
    [touchNode setColor:[CCColor blackColor]];
    [touchNode setPositionType:CCPositionTypeNormalized];
    //touchNode.position = ccp(WIDTH*0.5, HEIGHT *0.3);
    
    
    
    [self addChild:touchNode z:200];
    
    
    //CCScene *scene = [[CCScene alloc] init];
    CCNodeColor *nodeColor = [CCNodeColor nodeWithColor:[CCColor redColor]];
    nodeColor.contentSize = CGSizeMake(150,150);
    nodeColor.anchorPoint = ccp(0.5,0.5);
    nodeColor.position = ccp(WIDTH*0.5, HEIGHT*0.5);
    [self addChild:nodeColor];
    
    
     self.kvadrat = [CCSprite createSpriteWithImage:@"kvadrat-light.png" andPositionType:NO andPosition:ccp(nodeColor.contentSize.width*0.5, nodeColor.contentSize.height*1.0) andNode:nodeColor andZ:0];
    
    //CCProgre
    
    
}

@end
