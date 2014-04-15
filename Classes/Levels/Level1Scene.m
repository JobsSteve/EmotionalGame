//
//  Level1Scene.m
//  ThreeButtonProject
//
//  Created by artoorix on 11.03.14.
//  Copyright 2014 Артур. All rights reserved.
//

#define WELL     @"well-hand.png"
#define SCISSOR  @"scissor-hand.png"
#define PAPER    @"paper-hand.png"

#import "Level1Scene.h"

#import "CCScene+Extension.h"
#import "Extensions.h"
#import "Sounds.h"

#import "FailScene.h"


@interface Level1Scene ()

 //NSArray *_handTypes; //Array of Hand Types
@property (nonatomic, strong) NSMutableArray *handTypes;

@property (nonatomic, assign) BOOL timeBOOL;
@property (nonatomic, assign) BOOL buttonBOOL;

@property (nonatomic, strong) NSString *whoWin;

@property (nonatomic, assign) NSInteger roundCount;
@property (nonatomic, assign) NSInteger pointsCount;

@property (nonatomic, strong) CCLabelTTF *milisecLabel;

@property (nonatomic, strong) CCSprite *desk;
@property (nonatomic, strong) CCSprite *BOARD; //BOARD = desk + milisecLabel

//CCSprite *desk


@end

static NSNumber *factor;

@implementation Level1Scene
{
    CCLabelTTF *_timerLabel;  //Timer Display
    CCLabelTTF *_coefLabel;   //Coefficient Display
    
    NSArray *_periodArray;        //1.8 .. 1.6 .. 14..
    NSArray *_accelerationArray;  // 0.23 .. 0.216 .. 0.2
    
    float _timeCount;
    float _milisecCount; //Start count milisec after choosen type

    int _arrayIndex; //Index for Array
    
}

+ (Level1Scene *)scene {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
 
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithWhite:0.7 alpha:0.9]];
    [self addChild:background];
    
    [self setBackgroundWithStripes];
    [self setBackButton];

    [self setPauseButton];
    [self setRestartButton];

    
    //- (void)setThreeButtonsWithThreeStrings:(NSArray *)threeStrings
    NSArray *threeStrings = @[@"Red Wins", @"Draw", @"Blue Wins"];
    [self setThreeButtonsWithThreeStrings:threeStrings];
    
    [self setMilisecLabel];
    
    
    _periodArray       = @[@2.0,  @1.6,   @1.5,   @1.3,   @1.1,   @1.0,   @0.9,  @0.8,   @0.7,    @0.6,
                           @0.5,  @0.45,  @0.4,   @0.35,  @0.3,   @0.25,  @0.2,  @0.19,  @0.18,   @0.17, @0.16,  @0.0, @0.0, @0.0];
    
    _accelerationArray = @[@0.25, @0.23,  @0.216, @0.2,   @0.18,  @0.166, @0.15, @0.133, @0.1166, @0.1,
                           @0.07, @0.06,  @0.05,  @0.047, @0.045, @0.043, @0.04, @0.04,  @0.04,   @0.04, @0.040, @0.0, @0.0, @0.0];
    
    //INITIALIZATION:
    _timeCount = 0;
    _milisecCount = 0;
    
    _roundCount = 0;  //ROUND COUNT
    _pointsCount = 0; //POINTS COUNT
    
    self.timeBOOL = YES;
    self.buttonBOOL = NO;
    
    _handTypes = [NSMutableArray array];
    
    //[self setReadyGo];
    [self performSelector:@selector(setReadyGo) withObject:nil afterDelay:1.5];
    
    [self performSelector:@selector(setTimer) withObject:nil afterDelay:3.5]; //after ReadyGo

    
    return self;
}

- (void)setTimer
{
    //TIMER
    if (_timerLabel == nil) {
        _timerLabel = [CCLabelTTF labelWithString:@"00:00" fontName:@"Helvetica" fontSize:50];
        _timerLabel.position = ccp(WIDTH*0.5, HEIGHT*0.7);
    }
    
    //COEFFICIENTS
    if (_coefLabel == nil) {
        _coefLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:40];
        _coefLabel.position = ccp(WIDTH*0.5, HEIGHT*0.9);
    }
 
    //static NSNumber *factor;
    if (factor == nil) {
        factor = @0;
    }
    
    factor = @([factor intValue] + 1);
    
    //GAMEUPDATE -> DISPLAY TYPE
    _timeCount = 0;
    [self schedule:@selector(gameUpdate:) interval:0.01]; //Обнуление перед началом.

    [self setHandsIndex:(NSNumber *)factor];
}



