//
//  LevelNameScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 14.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "LevelNameScene.h"

#import "LevelRulesScene.h"
#import "Sounds.h"

#import "CCLabelTTF+Extension.h"

@interface LevelNameScene ()

@property (nonatomic, copy) NSString *levelName;

@end

@interface LevelNameScene ()



@end

@implementation LevelNameScene

+(LevelNameScene *)scene
{
    return [[self alloc] init];
}

-(id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCSprite *bkg = [CCSprite spriteWithImageNamed:@"green-background.jpg"];
    bkg.position = ccp(WIDTH/2,HEIGHT/2);
    [self addChild:bkg];
    
    if (IS_IPHONE) bkg.scale = 0.5;
    
    //[self animateLevelName];
    
    return self;
}

- (void)animateLevelName
{
    //Minnie.TTF
    
//    //Rock Paper Scissors
//    CCLabelTTF *label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %@ ", _word1] fontName:@"Minnie.TTF" fontSize:50.0f];
//    label1.position = ccp(WIDTH*0.5, HEIGHT*0.7);
//    label1.scaleX = 0.0;
//    label1.scaleY = 1.0;
//    [self addChild:label1];
    
    
    CCLabelTTF *label1 = [CCLabelTTF createDoubleLabelWithFrontColor:[CCColor yellowColor] andBackColor:[CCColor blackColor] andXOffset:5 andYOffset:5 andString:_word1 andOpacity:0.99 andFontName:@"Minnie.TTF" andFontSize:50 andPosition:ccp(WIDTH*0.5, HEIGHT*0.7) andNode:self andZ:700 andScaleX:0.0 andScaleY:1.0];
  
    
//    CCLabelTTF *label2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %@ ", _word2]  fontName:@"Minnie.TTF" fontSize:50.0f];
//    //CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Papers" fontName:@"" fontSize:50.0f dimensions:CGSizeMake(250, 150)];
//    label2.position = ccp(WIDTH*0.5, HEIGHT*0.5);
//    label2.scaleX = 0.0;
//    label2.scaleY = 1.0;
//    [self addChild:label2];
    
    CCLabelTTF *label2 = [CCLabelTTF createDoubleLabelWithFrontColor:[CCColor yellowColor] andBackColor:[CCColor blackColor] andXOffset:5 andYOffset:5 andString:_word2 andOpacity:0.99 andFontName:@"Minnie.TTF" andFontSize:50 andPosition:ccp(WIDTH*0.5, HEIGHT*0.5) andNode:self andZ:701 andScaleX:0.0 andScaleY:1.0];
    

//    CCLabelTTF *label3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %@ ", _word3] fontName:@"Minnie.TTF" fontSize:50.0f];
//    label3.position = ccp(WIDTH*0.5, HEIGHT*0.3);
//    label3.scaleX = 0.0;
//    label3.scaleY = 1.0;
//    [self addChild:label3];
    
    CCLabelTTF *label3 = [CCLabelTTF createDoubleLabelWithFrontColor:[CCColor yellowColor] andBackColor:[CCColor blackColor] andXOffset:5 andYOffset:5 andString:_word3 andOpacity:0.99 andFontName:@"Minnie.TTF" andFontSize:50 andPosition:ccp(WIDTH*0.5, HEIGHT*0.3) andNode:self andZ:703 andScaleX:0.0 andScaleY:1.0];
    
    
    
    [self performSelector:@selector(animateLabel:) withObject:label1 afterDelay:0.5];
    [self performSelector:@selector(animateLabel:) withObject:label2 afterDelay:1.0];
    [self performSelector:@selector(animateLabel:) withObject:label3 afterDelay:1.5];
    
    [self performSelector:@selector(transitionToLevelRulesScene) withObject:nil afterDelay:2.5];
    
}

- (void)animateLabel:(CCLabelTTF *)label
{
    SND_LABEL_FALL;
    
    CCActionScaleTo *scale = [CCActionScaleTo actionWithDuration:0.2 scaleX:1.0 scaleY:1.0];
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:0.25 position:ccp(label.position.x, label.position.y-20)];
    
    CCActionSpawn *spawn = [CCActionSpawn actions:scale,move, nil];
    
    CCActionMoveTo *moveBack = [CCActionMoveTo actionWithDuration:0.1 position:ccp(label.position.x, label.position.y+20)];
    
    CCActionSequence *sequence = [CCActionSequence actions:spawn,moveBack, nil];
    
    [label runAction:sequence];
}

- (void)transitionToLevelRulesScene
{
    //RIGHT CHOOSE
    [[CCDirector sharedDirector] replaceScene:[LevelRulesScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)setLevelStage
{
    CCLabelTTF *stage = [CCLabelTTF labelWithString:_stage fontName:@"Minnie.TTF" fontSize:35];
    stage.position = ccp(WIDTH*0.75, HEIGHT*0.9);
    stage.color = [CCColor blackColor];
    [self addChild:stage];
    
}



@end
