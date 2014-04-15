//
//  Level2Scene.m
//  EmotionalGame
//
//  Created by artoorix on 18.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "Level2Scene.h"
#import "CCScene+Extension.h"
#import "CCLabelTTF+Extension.h"

#import "FailScene.h"

@interface Level2Scene ()
{
    
}

@property (nonatomic, assign) NSInteger levelCount;
@property (nonatomic, assign) float milisecRound;
@property (nonatomic, assign) NSInteger rightCounts;

@property (nonatomic, strong) CCLabelTTF *mathLabel;
@property (nonatomic, strong) CCLabelTTF *equationLabel;

@property (nonatomic, strong) NSMutableArray *expression;
@property (nonatomic, strong) NSMutableArray *equation;
@property (nonatomic, strong) NSMutableArray *sorted;

@property (nonatomic, assign) NSInteger numberOfHide;


@property (nonatomic, strong) CCButton *buttonCombination;

@property (nonatomic, strong) CCLabelTTF *firstLabel;
@property (nonatomic, strong) CCLabelTTF *secondLabel;
@property (nonatomic, strong) CCLabelTTF *thirdLabel;

@property (nonatomic, strong) NSNumber *rightNumber;

//MILISEC LABEL
@property (nonatomic, strong) CCLabelTTF *milisecLabel;

@property (nonatomic, assign) BOOL canPressBOOL;

@end


@implementation Level2Scene
{
    float _milisecCount;
}

+ (Level2Scene *)scene {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
//    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithWhite:0.7 alpha:0.9]];
//    [self addChild:background];
    
    [self setBackgroundWithImage:@"math-bg.png"];
    
    [self setBackButton];
    [self setPauseButton];
    [self setRestartButton];
    
    
    [self setMathematicalLabel];
    [self setEquationLabel];
    
    [self setMilisecLabel];
    
   
   
    
    [self setThreeButtonsWithName:@"Gamebutton"];
    
    self.expression = [NSMutableArray arrayWithObjects:@0,@7,@2,@5, nil];
    
    self.equation = [NSMutableArray arrayWithObjects:@0,@7,@2,@5, nil];
 
    self.sorted = [NSMutableArray arrayWithObjects:@0,@0,@0, nil];
    

    //Начинаем с пересчета
    [self setMathematicalExpression];
    
    _milisecCount = 0;

    //Критерии проигрыша/выигрыша
    self.levelCount = 0;
    self.milisecRound = 0;
    
    self.canPressBOOL = YES;
    
    
    return self;
}


#pragma mark 

-(void)setMathematicalLabel
{
    self.mathLabel = [CCLabelTTF labelWithString:@" _ + _ = _ " fontName:@"Minnie.TTF"fontSize:40];
    _mathLabel.position = ccp(WIDTH*0.5, HEIGHT*0.4);
    
    [self addChild:_mathLabel z: 1110];
}

-(void)setEquationLabel {
    self.equationLabel = [CCLabelTTF createLabelWithString:@"_ + _ = _" andFontName:@"Minnie.TTF" andFontSize:40 andPosition:ccp(WIDTH*0.5, HEIGHT*0.5) andNode:self andZ:1111];
}

