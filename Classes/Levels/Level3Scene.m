//
//  Level3Scene.m
//  EmotionalGame
//
//  Created by artoorix on 24.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "Level3Scene.h"
#import "CCScene+Extension.h"
#import "CCAnimation.h"

#import "CCLabelTTF+Extension.h"
#import "CCSprite+Extension.h"

#import "FailScene.h"
#import "WinScene.h"

#define RAND_FROM_TO(min,max) (min + arc4random_uniform(max - min + 1))

#define FRAMES 5
#define DELAY 0.1

@interface Level3Scene ()

//@property (nonatomic, assign) NSInteger biggestNum;

@property (nonatomic, assign) NSInteger winIndex; // выиграл 0-красный,1-оранжевый,2-голубой

@property (nonatomic, assign) BOOL isBlocked; //BlockedButtons

@end

@implementation Level3Scene
{
    float _timeCount;
    
    CCSprite *_sprite;
    
    CCSprite *_cubic1;
    CCSprite *_cubic2;
    CCSprite *_cubic3;
}

+ (Level3Scene *)scene {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    //DEFAULT SETTINGS
    [self setDefaultBackground]; //Gray bg
    [self setBackgroundWithImage:@"dice-bkg.png"];
    [self setBackButton];
    [self setThreeButtons];
    [self setPauseButton];
    [self setRestartButton];
    
    
    [self setCubicPosition];
    [self setImagesOnThreeButtons];
    
    [self restartRound:nil]; //startRound
   
    
    _isBlocked = YES;
    
    return self;
}

#pragma mark - Initializations:
- (void)setImagesOnThreeButtons
{
    [CCSprite createSpriteWithImage:@"right-sign.png" andPositionType:NO andPosition:ccp(WIDTH*0.175,HEIGHT*0.11) andNode:self andZ:1000+1];
    [CCSprite createSpriteWithImage:@"right-sign.png" andPositionType:NO andPosition:ccp(WIDTH*0.5,HEIGHT*0.11) andNode:self andZ:1000+2];
    [CCSprite createSpriteWithImage:@"right-sign.png" andPositionType:NO andPosition:ccp(WIDTH*0.825,HEIGHT*0.11) andNode:self andZ:1000+3];
}

- (void)setCubicPosition
{
    _cubic1 = [CCSprite createSpriteWithImage:@"dice01.png" andPositionType:NO andPosition:ccp(WIDTH*0.15,HEIGHT*0.6) andNode:self andZ:0];
    _cubic2 = [CCSprite createSpriteWithImage:@"dice01.png" andPositionType:NO andPosition:ccp(WIDTH*0.5, HEIGHT*0.6) andNode:self andZ:0];
    _cubic3 = [CCSprite createSpriteWithImage:@"dice01.png" andPositionType:NO andPosition:ccp(WIDTH*0.85, HEIGHT*0.6) andNode:self andZ:0];
}

#pragma mark - Gaemplay Buttons (onButton Pressed)
- (void)onGameplayButtonPressed:(CCButton *)sender {
    
    if (_isBlocked == NO) {
        
        NSString *statusOfRound;
        if (sender.zOrder == 1001) {
            
            if (_winIndex == 0) {
                statusOfRound = @"Win";
            }
            else { statusOfRound = @"Fail";}
            
        }
        else if (sender.zOrder == 1002) {
            if (_winIndex == 1) {
                statusOfRound = @"Win";
            }
            else { statusOfRound = @"Fail";}
            
        }
        else if (sender.zOrder == 1003) {
            if (_winIndex == 2) {
                statusOfRound = @"Win";
            }
            else { statusOfRound = @"Fail";}
            
        }
        _isBlocked = YES;
        [self performSelector:@selector(showRoundStatus:) withObject:statusOfRound afterDelay:.1];
    }
    
}


- (void)showRoundStatus:(NSString *)status
{
    //CCLabelTTF *label = [CCLabelTTF createLabelWithColor:[CCColor blueColor] andString:status andOpacity:0.9 andFontName:@"Minnie.TTF" andFontSize:65 andPosition:ccp(WIDTH*0.5,HEIGHT*0.5) andNode:self andZ:200+1];
    
    CCLabelTTF *label2 = [CCLabelTTF createDoubleLabelWithFrontColor:[CCColor blueColor] andBackColor:[CCColor blackColor] andXOffset:-7 andYOffset:7 andString:status andOpacity:0.95 andFontName:@"Minnie.TTF" andFontSize:65 andPosition:ccp(WIDTH*0.5,HEIGHT*0.5) andNode:self andZ:200+2];

    [self performSelector:@selector(restartRound:) withObject:label2 afterDelay:1.5];
}

- (void)restartRound:(CCLabelTTF *)label
{
    static NSInteger roundCount = 0;
    roundCount = roundCount + 1;
    
    if (roundCount >= 4) { //>=21
        //Пересчет очков.
        //[self transitionToFailSceneWithPoints:10];
        [self transitionToWinSceneWithPoints:10];
    }
    
    if (label)
    [label removeFromParent];
    
    //Подсчет раундов
    
    //Запускатель кубиков
    [self animateCubic];
    [self schedule:@selector(gameUpdate:) interval:0.001f];
    
}


