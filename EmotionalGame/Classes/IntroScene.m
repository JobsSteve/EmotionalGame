//
//  IntroScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 05.03.14.
//  Copyright Артур 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
//#import "HelloWorldScene.h"
#import "PackScene.h"
#import <UIKit/UIKit.h>

#import "Extensions.h"
#import "Sounds.h"

#import "TestScene.h"

#import "Level1Scene.h"
#import "Level2Scene.h"
#import "Level3Scene.h"

#import "LevelNameScene.h"
#import "LevelRulesScene.h"
#import "SettingsScene.h"
#import "ProgressBarScene.h"

#import "CCButton+Extension.h"



#pragma mark - IntroScene

@implementation IntroScene
{
    CCSprite *_labelSprite;
}

+ (IntroScene *)scene {
	return [[self alloc] init];
}
- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithWhite:0.7 alpha:0.9]];
    [self addChild:background];
    
//    //PLAY
//    CCSprite* sprite = [CCSprite spriteWithImageNamed:@"play2.png"];
//    sprite.positionType = CCPositionTypeNormalized;
//    sprite.position = ccp(0.5f,0.35f);
//    [self addChild:sprite];

    [self setHomeMenu];
    
    [self setPlayButton];
    [self setGetButton];
    [self setRankButton];
    
    [self setSettingsButton];
    
    //[[OALSimpleAudio sharedInstance] playBg:@"themeMusic.mp3" loop:YES];
    
    //THEME_MUSIC;
    
    THEME_MUSIC_FLAG;
    
    //DEF_CLICK_SND;
    
    return self;
}

- (void)onPlayPressed:(id)sender
{
    CCLOG(@"playPressed");
}


- (void)setHomeMenu
{
    CGSize size = [[CCDirector sharedDirector] viewSize];
    CCLOG(@"%@",NSStringFromCGSize(size));
    
    
}


#pragma mark - Set Buttons 

- (void)setPlayButton
{
    CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button-play.png"]];
    [button setPositionType:CCPositionTypeNormalized];
    
    [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
    [button setTarget:self selector:@selector(onPlayButtonPressed:)];
    
    [self addChild:button z:100];
    
    if (IS_IPHONE) {
      button.scale = 0.7;
      [button setPosition:ccp(0.5, 0.3)];
    }
}

- (void)setGetButton
{
    CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button-get.png"]];
    [button setPositionType:CCPositionTypeNormalized];
    [button setPosition:ccp(0.65, 0.3)];
    [button setBackgroundOpacity:0.5 forState:CCControlStateNormal];
    [button setTarget:self selector:@selector(onGetButtonPressed:)];
    
    [self addChild:button];
    
    if (IS_IPHONE) {
        button.scale = 0.7;
        [button setPosition:ccp(0.75, 0.3)];
    }
}

- (void)setRankButton
{
    CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button-rank.png"]];
    [button setPositionType:CCPositionTypeNormalized];
    [button setPosition:ccp(0.35, 0.3)];
    [button setBackgroundOpacity:0.5 forState:CCControlStateNormal];
    [button setTarget:self selector:@selector(onRankButtonPressed:)];

    [self addChild:button];
    
    if (IS_IPHONE) {
        button.scale = 0.7;
        [button setPosition:ccp(0.25, 0.3)];
    }
}

#pragma mark SettingsButton
- (void)setSettingsButton
{
    CCButton *settingsButton = [CCButton createButtonWithImage:@"settings-btn.png" andPosition:ccp(WIDTH*0.5,HEIGHT*0.1) andNode:self andZ:0];
    
    
    [settingsButton setTarget:self selector:@selector(settingsButtonPressed:)];
}

- (void)settingsButtonPressed:(id)sender
{
    CCLOG(@"SettingsButton");
    
    SettingsScene *settingsScene = [SettingsScene scene];
    
    [[CCDirector sharedDirector] replaceScene:settingsScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}


#pragma mark - PLAY BUTTON
//PLAY BUTTON
- (void)onPlayButtonPressed:(id)sender {
    DEF_CLICK_SND;
    
    //PACK SCENE
    [[CCDirector sharedDirector] replaceScene:[PackScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    
    //[[CCDirector sharedDirector] replaceScene:[Level1Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    
    //[[CCDirector sharedDirector] replaceScene:[Level2Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    
    //[[CCDirector sharedDirector] replaceScene:[LevelRulesScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    
    //[[CCDirector sharedDirector] replaceScene:[Level3Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    
    //[[CCDirector sharedDirector] replaceScene:[ProgressBarScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    

}

- (void)onGetButtonPressed:(id)sender {
    DEF_CLICK_SND;
    
//    [[CCDirector sharedDirector] replaceScene:[TestScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    
}

- (void)onRankButtonPressed:(id)sender {
    DEF_CLICK_SND;
}


#pragma mark - Sounds

- (void)defaultClickSound {
    [[OALSimpleAudio sharedInstance] playEffect:@"default_click.mp3"];
}

- (void)setTimerLabel {
    
    _labelSprite = [CCSprite spriteWithImageNamed:@"default-white.png"];
    [_labelSprite setColor:[CCColor colorWithWhite:0.5 alpha:0.5]];
    _labelSprite.position  = ccp(WIDTH*0.5,HEIGHT*0.5);
    [self addChild:_labelSprite];
    
    if (IS_IPHONE) _labelSprite.scale = 0.5;
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"1234" fontName:@"Minnie.TTF" fontSize:100.0f];
    label.positionType = CCPositionTypeNormalized;
  
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [_labelSprite addChild:label z:1000];
    
    _labelSprite.rotation = 30;
}

- (void)setBitmapFont
{
    CCLabelBMFont *myLabel = [CCLabelBMFont labelWithString:@"hello world" fntFile:@"Continuum_Bold_652px.fnt"];


    myLabel.positionType = CCPositionTypeNormalized;
    //myLabel.color = [CCColor greenColor];
    myLabel.position = ccp(0.5f, 0.9f); // Middle of screen
 
    [myLabel setString:@"12344"];
    
    [self addChild:myLabel];
}


@end