#pragma mark GAMEUPDATE -> Display Type
- (void)gameUpdate:(CCTime)delta
{
    _timeCount = _timeCount + delta;
    
    [_timerLabel setString:[NSString stringWithFormat:@"%f",_timeCount]];
    //_timeCount = _timeCount * 1000;
    
    NSNumber *coefNum = [_periodArray objectAtIndex:_arrayIndex];
    float coef = [coefNum floatValue];
    
    [_coefLabel setString:[NSString stringWithFormat:@"%f", coef]];
    
    if (_timeCount > coef && _timeBOOL == YES)
    {
        self.timeBOOL = NO;
        [self unschedule:@selector(gameUpdate:)];
        [self finishAndDisplayType];
    }
}


#pragma mark - DISPLAY TYPE
- (void)finishAndDisplayType {
     NSArray *hands = [NSArray arrayWithObjects:SCISSOR, WELL, PAPER, nil];
    
    [self displayLeftHandFrom:hands];
    [self displayRightHandFrom:hands];
    
    self.timeBOOL = YES;
    self.buttonBOOL = YES;
    
    _milisecLabel.scale = 1.0;
    _milisecCount = 0;
    
   
    [self schedule:@selector(milisecUpdate:) interval:0.01f];
    
    NSInteger num = _roundCount;
    self.roundCount = num + 1;
}

- (void)displayLeftHandFrom:(NSArray *)hands
{
    CCSprite *leftHand = (CCSprite *)[self getChildByName:@"LeftHand" recursively:NO];
    [leftHand stopAllActions];
    [self removeChildByName:@"LeftHand"];
    
    NSInteger index = arc4random() % 3; //rand: 0,1,2
    NSString *randomHand = [hands objectAtIndex:index]; //hands
    
    self.handTypes[0] = randomHand; //FIRST HandType
    leftHand = [CCSprite spriteWithImageNamed:randomHand];
    leftHand.position = ccp(0 - leftHand.CONTENTWIDTH*0.4, HEIGHT*0.5); //IS_IPAD
    leftHand.rotation = 0.0f;
    leftHand.anchorPoint = ccp(0.1,0.5);
    [self addChild:leftHand z:101 name:@"LeftHand"];
    
    if (IS_IPHONE) {
        leftHand.position = ccp(0 - leftHand.CONTENTWIDTH*0.22, HEIGHT*0.5);
        leftHand.scale = 0.5;
    }
}

- (void)displayRightHandFrom:(NSArray *)hands
{
    CCSprite *rightHand = (CCSprite *)[self getChildByName:@"RightHand" recursively:NO];
    [rightHand stopAllActions];
    [self removeChildByName:@"RightHand"];
    
    NSInteger index = arc4random() % 3; //rand: 0,1,2
    NSString *randomHand = [hands objectAtIndex:index]; //hands
    
    self.handTypes[1] = randomHand; //SECOND HandType
    rightHand = [CCSprite spriteWithImageNamed:randomHand];
    rightHand.position = ccp(WIDTH+rightHand.CONTENTWIDTH*0.4, HEIGHT*0.5);
    rightHand.rotation = 0.0f;
    rightHand.flipX = YES;
    rightHand.anchorPoint = ccp(0.9,0.5);
    [self addChild:rightHand z:102 name:@"RightHand"];
    
    if (IS_IPHONE) { //////////////////////////////////////////
        rightHand.position = ccp(WIDTH+rightHand.CONTENTWIDTH*0.22, HEIGHT*0.5);
        rightHand.scale = 0.5;
    }
}


#pragma mark - ACCELERATION

- (void)setHandsIndex:(NSNumber *)factor
{
    [self removeChildByName:@"LeftHand"];
    [self removeChildByName:@"RightHand"];
    
    int factorInt = [factor intValue];
    _arrayIndex = factorInt;
    
    NSNumber *accelNum = [_accelerationArray objectAtIndex:factorInt];
    float ACCELERATION = [accelNum floatValue];
    
    [self startLeftHandWithAcceleration:(float)ACCELERATION];
    [self startRightHandWithAcceleration:(float)ACCELERATION];
}

