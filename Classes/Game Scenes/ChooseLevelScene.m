//
//  LevelNameScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 06.03.14.
//  Copyright 2014 Артур. All rights reserved.
//

#import "ChooseLevelScene.h"

#import "PackScene.h"
#import "Sounds.h"

//#import "Level1Scene.h"
#import "Level1Scene.h"

#import "LevelRulesScene.h"
#import "LevelNameScene.h"

#import "CCScene+Extension.h"
#import "CCAnimation.h"

#import "CCLabelTTF+Extension.h"
#import "CCButton+Extension.h"
#import "CCSprite+Extension.h"

#import "Extensions.h"

@implementation ChooseLevelScene
{
    CCSprite *_background;
}

+ (ChooseLevelScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    // Add a background sprite
    _background = [CCSprite spriteWithImageNamed:@"yellow-background.jpg"];
    _background.position  = ccp(WIDTH*0.5,HEIGHT*0.5);
    [self addChild:_background];
    
    if (IS_IPHONE) _background.scale = 0.5;
    
    [self setLevelButtons];
    [self setBackButton];
    
    return self;
}

- (void)setLevelButtons {
    
    float x_ = 0;
    for (NSInteger i = 1; i <= 6; i ++) {
    
       CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"Level%ld.png",(long)i]]];
        
        [button setPositionType:CCPositionTypeNormalized];
        
        if (i>2) [button setBackgroundOpacity:0.5 forState:CCControlStateNormal];
        
        NSInteger y_ = i;
        if (i > 3) {
            x_ = 0.5;
            y_ = i-3;
        }

        [button setPosition:ccp(0.25+x_, 1.075 - 0.3*y_)];
        
        if (i<=4) {
        [self animateStarsWithPosition:ccp(0.25+x_, 1.075 - 0.3*y_) andZ:200+i];
        }
        
        //CGFloat xPos = 0.25+x_;
        //CGFloat yPos = 1.075 - 0.3*y_;
        

        
        CGFloat bx = button.position.x;
        CGFloat by = button.position.y;
        
        CCSprite *numerok = [CCSprite createSpriteWithImage:@"numerok.png" andPositionType:YES andPosition:ccp(button.position.x+0.175,button.position.y+0.1) andNode:self andZ:1000+i];
        numerok.scale = 0.6;
        
        CCLabelTTF *numerokLabel = [CCLabelTTF createLabelWithColor:[CCColor yellowColor] andPositionType:YES andString:[NSString stringWithFormat:@"%d",i] andOpacity:1.0 andFontName:@"Minnie.TTF" andFontSize:30 andPosition:numerok.position andNode:self  andZ:1100+1];
        
        [button setTarget:self selector:@selector(onLevelButtonPressed:)];
        [self addChild:button z:100+i];
        
        
        if (IS_IPHONE) button.scale = 0.55;
    }
}

- (void)onNumerok:(id)sender
{
    
}

- (void)animateStarsWithPosition:(CGPoint)position andZ:(NSInteger)z
{
    NSMutableArray *frames = [NSMutableArray array];
    
    for (int i = 1; i <= 3; i++) {
        CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"star0%d.png",i]];
        
        [frames addObject:frame];
    }
    
    CCSprite *sprite = [CCSprite spriteWithSpriteFrame:frames.firstObject];
    // or to whatever object it will be parented to
    [sprite setPositionType:CCPositionTypeNormalized];
    sprite.position = position;
    [self addChild:sprite z:z];
    
    //sprite setPosition:(CGPoint)
    
    sprite.scale = 0.55;
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frames delay:0.1];
    CCActionAnimate *animateAction = [CCActionAnimate actionWithAnimation:animation];
    
    CCActionRepeatForever *repeat = [CCActionRepeatForever actionWithAction:animateAction];
    
    [sprite runAction:repeat];
}




#pragma mark Buttons:
- (void)onLevelButtonPressed:(CCButton *)sender
{
    LEVEL_CHOOSE_SND;
    
    if (sender.zOrder == 101) {
//         [[CCDirector sharedDirector] replaceScene:[Level1Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
        [[NSUserDefaults standardUserDefaults] setObject:@"Level1" forKey:@"GameScene"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //LEVEL_NAME_SCENE
        LevelNameScene *nameScene = [[LevelNameScene alloc]init];
        nameScene.word1 = @"Rock";
        nameScene.word2 = @"Paper";
        nameScene.word3 = @"Scissors";
        nameScene.stage = @"Level1";
        [nameScene animateLevelName];
        [nameScene setLevelStage];
         [[CCDirector sharedDirector] replaceScene:nameScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
        
       
    }
    else if (sender.zOrder == 102) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Level2" forKey:@"GameScene"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //LEVEL_NAME_SCENE
        LevelNameScene *nameScene = [[LevelNameScene alloc]init];
        nameScene.word1 = @"oh";
        nameScene.word2 = @"I Loves,";
        nameScene.word3 = @"Maths";
        nameScene.stage = @"Level2";
        [nameScene animateLevelName];
        [nameScene setLevelStage];
        [[CCDirector sharedDirector] replaceScene:nameScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
        
        
        CCLOG(@"Level2");
    }
    else if (sender.zOrder == 103) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Level3" forKey:@"GameScene"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //LEVEL_NAME_SCENE
        LevelNameScene *nameScene = [[LevelNameScene alloc]init];
        nameScene.word1 = @"oh";
        nameScene.word2 = @"I Loves,";
        nameScene.word3 = @"Dice";
        nameScene.stage = @"Level3";
        [nameScene animateLevelName];
        [nameScene setLevelStage];
        [[CCDirector sharedDirector] replaceScene:nameScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
        
        CCLOG(@"Level3");
    }
    else if (sender.zOrder == 104) {
        CCLOG(@"Level4");
    }
    else if (sender.zOrder == 105) {
        CCLOG(@"Level5");
    }
    else if (sender.zOrder == 106) {
        CCLOG(@"Level6");
    }
    
    //Transition to Level Rules
    
     
    
}

- (void)onBackButtonPressed:(id)sender {
    DEF_CLICK_SND;
    
    [[CCDirector sharedDirector] replaceScene:[PackScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}



@end
