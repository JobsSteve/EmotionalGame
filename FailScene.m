//
//  FailScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 14.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "FailScene.h"
#import "CCScene+Extension.h"

#import "ChooseLevelScene.h"

#import "CCLabelTTF+Extension.h"

@implementation FailScene

+ (FailScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
 
    [self setBackButton];
    
    
    return self;
}

- (void)onBackButtonPressed:(id)sender {
    DEF_CLICK_SND;

    [[CCDirector sharedDirector] replaceScene:[ChooseLevelScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)pointsLabel
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"" fontName:@"Minnie.TTF" fontSize:70];
    label.position = ccp(WIDTH/2, HEIGHT*0.6);
    [self addChild:label z:1000];
    
    [label setString:[NSString stringWithFormat:@"% ldpts ",(long)_pointsNumber]];
    
    [self setLooseBackground];
    
//    if (_pointsNumber > 20) {
//        [self setWinBackground];
//    } else {
//        [self setLooseBackground];
//    }
}

- (void)setWinBackground
{
     NORMAL_LEVEL_SND;
    
    CCSprite *bkg = [CCSprite spriteWithImageNamed:@"orange-background.jpg"];
    bkg.position = ccp(WIDTH/2,HEIGHT/2);
    [self addChild:bkg z:0];
    
    if (IS_IPHONE) bkg.scale = 0.6;
    
}

- (void)setLooseBackground
{
    FAIL_LEVEL_SND;
    
    CCSprite *bkg = [CCSprite spriteWithImageNamed:@"fail_bkg.png"];
    bkg.position = ccp(WIDTH/2,HEIGHT/2);
    [self addChild:bkg];
    
    if (IS_IPHONE) bkg.scale = 0.4;
    
}

- (void)setPointsLabelWithString:(NSString *)string
{
    //CCLabelTTF *label =
    [CCLabelTTF createLabelWithColor:[CCColor whiteColor] andPositionType:NO andString:string andOpacity:1.0 andFontName:@"Minnie.TTF" andFontSize:20 andPosition:ccp(WIDTH*0.5,HEIGHT*0.6) andNode:self andZ:0 ];
    
    
}

@end