- (void)startLeftHandWithAcceleration:(float)ACCELERATION
{
    //LEFT HAND
    CCSprite *leftHand = [CCSprite spriteWithImageNamed:@"well-hand.png"];
    leftHand.position = ccp(0 - leftHand.CONTENTWIDTH*0.4, HEIGHT*0.5);
    leftHand.rotation = 35;
    leftHand.anchorPoint = ccp(0.1,0.5);
    
    [self addChild:leftHand z:101 name:@"LeftHand"];

    CCActionRotateBy *rotateDown1 = [CCActionRotateBy actionWithDuration:ACCELERATION angle:-70]; //0.05 - period
    CCActionRotateBy *rotateUp1 = [CCActionRotateBy actionWithDuration:ACCELERATION angle:+70];
    CCActionSequence *rotationSequence1 = [CCActionSequence actions:rotateDown1, rotateUp1, nil];
    CCAction *action1 = [CCActionRepeatForever actionWithAction:rotationSequence1];
    [leftHand runAction: action1];
    
    
    if (IS_IPHONE) { /////////////////////////
        leftHand.position = ccp(0 - leftHand.CONTENTWIDTH*0.22, HEIGHT*0.5);
        leftHand.scale = 0.5;
    }
}

- (void)startRightHandWithAcceleration:(float)ACCELERATION
{
    //RIGHT HAND
    CCSprite *rightHand = [CCSprite spriteWithImageNamed:@"well-hand.png"];
    rightHand.position = ccp(WIDTH+rightHand.CONTENTWIDTH*0.4, HEIGHT*0.5);
    rightHand.rotation = -35;
    rightHand.anchorPoint = ccp(0.9,0.5);
    rightHand.flipX = YES;
    
    [self addChild:rightHand z:102 name:@"RightHand"];
    
    CCActionRotateBy *rotateDown1 = [CCActionRotateBy actionWithDuration:ACCELERATION angle:+70]; //0.05 - period
    CCActionRotateBy *rotateUp1 = [CCActionRotateBy actionWithDuration:ACCELERATION angle:-70];
    CCActionSequence *rotationSequence1 = [CCActionSequence actions:rotateDown1, rotateUp1, nil];
    CCAction *action1 = [CCActionRepeatForever actionWithAction:rotationSequence1];
    [rightHand runAction: action1];
    
    if (IS_IPHONE) {
        rightHand.position = ccp(WIDTH+rightHand.CONTENTWIDTH*0.22, HEIGHT*0.5);
        
        rightHand.scale = 0.5;
    }
}

#pragma mark - ANIMATE Hands Win
//MOVE Left Hand
- (void)animateLeftHandWith:(float)moveX andAccelerate:(float)accelX
{
    [self removeChildByName:@"LeftHand"];

    NSString *type = _handTypes[0];
    CCSprite *leftHand = [CCSprite spriteWithImageNamed:type];
    leftHand.position = ccp(0 - leftHand.CONTENTWIDTH*0.4, HEIGHT*0.5);
    if (IS_IPHONE) {
        leftHand.position = ccp(0 - leftHand.CONTENTWIDTH*0.22, HEIGHT*0.5);
    }
    leftHand.rotation = 0;
    leftHand.anchorPoint = ccp(0.1,0.5);
    
  
    leftHand.scale = 1.025;
    
    [self addChild:leftHand z:101 name:@"LeftHand"];

    if (IS_IPHONE) {
        CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:accelX position:ccp(0 - leftHand.CONTENTWIDTH*0.22+moveX/2.0, HEIGHT*0.5)];
        [leftHand runAction: move];
        
         leftHand.scale = 0.5;
        
    } else {
        CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:accelX position:ccp(0 - leftHand.CONTENTWIDTH*0.4+moveX*1.2, HEIGHT*0.5)];
        [leftHand runAction: move];
    }
    
   
}