- (void)setMathematicalExpression
{
    [self schedule:@selector(milisecUpdate:) interval:0.01];
    
    NSInteger numberOfChange = arc4random() % 3 + 1; //rand: 1,2,3
    
    self.numberOfHide = arc4random() % 3 + 1;
    while (_numberOfHide == numberOfChange) {
        numberOfChange = arc4random() % 3 + 1;
    }
    
    NSInteger randNumer = arc4random() % 9 + 1;
    
    self.expression[numberOfChange] = [NSNumber numberWithInteger:randNumer];
    
    if (_numberOfHide == 3) {
        NSInteger first = [_expression[1] integerValue];
        NSInteger second = [_expression[2] integerValue];
        
        NSInteger third = first+second;
        NSNumber *thirdNumber = [NSNumber numberWithInteger:third];
        
        self.expression[3] = thirdNumber;
    }
    else if (_numberOfHide == 2) {
        NSInteger first = [_expression[1] integerValue];
        NSInteger third = [_expression[3] integerValue];
        
        NSInteger second = third - first;
        NSNumber *secondNumber = [NSNumber numberWithInteger:second];
        self.expression[2] = secondNumber;
    }
    else if (_numberOfHide == 1) {
        NSInteger second = [_expression[2] integerValue];
        NSInteger third = [_expression[3] integerValue];
        
        NSInteger first = third - second;
        NSNumber *firstNumber = [NSNumber numberWithInteger:first];
        self.expression[1] = firstNumber;
    }
    
    
    self.equation[0] = @0;
    self.equation[1] = _expression[1];
    self.equation[2] = _expression[2];
    self.equation[3] = _expression[3];
    self.equation[_numberOfHide] = @"_";
    
    
    NSInteger addition1 =rand()%5-2;
    while (addition1 == 0) {
        addition1 = rand()%5-2;
    }
    
    
    
    NSInteger addition2 =rand()%5-2;
    while (addition2 == 0 || addition2 == addition1) {
        addition2 = rand()%5-2;
    }
    
    
    NSNumber *firstNumber = _expression[_numberOfHide];
    self.rightNumber = firstNumber;
    
    NSInteger secondInteger = ([firstNumber integerValue] + addition1);
    NSNumber *secondNumber = [NSNumber numberWithInteger:secondInteger];

    NSInteger thirdInteger = ([firstNumber integerValue] + addition2);
    NSNumber *thirdNumber = [NSNumber numberWithInteger:thirdInteger];
    
    
    [_mathLabel setString:[NSString stringWithFormat:@" %@ + %@ = %@ ", _expression[1], _expression[2], _expression[3]]];
    
    [_equationLabel setString:[NSString stringWithFormat:@" %@ + %@ = %@ ", _equation[1], _equation[2], _equation[3]]];
    
    
    self.sorted[0] = firstNumber;
    self.sorted[1] = secondNumber;
    self.sorted[2] = thirdNumber;
    
    
    NSLog(@"Unsorted array:%@", _sorted);
    
    NSArray *sortedArray = [_sorted sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSLog(@"Sorted array:%@", sortedArray);
    
    [self expressionRecalcute];
    
    [_firstLabel setString:[NSString stringWithFormat:@"%@",sortedArray[0]]];
    [_secondLabel setString:[NSString stringWithFormat:@"%@",sortedArray[1]]];
    [_thirdLabel setString:[NSString stringWithFormat:@"%@",sortedArray[2]]];

}

#pragma mark - Three Buttons
- (void)onGameplayButtonPressed:(CCButton *)sender {
  
    
    if (_canPressBOOL == YES) {
         _canPressBOOL = NO;
        
        DEF_CLICK_SND;
        
        [self unschedule:@selector(milisecUpdate:)];
        _milisecCount = 0;
        
        [self animateMilisec];
        
        //Подсчет очков
        NSString *milisecStr = [_milisecLabel string];
        float milisec = [milisecStr floatValue];
        
        self.milisecRound = _milisecRound + milisec;
        
        
        
        if (sender.zOrder == 1001) {
            if ([[_firstLabel string] isEqualToString:[NSString stringWithFormat:@"%@",_rightNumber]]) {
                NSLog(@"RIGHT"); [self showEquationWinOrFailLabel:@"Win"];
            } else {
                NSLog(@"BAD");   [self showEquationWinOrFailLabel:@"Fail"];
            }
        }
        else if (sender.zOrder == 1002) {
            if ([[_secondLabel string] isEqualToString:[NSString stringWithFormat:@"%@",_rightNumber]]) {
                NSLog(@"RIGHT"); [self showEquationWinOrFailLabel:@"Win"];
            } else {
                NSLog(@"BAD");   [self showEquationWinOrFailLabel:@"Fail"];
            }
        }
        else if (sender.zOrder == 1003) {
            if ([[_thirdLabel string] isEqualToString:[NSString stringWithFormat:@"%@",_rightNumber]]) {
                NSLog(@"RIGHT"); [self showEquationWinOrFailLabel:@"Win"];
            } else {
                NSLog(@"BAD");   [self showEquationWinOrFailLabel:@"Fail"];
            }
        }
    }
    
  
}

- (void)delayMathematicalExpression
{
    //ПЕРЕСЧЕТ
    [self setMathematicalExpression];
    
    NSInteger count = _levelCount;
    self.levelCount = count + 1;
    
    _canPressBOOL = YES;
    
    
}

- (void)showEquationWinOrFailLabel:(NSString *)winOrFail
{
    
    //[_mathLabel setString:[NSString stringWithFormat:@" %@ + %@ = %@ ", _expression[1], _expression[2], _expression[3]]];
    
    [_equationLabel setString:[NSString stringWithFormat:@" %@ + %@ = %@ ", _expression[1], _expression[2], _expression[3]]];
    
    if ([winOrFail isEqualToString:@"Win"]) {
        [self performSelector:@selector(showWinSprite) withObject:nil afterDelay:0.9];
    } else {
        _equationLabel.color = [CCColor redColor];
        _equationLabel.opacity = 0.8;
        [self performSelector:@selector(showFailSprite) withObject:nil afterDelay:0.9];
    }
    
    
    
    
}

- (void)checkGameState {
    
    NSInteger rounds = 3;
    if (_levelCount >= rounds && _milisecRound <= rounds*1500) {
        CCLOG(@"WIN STATE");
        //FAILSCENE
        FailScene *failScene = [FailScene scene];
        //failScene.pointsNumber = _pointsCount;
        //[failScene pointsLabel];
        [failScene setWinBackground];
        [failScene setPointsLabelWithString:[NSString stringWithFormat:@"Your time is %d",(rounds*1000)]];
        
        [[CCDirector sharedDirector] replaceScene:failScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
        
    } else if (_levelCount >= rounds && _milisecRound >= rounds*1500) {
        CCLOG(@"FAIL STATE");
        
        FailScene *failScene = [FailScene scene];
        [failScene setLooseBackground];
        
        [failScene setPointsLabelWithString:[NSString stringWithFormat:@"Must be more than %d",(rounds*1000)]];
        
        [[CCDirector sharedDirector] replaceScene:failScene withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
    }
    
    [self performSelector:@selector(delayMathematicalExpression) withObject:nil afterDelay:0.6];
}

- (void)showWinSprite
{
    CCSprite *winCircle = [CCSprite spriteWithImageNamed:@"circle.png"];
    winCircle.position = ccp(WIDTH*0.5, HEIGHT*0.5);
    
    CCLabelTTF *winLabel = [CCLabelTTF labelWithString:@" WIN " fontName:@"Minnie.TTF" fontSize:150];
    winLabel.position = ccp(winCircle.CONTENTWIDTH*0.5, winCircle.CONTENTHEIGHT*0.5);
    winLabel.color = [CCColor yellowColor];
    
    [winCircle addChild:winLabel];
    [self addChild:winCircle z: 3401];
    
    if(IS_IPHONE) winCircle.scale = 0.5;
    
    [self performSelector:@selector(removeSprite:) withObject:winCircle afterDelay:0.5];
    
    [self performSelector:@selector(checkGameState) withObject:nil afterDelay:0.6];
    
}



- (void)showFailSprite
{
    _equationLabel.color = [CCColor whiteColor];
    _equationLabel.opacity = 1.0;
    
    CCSprite *failCross = [CCSprite spriteWithImageNamed:@"cross.png"];
    failCross.position = ccp(WIDTH*0.5, HEIGHT*0.5);
    
    CCLabelTTF *failLabel = [CCLabelTTF labelWithString:@" FAIL " fontName:@"Minnie.TTF" fontSize:150];
    failLabel.position = ccp(failCross.CONTENTWIDTH*0.5, failCross.CONTENTHEIGHT*0.5);
    failLabel.color = [CCColor yellowColor];
    
    [failCross addChild:failLabel];
    [self addChild:failCross z: 3501];
    
    if(IS_IPHONE) failCross.scale = 0.5;
    
    [self performSelector:@selector(removeSprite:) withObject:failCross afterDelay:0.5];
    
     [self performSelector:@selector(checkGameState) withObject:nil afterDelay:0.6];
    
}

- (void)removeSprite:(CCSprite *)sprite
{
    [sprite removeFromParent];
}

- (void)expressionRecalcute
{
    

}


#pragma mark - Pause and Restart
- (void)pauseButtonPressed:(id)sender
{
    [self setMathematicalExpression];
    
}

- (void)restartButtonPressed:(id)sender
{
    
}

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
        
        
        if (i == 1) {
            //LABEL
            if(_firstLabel == nil) {
                self.firstLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %ld ",(long)i] fontName:@"Minnie.TTF" fontSize:75 dimensions:CGSizeMake(480, 100)];
                _firstLabel.anchorPoint = ccp(0.1,0.5);
                _firstLabel.position = ccp(button.CONTENTWIDTH*0.5, button.CONTENTHEIGHT*0.5);
                
                [button addChild:_firstLabel z:500+i ];
            }
        }
        else if (i == 2) {
            if(_secondLabel == nil) {
                self.secondLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %ld ",(long)i] fontName:@"Minnie.TTF" fontSize:75 dimensions:CGSizeMake(480, 100)];
                _secondLabel.anchorPoint = ccp(0.1,0.5);
                _secondLabel.position = ccp(button.CONTENTWIDTH*0.5, button.CONTENTHEIGHT*0.5);
                
                [button addChild:_secondLabel z:500+i ];
            }
        }
        else if (i == 3) {
            if(_thirdLabel == nil) {
                self.thirdLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %ld ",(long)i] fontName:@"Minnie.TTF" fontSize:75 dimensions:CGSizeMake(480, 100)];
                _thirdLabel.anchorPoint = ccp(0.1,0.5);
                _thirdLabel.position = ccp(button.CONTENTWIDTH*0.5, button.CONTENTHEIGHT*0.5);
                
                [button addChild:_thirdLabel z:500+i ];
            }
        }
        [self addChild:button z:1000+i];
    }
}



#pragma mark - Miliseconds
- (void)setMilisecLabel {

     _milisecLabel = [CCLabelTTF labelWithString:@" 000" fontName:@"Minnie.TTF" fontSize:47.50f];
    
    _milisecLabel.anchorPoint = ccp(0.1, 0.5);
    _milisecLabel.position = ccp(WIDTH*0.0, HEIGHT*0.5+150); // Middle of screen
    [self addChild:_milisecLabel z: 101];
    
    //_milisecLabel.scale = 1.2;
    //if (IS_IPHONE) _milisecLabel.scale = 0.6;
    
    _milisecLabel.rotation = 20;
}

- (void)milisecUpdate:(CCTime)delta
{
    _milisecCount = _milisecCount + delta;
    NSInteger milisec = _milisecCount*1000;
    
    [_milisecLabel setString:[NSString stringWithFormat:@" %ld ",(long)milisec]];

    if (milisec >= 10000) {
        [_milisecLabel setString:@" 000"];
         //_desk.position = ccp(WIDTH*0.05,HEIGHT*0.82); //for 3-digit
        [self unschedule:@selector(milisecUpdate:)];
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
    [_milisecLabel setString:@" 000"];
}

#pragma mark - Lightening Stripes
- (void)setLighteningStripes
{
    
}

- (void)dealloc
{
    
    
}

@end