- (void)transitionToFailSceneWithPoints:(NSInteger)points
{
    //FAILSCENE
    FailScene *failScene = [FailScene scene];
    failScene.pointsNumber = points;
    //failScene setPointsNumber:(NSInteger)
    [failScene pointsLabel];
    [[CCDirector sharedDirector] replaceScene:failScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)transitionToWinSceneWithPoints:(NSInteger)points
{
    //FAILSCENE
    WinScene *winScene = [WinScene scene];
    winScene.pointsNumber = points;
    //winScene setPointsNumber:(NSInteger)
    [winScene pointsLabel];
    [[CCDirector sharedDirector] replaceScene:winScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}


#pragma mark - Animate Cubic
- (void)animateCubic
{
    if (_cubic1 || _cubic2 || _cubic3){
        [_cubic1 removeFromParent];  [_cubic2 removeFromParent]; [_cubic3 removeFromParent];
    }
    
    NSMutableArray *frames = [NSMutableArray array];

    for (int i = 1; i <= 5; i++) {
        CCSpriteFrame *frame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"dice0%d.png",i]];
        [frames addObject:frame];
    }
    
    [self setCubicPosition]; //Set Cubics on Screen
    
    float speed = 0.13;
    [self animateCubicSprite:_cubic1 withFrames:frames andDelay:(float)speed];
    [self animateCubicSprite:_cubic2 withFrames:frames andDelay:(float)speed];
    [self animateCubicSprite:_cubic3 withFrames:frames andDelay:(float)speed];
}

- (void)animateCubicSprite:(CCSprite *)sprite withFrames:(NSArray *)frames andDelay:(float)speed
{
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frames delay:speed];
    CCActionAnimate *animateAction = [CCActionAnimate actionWithAnimation:animation];
    
    CCActionRepeatForever *repeat = [CCActionRepeatForever actionWithAction:animateAction];
    [sprite runAction:repeat];
}


#pragma mark - Game Update: (Game Loop:)
- (void)gameUpdate:(CCTime)delta
{
    _timeCount = _timeCount + delta;
    
        if (_timeCount > 2) {
            [self unschedule:@selector(gameUpdate:)];
            
            [_cubic1 stopAllActions];   [_cubic2 stopAllActions];   [_cubic3 stopAllActions];
            [_cubic1 removeFromParent]; [_cubic2 removeFromParent]; [_cubic3 removeFromParent];
            
            NSMutableArray *diceImages = [@[] mutableCopy];
            NSMutableArray *diceNumbers = [@[] mutableCopy];
            BOOL isDone = NO;
            
            while (isDone == NO) {
                NSInteger diceToDisplay = arc4random() % 6 + 1;
                NSString *dice;
                switch (diceToDisplay) {
                    case 1:
                        dice = @"dice-01.png";
                        break;
                    case 2:
                        dice = @"dice-02.png";
                        break;
                    case 3:
                        dice = @"dice-03.png";
                        break;
                    case 4:
                        dice = @"dice-04.png";
                        break;
                    case 5:
                        dice = @"dice-05.png";
                        break;
                    case 6:
                        dice = @"dice-06.png";
                        break;
                    default:
                        break;
                }

                NSNumber *diceNum = [NSNumber numberWithInteger:diceToDisplay];
                
                if (diceImages.count == 3) {
                    isDone = YES;
                    break; //выход из for-цикла
                }
                
                if (diceImages.count == 0) {
                    [diceImages addObject:dice];
                    [diceNumbers addObject:diceNum];
                    continue; //выход из while-цикла
                }
                
                if (diceImages.count == 1) {
                    if ([dice isEqualToString:diceImages[0]]) {
                        continue;
                    } else {
                        [diceImages addObject:dice];
                        [diceNumbers addObject:diceNum];
                        continue;
                    }
                }
                
                if (diceImages.count == 2) {
                    if ([dice isEqualToString:diceImages[0]] || [dice isEqualToString:diceImages[1]]) {
                        continue;
                    } else {
                        [diceImages addObject:dice];
                        [diceNumbers addObject:diceNum];
                        break;
                    }
                }
            }
            //Установка ЗНАЧЕНИЙ:
            _cubic1 = [CCSprite createSpriteWithImage:diceImages[0] andPositionType:NO andPosition:ccp(WIDTH*0.15, HEIGHT*0.6) andNode:self andZ:0];
            _cubic1.scale = 0.55;
            _cubic2 = [CCSprite createSpriteWithImage:diceImages[1] andPositionType:NO andPosition:ccp(WIDTH*0.5, HEIGHT*0.6) andNode:self andZ:0];
            _cubic2.scale = 0.55;
            _cubic3 = [CCSprite createSpriteWithImage:diceImages[2] andPositionType:NO andPosition:ccp(WIDTH*0.85, HEIGHT*0.6) andNode:self andZ:0];
            _cubic3.scale = 0.55;
            
            _isBlocked = NO;
            _timeCount = 0;
        
            //Находим самый большой в default-массиве.
            NSInteger max = 0;
            NSInteger index = 0;
            for (NSInteger i=0; i<diceNumbers.count; i++) {
                //max = [diceNumbers[0] integerValue];
                if (max < [diceNumbers[i] integerValue]) {
                    max = [diceNumbers[i] integerValue];
                    index = i;
                }
            }
            self.winIndex = index; //0-1btn, 1-2btn, 2-3btn.
        }
}


#pragma mark - Double Label
//[self setDoubleLabelWithString:@"I love dice"];
- (void)setDoubleLabelWithString:(NSString *)str
{
    [CCLabelTTF createDoubleLabelWithFrontColor:[CCColor yellowColor] andBackColor:[CCColor blackColor] andXOffset:5 andYOffset:5 andString:str andOpacity:0.99 andFontName:@"Minnie.TTF" andFontSize:30 andPosition:ccp(WIDTH*0.5, HEIGHT*0.5) andNode:self andZ:700];
}


@end