//MOVE Right Hand
- (void)animateRightHandWith:(float)moveX andAccelerate:(float)accelX
{
    [self removeChildByName:@"RightHand"];
    
    NSString *type = _handTypes[1];
    CCSprite *rightHand = [CCSprite spriteWithImageNamed:type];
    rightHand.position =  ccp(WIDTH + rightHand.CONTENTWIDTH*0.4, HEIGHT*0.5);
    if(IS_IPHONE) {
       rightHand.position =  ccp(WIDTH + rightHand.CONTENTWIDTH*0.22, HEIGHT*0.5);
    }

    rightHand.rotation = 0;
    rightHand.flipX = YES;
    rightHand.anchorPoint = ccp(0.9,0.5);
    
    rightHand.scale = 1.05;
    [self addChild:rightHand z:102 name:@"RightHand"];
    
    if (IS_IPHONE) {
        CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:accelX position:ccp(WIDTH + rightHand.CONTENTWIDTH*0.22-moveX/2.0, HEIGHT*0.5)];
        [rightHand runAction: move];
    } else {
        CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:accelX position:ccp(WIDTH + rightHand.CONTENTWIDTH*0.4-moveX*1.2, HEIGHT*0.5)];
        [rightHand runAction: move];
    }
    
    if (IS_IPHONE) {
        rightHand.scale = 0.5;
    }
}

- (void)animateDraw
{
    [self animateLeftHandWith:80 andAccelerate:0.05];
    [self animateRightHandWith:80 andAccelerate:0.05];
}

- (void)checkWhoWin
{
    if (([_handTypes[0] isEqualToString:SCISSOR] && [_handTypes[1] isEqualToString:PAPER])  ||
        ([_handTypes[0] isEqualToString:PAPER]   && [_handTypes[1] isEqualToString:WELL])   ||
        ([_handTypes[0] isEqualToString:WELL]    && [_handTypes[1] isEqualToString:SCISSOR]))
    {
        self.whoWin = @"Red";
        [self animateLeftHandWith:175 andAccelerate:0.03];
        [self animateRightHandWith:-80 andAccelerate:0.05];
    }
    else if ([_handTypes[0] isEqualToString:_handTypes[1]]) {
        self.whoWin = @"Draw";
        [self animateDraw];
    }
    else {
        self.whoWin = @"Blue";
        
        [self animateRightHandWith:175 andAccelerate:0.03];
        [self animateLeftHandWith:-80 andAccelerate:0.05];
    }
}



#pragma mark - GAMEPLAY BUTTONS
- (void)onGameplayButtonPressed:(CCButton *)sender
{
    if (_buttonBOOL == YES) {
    //_desk.position = ccp(WIDTH*0.05,HEIGHT*0.82); //for 3-digit
    [self unschedule:@selector(milisecUpdate:)];
   
    [self animateMilisec];
        
        [self checkWhoWin];
        
        DEF_CLICK_SND;
        if (sender.zOrder == 1001) {
            if ([_whoWin isEqualToString:@"Red"]) {
                [self roundFast];
            } else {
                [self roundWrong];
            }
    
            [self performSelector:@selector(setTimer) withObject:nil afterDelay:0.7];
            _buttonBOOL = NO;
        }
        else if (sender.zOrder == 1002) {
            if ([_whoWin isEqualToString:@"Draw"]) {
                [self roundFast];
            } else {
                [self roundWrong];
            }
        
            [self performSelector:@selector(setTimer) withObject:nil afterDelay:0.7];
            _buttonBOOL = NO;
        }
        else if (sender.zOrder == 1003) {
            if ([_whoWin isEqualToString:@"Blue"]) {
                [self roundFast];
            } else {
                [self roundWrong];
            }
            
            [self performSelector:@selector(setTimer) withObject:nil afterDelay:0.7];
            _buttonBOOL = NO;
        }
    }

}
- (void)stopGame
{
    //_desk.position = ccp(WIDTH*0.05,HEIGHT*0.82); //for 3-digit
    _desk.position = ccp(_BOARD.CONTENTWIDTH*0.475, _BOARD.CONTENTHEIGHT*0.5); //for 3-digit
    [self unschedule:@selector(milisecUpdate:)];
    [self unschedule:@selector(gameUpdate:)];
    //[[CCDirector sharedDirector] pause];

}


