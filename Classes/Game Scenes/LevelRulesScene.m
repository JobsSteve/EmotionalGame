//
//  LevelRulesScene.m
//  ThreeButtonProject
//
//  Created by artoorix on 14.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "LevelRulesScene.h"

#import "Level1Scene.h"
#import "Level2Scene.h"
#import "Level3Scene.h"

#import "LevelNameScene.h"

#import "CCScene+Extension.h"

#import "CCButton+Extension.h"
#import "CCSprite+Extension.h"
#import "CCLabelTTF+Extension.h"

#import "Extensions.h"

@interface LevelRulesScene ()

@property (nonatomic, strong)NSString *levelRules;

@end

@implementation LevelRulesScene

+(LevelRulesScene *)scene
{
    return [[self alloc] init];
}

-(id)init
{
    self = [super init];
    if (!self) return(nil);
    
    [CCSprite createSpriteWithImage:@"LevelRulesBkg.png" andPositionType:NO andPosition:ccp(WIDTH*0.5,HEIGHT*0.5) andNode:self andZ:0];

    [self setPlayButton];
    [self setLevelIcon:@"level1-icon.png"];
    
    [self setInstruction];
    
    return self;
}


#pragma mark - Play Button
- (void)setPlayButton {
    CCButton *button = [CCButton createButtonWithImage:@"play-ontop.png" andPosition:ccp(WIDTH*0.5,HEIGHT*0.95) andNode:self andZ:0];
    [button setTarget:self selector:@selector(playButtonPressed:)];
}

- (void)playButtonPressed:(id)sender
{
    NSString *gameScene = [[NSUserDefaults standardUserDefaults] objectForKey:@"GameScene"];
    
    if ( [gameScene rangeOfString:@"1"].location != NSNotFound ) {
         [[CCDirector sharedDirector] replaceScene:[Level1Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
    else if ( [gameScene rangeOfString:@"2"].location != NSNotFound ) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
    else if ( [gameScene rangeOfString:@"3"].location != NSNotFound ) {
        [[CCDirector sharedDirector] replaceScene:[Level3Scene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
}

//Based on Rock Paper Scissors rules, choose Left Wins or Right Wins or Draw as fast as you can!

#pragma mark - Instrustions
- (void)setLevelIcon:(NSString *)levelIcon {
    
    [CCSprite createSpriteWithImage:@"instructions.png" andPositionType:NO andPosition:ccp(WIDTH*0.5, HEIGHT*0.5) andNode:self andZ:100];
    
    [CCSprite createSpriteWithImage:@"level-ramka.png" andPositionType:NO andPosition:ccp(WIDTH*0.5+90, HEIGHT*0.5+120) andNode:self andZ:201];
    
    [CCSprite createSpriteWithImage:levelIcon andPositionType:NO andPosition:ccp(WIDTH*0.5+90, HEIGHT*0.5+120) andNode:self andZ:200];
}

- (void)setInstruction {
    
    NSString *gameScene = [[NSUserDefaults standardUserDefaults] objectForKey:@"GameScene"];
    
    if ( [gameScene rangeOfString:@"1"].location != NSNotFound ) {
    
        [self setInstructionWithText:@"Based on \"Rock Scissors Paper\" rules, choose Left Win or Right Win or Draw as fast as you can!"];
        [self setLevelStage:@"Level 1"];
    }
    else if ( [gameScene rangeOfString:@"2"].location != NSNotFound ) {
        [self setInstructionWithText:@"Solve the simple Math questions as fast as you can!"];
        [self setLevelStage:@"Level 2"];
    }
    else if ( [gameScene rangeOfString:@"3"].location != NSNotFound ) {
        [self setInstructionWithText:@"Choose the right"];
        [self setLevelStage:@"Level 3"];
    }
}

- (void)setLevelStage:(NSString *)stageNum
{
    CCLabelTTF *levelStage = [CCLabelTTF createLabelWithColor:[CCColor blueColor] andPositionType:NO  andString:@"" andOpacity:0.5f  andFontName:@"Minnie.TTF" andFontSize:30.0f andPosition:ccp(WIDTH*0.5-65,HEIGHT*0.5+85) andNode:self andZ:1010  ];
    
    [levelStage setString:stageNum];
    
}

- (void)setInstructionWithText:(NSString *)instruction {
    CCLabelTTF *instructionText = [CCLabelTTF labelWithString:instruction fontName:@"Minnie.TTF" fontSize:20 dimensions:CGSizeMake(270, 200)];
    instructionText.position = ccp(WIDTH*0.5, HEIGHT*0.375);
    instructionText.anchorPoint = ccp(0.5,0.5);
    [self addChild:instructionText z:1000];
    
    instructionText.color = [CCColor blackColor];
    instructionText.opacity = 0.7;
}

//Solve the simple Math questions as fast as you can!




@end
