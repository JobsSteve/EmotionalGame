//
//  CCLabelTTF+Extension.h
//  EmotionalGame
//
//  Created by artoorix on 21.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCLabelTTF.h"

@interface CCLabelTTF (Extension)

//CREATE LABEL
+ (CCLabelTTF *)createLabelWithString:(NSString *)textString andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;


//CREATE LABEL + Color and Opacity
+ (CCLabelTTF *)createLabelWithColor:(CCColor *)color andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

//CREATE LABEL + Color and Opacity and PositionType
+ (CCLabelTTF *)createLabelWithColor:(CCColor *)color andPositionType:(BOOL)positionType andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

//DOUBLE LABEL
+ (CCLabelTTF *)createDoubleLabelWithFrontColor:(CCColor *)frontColor andBackColor:(CCColor *)backColor andXOffset:(CGFloat)xOffset andYOffset:(CGFloat)yOffset andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z;

//DOUBLE LABEL + Scale
+ (CCLabelTTF *)createDoubleLabelWithFrontColor:(CCColor *)frontColor andBackColor:(CCColor *)backColor andXOffset:(CGFloat)xOffset andYOffset:(CGFloat)yOffset andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andScaleX:(float)scaleX andScaleY:(float)scaleY;



@end