- (void)transitionToFailSceneWithPoints:(NSInteger)points
{
    //FAILSCENE
    FailScene *failScene = [FailScene scene];
    failScene.pointsNumber = _pointsCount;
    //failScene setPointsNumber:<#(NSInteger)#>
    [failScene pointsLabel];
    [[CCDirector sharedDirector] replaceScene:failScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)roundWrong
{
    WRONG_SND;
    
    CCSprite *wrong = [CCSprite spriteWithImageNamed:@"wrong.png"];
    wrong.position = ccp(WIDTH*0.5, HEIGHT*0.3);
    [self addChild:wrong z:2203];
    
    CCLabelTTF *countLabel = [CCLabelTTF labelWithString:@"000" fontName:@"Minnie.TTF" fontSize:140 dimensions:CGSizeMake(480, 160)];
    countLabel.position = ccp(wrong.contentSize.width + 145, wrong.contentSize.height*0.5); // Middle of Screen
    [wrong addChild:countLabel];
   
    
    NSInteger points;
    points = _pointsCount -3;
    if (points < 0) {
        points = 0;
    }
    self.pointsCount = points;
    
    [countLabel setString:@"-3"];
 
    [self performSelector:@selector(removeSprite:) withObject:wrong afterDelay:0.5];
    
   
    
    if (IS_IPHONE) { countLabel.scale = 0.7; wrong.scale = 0.4; }
    
    if (_roundCount >= 20) {
        _roundCount = 0;
        [self performSelector:@selector(stopGame) withObject:nil afterDelay:0.5];
    }
    
   
}

- (void)roundFast
{
    RIGHT_SND;
    
    CCSprite *fast = [CCSprite spriteWithImageNamed:@"fast.png"];
    fast.position = ccp(WIDTH*0.5, HEIGHT*0.3);
    [self addChild:fast z:2202];
    
    CCLabelTTF *countLabel = [CCLabelTTF labelWithString:@"000" fontName:@"Minnie.TTF" fontSize:140.0f dimensions:CGSizeMake(480, 160)];
    countLabel.position = ccp(fast.contentSize.width + 145, fast.contentSize.height*0.5); // Middle of Screen
    //countLabel.anchorPoint = ccp(0.1, 0.5);countLabel.anchorPoint = ccp(0.1, 0.5);
    [fast addChild:countLabel];
    NSString *str = [_milisecLabel string];
    NSInteger count = [str integerValue];
    
    NSInteger points;
    if (count > 0 && count < 350) {
        [countLabel setString:@"+6"];
        points = _pointsCount +6;
        self.pointsCount = points;
        
    } else if (count > 350 && count < 550) {
        [countLabel setString:@"+4"];
        points = _pointsCount +4;
        self.pointsCount = points;
        
    } else if (count > 550 && count < 750 ) {
        [countLabel setString:@"+3"];
        points = _pointsCount +3;
        self.pointsCount = points;
        
    } else {
        [countLabel setString:@"+1"];
        
        points = _pointsCount +1;
        self.pointsCount = points;
    }
    [self performSelector:@selector(removeSprite:) withObject:fast afterDelay:0.5];
    
    
    if (IS_IPHONE) { countLabel.scale = 0.7; fast.scale = 0.4; }
    
    if (_roundCount >= 20) {
        _roundCount = 0;
        [self performSelector:@selector(stopGame) withObject:nil afterDelay:0.5];
    }
}

- (void)removeSprite:(CCSprite *)sprite {
    [sprite removeFromParent];
}

#pragma mark - MILISEC
- (void)setMilisecLabel {
    
    self.BOARD = [CCSprite spriteWithImageNamed:@"desk-480x81.png"];
    _BOARD.position = ccp(WIDTH*-0.1, HEIGHT*0.85);
    _BOARD.color = [CCColor whiteColor];
    _BOARD.opacity = 0.5;
    [self addChild:_BOARD z:3000];
    
    self.desk = [CCSprite spriteWithImageNamed:@"desk.png"]; //DESK
    //desk.position = ccp(WIDTH*0.2,HEIGHT*0.78); //for 4-digit
    //_desk.position = ccp(WIDTH*0.05,HEIGHT*0.82); //for 3-digit
    _desk.position = ccp(_BOARD.CONTENTWIDTH*0.475, _BOARD.CONTENTHEIGHT*0.5);
    [_BOARD addChild:_desk z: 301];
    
     if (IS_IPHONE) _desk.scale = 0.55;

    
   // _milisecLabel = [CCLabelTTF labelWithString:@"000" fontName:@"Minnie.TTF" fontSize:50.0f];
    _milisecLabel = [CCLabelTTF labelWithString:@"000" fontName:@"Minnie.TTF" fontSize:60.0f dimensions:CGSizeMake(480,100)];
    
    
    _milisecLabel.anchorPoint = ccp(0.1, 0.5);
    //_milisecLabel.position = ccp(WIDTH*0.12, HEIGHT*0.75); // Middle of screen
    _milisecLabel.position = ccp(_BOARD.CONTENTWIDTH*0.575, _BOARD.CONTENTHEIGHT*0.25);
    [_BOARD addChild:_milisecLabel z: 2101];
    
    //_milisecLabel.scale = 1.2;
    //if (IS_IPHONE) _milisecLabel.scale = 0.6;
    
    //_milisecLabel.rotation = 20;
    //_desk.rotation = 20;
    
    _BOARD.anchorPoint = ccp(0.4, 0.5);
    _BOARD.rotation = -90;
    
    CCActionRotateTo *rotate = [CCActionRotateTo actionWithDuration:0.5 angle:35];
    CCActionRotateTo *rotateBack = [CCActionRotateTo actionWithDuration:0.1 angle:20];
    [_BOARD runAction:[CCActionSequence actions:rotate,rotateBack, nil]];
    
}

- (void)milisecUpdate:(CCTime)delta
{
    _milisecCount = _milisecCount + delta;
    NSInteger milisec = _milisecCount*1000;
    
    [_milisecLabel setString:[NSString stringWithFormat:@"%ld",(long)milisec]];
    
    //[self.milisecLabel setString:@"1234"];
    
    if(milisec >= 999) {
        //_desk.position = ccp(WIDTH*0.2,HEIGHT*0.78); //for 4-digit
        _desk.position = ccp(_BOARD.CONTENTWIDTH*0.575, _BOARD.CONTENTHEIGHT*0.5); //for 4-digit
    }
    
    if (milisec >= 10000) {
        [_milisecLabel setString:@"000"];
         //_desk.position = ccp(WIDTH*0.05,HEIGHT*0.82); //for 3-digit
        _desk.position = ccp(_BOARD.CONTENTWIDTH*0.475, _BOARD.CONTENTHEIGHT*0.5); //for 3-digit
        [self unschedule:@selector(milisecUpdate:)];
        
        //FAILSCENE
        FailScene *failScene = [FailScene scene];
        failScene.pointsNumber = _pointsCount;
        [failScene pointsLabel];
        [[CCDirector sharedDirector] replaceScene:failScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
    
}

#pragma mark - Animate Milisec
- (void)animateMilisec
{
    CCActionScaleTo *scale = [CCActionScaleTo actionWithDuration:0.1 scale:1.2];
    [_milisecLabel runAction:scale];
    
    [self performSelector:@selector(scaleBack) withObject:nil afterDelay:0.2];
}

- (void)scaleBack {
    CCActionScaleTo *scaleBack = [CCActionScaleTo actionWithDuration:0.01 scale:1.0];
    [_milisecLabel runAction:scaleBack];
    _milisecLabel.scale = 1.0;
    
    [self performSelector:@selector(setNulls) withObject:nil afterDelay:0.5];
}

- (void)setNulls {
    [_milisecLabel setString:@"000"];
     //_desk.position = ccp(WIDTH*0.05,HEIGHT*0.82); //for 3-digit
    _desk.position = ccp(_BOARD.CONTENTWIDTH*0.475, _BOARD.CONTENTHEIGHT*0.5); //for 3-digit
}



#pragma mark - READY GO
- (void)setReadyGo {
    
    READY_GO_SND;
    
    CCSprite *ready = [CCSprite spriteWithImageNamed:@"ready.png"];
    ready.position = ccp(WIDTH+ready.contentSize.width*0.5,HEIGHT*0.5);
    [self addChild:ready z:2101];
    
    if (IS_IPHONE) ready.scale = 0.5;
    
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:0.35 position:ccp(WIDTH/2,HEIGHT/2)];
    [ready runAction:move];
    
    [self performSelector:@selector(goWith:) withObject:ready afterDelay:1.3];
    
    
}

- (void)goWith:(CCSprite *)ready
{
    [ready removeFromParent];
    
    CCSprite *go = [CCSprite spriteWithImageNamed:@"go.png"];
    go.position = ccp(WIDTH/2,HEIGHT/2);
    [self addChild:go z:2102];
    
    if (IS_IPHONE) go.scale = 0.5;
    
    [self performSelector:@selector(animateGo:) withObject:go afterDelay:0.5];

}
- (void)animateGo:(CCSprite *)go
{
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:0.4 position:ccp(0-go.contentSize.width/2,HEIGHT/2)];
    [go runAction:move];
}


#pragma mark - DEALLOC
- (void)dealloc
{
    factor = nil;
}



@end
