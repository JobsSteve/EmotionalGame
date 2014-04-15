//
//  CCScene+Extension.m
//  ThreeButtonProject
//
//  Created by artoorix on 11.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCScene+Extension.h"
#import "Sounds.h"

#import "ChooseLevelScene.h"
#import "PackScene.h"
#import "IntroScene.h" //HomeScene

@implementation CCScene (Extension)

#pragma mark - Back Button
- (void)setBackButton
{
    CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button-back.png"]];
    [button setPositionType:CCPositionTypeNormalized];
    [button setPosition:ccp(0.08, 0.95)];
    [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
    [button setTarget:self selector:@selector(onBackButtonPressed:)];
    
    [self addChild:button z:111];
    
    if (IS_IPHONE) button.scale = 0.6;
}

- (void)onBackButtonPressed:(id)sender {
    DEF_CLICK_SND;
    
    NSString *gameScene = [[NSUserDefaults standardUserDefaults] objectForKey:@"GameScene"];
    
    if ( [gameScene rangeOfString:@"Level"].location != NSNotFound ) {
        // do something if the string is found
         [[CCDirector sharedDirector] replaceScene:[ChooseLevelScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
    else {
        [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
}


#pragma mark - Gameplay Buttons

- (void)setThreeButtonsWithName:(NSString *)name
{
    CCButton *button;
    for (NSInteger i=1; i<=3; i++)
    {
        button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@%ld.png",name,(long)i]]];
        [button setPositionType:CCPositionTypeNormalized];
        
        [button setPosition:ccp(-0.161+0.33*i, 0.12)];
        button.scale = 1.1;
        
        if (IS_IPHONE && !IS_IPHONE_5) {
            
            [button setPosition:ccp(-0.161+0.33*i, 0.11)];
            button.scale = 0.46;
        }
        else if (IS_IPHONE_5) {
            [button setPosition:ccp(-0.161+0.33*i, 0.09)];
            button.scale = 0.46;
        }
        [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
        [button setTarget:self selector:@selector(onGameplayButtonPressed:)];
        
        [self addChild:button z:1000+i];
    }
}

- (void)setThreeButtons
{
    CCButton *button;
    for (NSInteger i=1; i<=3; i++)
    {
        button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"Gamebutton%ld.png",(long)i]]];
        [button setPositionType:CCPositionTypeNormalized];
        
        [button setPosition:ccp(-0.161+0.33*i, 0.12)];
        button.scale = 1.1;
        
        if (IS_IPHONE && !IS_IPHONE_5) {
            
            [button setPosition:ccp(-0.161+0.33*i, 0.11)];
            button.scale = 0.46;
        }
        else if (IS_IPHONE_5) {
            [button setPosition:ccp(-0.161+0.33*i, 0.09)];
            button.scale = 0.46;
        }
        [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
        [button setTarget:self selector:@selector(onGameplayButtonPressed:)];
        
        [self addChild:button z:1000+i];
    }
}

- (void)setThreeButtonsWithThreeStrings:(NSArray *)threeStrings
{
    CCButton *button;
    for (NSInteger i=1; i<=3; i++)
    {
        button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"Gamebutton%ld.png",(long)i]]];
        [button setPositionType:CCPositionTypeNormalized];
        
        [button setPosition:ccp(-0.161+0.33*i, 0.12)];
        button.scale = 1.1;
        
        if (IS_IPHONE && !IS_IPHONE_5) {
            
            [button setPosition:ccp(-0.161+0.33*i, 0.11)];
            button.scale = 0.46;
        }
        else if (IS_IPHONE_5) {
            [button setPosition:ccp(-0.161+0.33*i, 0.09)];
            button.scale = 0.46;
        }
        [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
        [button setTarget:self selector:@selector(onGameplayButtonPressed:)];
        
        //if (i == 1) {
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Default" fontName:@"Minnie.TTF" fontSize:65 dimensions:CGSizeMake(250, 250)];
        //label.position = ccp(button.CONTENTWIDTH*0.5, button.CONTENTHEIGHT*0.5);
        label.anchorPoint = ccp(-0.05, 0.35);
        if (i == 2) label.anchorPoint = ccp(0.05,0.4);
        label.position = ccp(0,0);
        
        [button addChild:label];
        
        [label setString:[NSString stringWithFormat:@" %@ ",threeStrings[i-1]]];
        //}
        
        [self addChild:button z:1000+i];
    }
}


- (void)setThreeButtonsWithFirstNumber:(NSNumber *)first andSecond:(NSNumber *)second andThird:(NSNumber *)third
{
    
}

- (void)onGameplayButtonPressed:(CCButton *)sender {
    DEF_CLICK_SND;
    
    if (sender.zOrder == 1001) {

    }
    else if (sender.zOrder == 1002) {

    }
    else if (sender.zOrder == 1003) {

    }
}

#pragma mark - Pause and Restart Button
- (void)setPauseButton
{
    CCButton *pauseButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pause-btn.png"]];
    pauseButton.position = ccp(WIDTH*0.9, HEIGHT*0.9);
    [self addChild:pauseButton z:3001];
    
    if (IS_IPHONE) pauseButton.scale = 0.4;
    
    [pauseButton setTarget:self selector:@selector(pauseButtonPressed:)];
}

- (void)setRestartButton
{
    CCButton *restartButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"restart-btn.png"]];
    restartButton.position = ccp(WIDTH*0.9, HEIGHT*0.8);
    [self addChild:restartButton z:3002];
    
     if (IS_IPHONE) restartButton.scale = 0.4;
    
    [restartButton setTarget:self selector:@selector(restartButtonPressed:)];
}

- (void)pauseButtonPressed:(id)sender
{
    DEF_CLICK_SND;   NSLog(@"pauseButton in category");
    
    [[CCDirector sharedDirector] pause];
}

- (void)restartButtonPressed:(id)sender
{
    DEF_CLICK_SND;   NSLog(@"restartButon in category");
    
    [[CCDirector sharedDirector] resume];
}

#pragma mark - Backgrounds
- (void)setBackgroundWithStripes {
    
    //Set stripes: Red, Orange, Blue
    // Add a background sprite
    CCSprite *background = [CCSprite spriteWithImageNamed:@"red-stripe.jpeg"];
    [background setPositionType:CCPositionTypeNormalized];
    //background.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    background.position = ccp(0.15, 0.5);
    background.scale = 1.2;
    
    if (IS_IPHONE) background.scale = 0.5;
    [self addChild: background];
    
    background = [CCSprite spriteWithImageNamed:@"orange-stripe.jpeg"];
    [background setPositionType:CCPositionTypeNormalized];
    background.position = ccp(0.5, 0.5);
    background.scale = 1.2;
    
    if (IS_IPHONE) background.scale = 0.5;
    [self addChild: background];
    
    background = [CCSprite spriteWithImageNamed:@"blue-stripe.jpeg"];
    [background setPositionType:CCPositionTypeNormalized];
    background.position = ccp(0.85, 0.5);
    background.scale = 1.2;
    
    if (IS_IPHONE) background.scale = 0.5;
    [self addChild: background];
}

- (void)setDefaultBackground
{
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithWhite:0.7 alpha:0.9]];
    [self addChild:background];
}

//[self setBackgroundWithImage:@"start-bg"];

-(void)setBackgroundWithImage:(NSString *)bg
{
    CCSprite *sprite = [CCSprite spriteWithImageNamed:bg];
    sprite.position = ccp(WIDTH*0.5, HEIGHT*0.5);
    
    sprite.scale = 0.5;
    
    [self addChild:sprite];
}


#pragma mark - Label

- (CCLabelTTF *)createLabelWithString:(NSString *)textString andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    [label setPosition:point];
    
    if (scene != nil) {
    [scene addChild:label z: z];
    }
    
    return label;
}

- (CCSprite *)createSpriteWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z


{
    CCSprite *sprite = [CCSprite spriteWithImageNamed:image];
    sprite.position = point;
    
    if (z && scene) {
        [scene addChild:sprite z:z];
    } else if(z==0 && scene) {
        [scene addChild:sprite];
    }

    return sprite;
}

- (CCButton *)createButtonWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
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



@end
