//
//  PackScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 06.03.14.
//  Copyright 2014 Артур. All rights reserved.
//

#import "PackScene.h"

#import "IntroScene.h"
#import "ChooseLevelScene.h"
#import "Sounds.h"

#import "CCScene+Extension.h"


@implementation PackScene
{
    CCSprite *_background;
}

+ (PackScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    // Add a background sprite
    _background = [CCSprite spriteWithImageNamed:@"green-background.jpg"];
    _background.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_background];
    
    if (IS_IPHONE) _background.scale = 0.5;
    
    [self setBackButton];
    
    [self setPackLabel];
    
    [self setPackButtons];
    
    return self;
}


//- (void)setBackButton
//{
//    CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button-back.png"]];
//    [button setPositionType:CCPositionTypeNormalized];
//    [button setPosition:ccp(0.08, 0.95)];
//    [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
//    [button setTarget:self selector:@selector(onBackButtonPressed:)];
//    
//    [self addChild:button z:100];
//    
//    if (IS_IPHONE) button.scale = 0.6;
//}

- (void)setPackLabel
{
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"PACK" fontName:@"Minnie.TTF" fontSize:56.0f];
    label.positionType = CCPositionTypeNormalized;
    //label.color = [CCColor greenColor];
    label.position = ccp(0.5f, 0.925f); // Middle of screen
    [self addChild:label];
    
    
    if (IS_IPHONE) label.scale = 0.8;
    
    
//    CCLabelBMFont *label = [CCLabelBMFont labelWithString:@"PACK" fntFile:@"Brady_Bunch_185px.fnt" width:100.0f alignment:CCTextAlignmentCenter];  
//    [label setColor:[CCColor yellowColor]];
//    [label setPositionType:CCPositionTypeNormalized];
//    [label setPosition: ccp(0.5, 0.5)];
//    [self addChild:label z:101];
    
}


- (void)setPackButtons
{
    //ORIGINAL
    CCButton *button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pack-original.png"]];
    [button setPositionType:CCPositionTypeNormalized];
    [button setPosition:ccp(0.5, 0.7)];
    
    [button setBackgroundOpacity:1.0 forState:CCControlStateNormal];
    [button setTarget:self selector:@selector(onOriginalButtonPressed:)];
    
    [self addChild:button];
    if (IS_IPHONE) button.scale = 0.75;
    
    //EXTREME
    button = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pack-extreme.png"]];
    [button setPositionType:CCPositionTypeNormalized];
    [button setPosition:ccp(0.5, 0.3)];
    
    [button setBackgroundOpacity:0.5 forState:CCControlStateNormal];
    [button setTarget:self selector:@selector(onExtremeButtonPressed:)];
    
    [self addChild:button];
    if (IS_IPHONE) button.scale = 0.75;
}

#pragma mark Button Callbacks

- (void)onBackButtonPressed:(id)sender {
    DEF_CLICK_SND;
    
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)onOriginalButtonPressed:(id)sender {
    DEF_CLICK_SND;
    
    [[CCDirector sharedDirector] replaceScene:[ChooseLevelScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)onExtremeButtonPressed:(id)sender {
    DEF_CLICK_SND;
}




@end
