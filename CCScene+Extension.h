//
//  CCScene+Extension.h
//  ThreeButtonProject
//
//  Created by artoorix on 11.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface CCScene (Extension)

//BACK BUTTON
- (void)setBackButton;


//PAUSE - RESTART
- (void)setPauseButton;
- (void)setRestartButton;


//THREE BUTTONS
- (void)setThreeButtonsWithName:(NSString *)name;
- (void)setThreeButtons;
- (void)setThreeButtonsWithThreeStrings:(NSArray *)threeStrings;


//BACKGROUNDS
- (void)setBackgroundWithStripes;
- (void)setDefaultBackground;
-(void)setBackgroundWithImage:(NSString *)bg;



////LABEL
//- (CCLabelTTF *)createLabelWithString:(NSString *)string andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;
//
////SPRITE
//- (CCSprite *)createSpriteWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;
//
////BUTTON
//- (CCButton *)createButtonWithImage:(NSString *)image andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

@end
