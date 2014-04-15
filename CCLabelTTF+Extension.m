//
//  CCLabelTTF+Extension.m
//  EmotionalGame
//
//  Created by artoorix on 21.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCLabelTTF+Extension.h"

@implementation CCLabelTTF (Extension)

+ (CCLabelTTF *)createLabelWithString:(NSString *)textString andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    [label setPosition:point];
    
    if (scene && z) {
        [scene addChild:label z:z];
    } else if (scene && z==0 ) {
        [scene addChild:label];
    }
    
    return label;
}

+ (CCLabelTTF *)createLabelWithColor:(CCColor *)color andPositionType:(BOOL)positionType andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    
    if(positionType == YES) {
    [label setPositionType:CCPositionTypeNormalized];
    }
    [label setPosition:point];
    
    if (scene && z) {
        [scene addChild:label z:z];
    } else if (scene && z==0 ) {
        [scene addChild:label];
    }    label.color = color;
    
    if (opacity)
    [label setOpacity:opacity];
    
    return label;
}


+ (CCLabelTTF *)createLabelWithColor:(CCColor *)color andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    
    //[label setPositionType:CCPositionTypeNormalized];
    
    [label setPosition:point];
    
    if (scene && z) {
        [scene addChild:label z:z];
    } else if (scene && z==0 ) {
        [scene addChild:label];
    }    label.color = color;
    
    if (opacity)
        [label setOpacity:opacity];
    
    return label;
}

+ (CCLabelTTF *)createDoubleLabelWithFrontColor:(CCColor *)frontColor andBackColor:(CCColor *)backColor andXOffset:(CGFloat)xOffset andYOffset:(CGFloat)yOffset andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z
{
    CCLabelTTF *mainLabel = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    [mainLabel setPosition:point];
    mainLabel.color = backColor;
    
    if (scene && z) {
        [scene addChild:mainLabel z:z];
    } else if (scene && z==0 ) {
        [scene addChild:mainLabel];
    }
    
    if (opacity)
        [mainLabel setOpacity:opacity];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    [label setPosition:ccp(mainLabel.contentSize.width*0.5+xOffset, mainLabel.contentSize.height*0.5+yOffset)];
    
    label.color = frontColor;
    [mainLabel addChild:label z:z+1];
    
    
    return mainLabel;
}

+ (CCLabelTTF *)createDoubleLabelWithFrontColor:(CCColor *)frontColor andBackColor:(CCColor *)backColor andXOffset:(CGFloat)xOffset andYOffset:(CGFloat)yOffset andString:(NSString *)textString andOpacity:(CGFloat)opacity andFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andPosition:(CGPoint)point andNode:(CCNode *)scene andZ:(NSInteger)z andScaleX:(float)scaleX andScaleY:(float)scaleY
{
    CCLabelTTF *mainLabel = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    [mainLabel setPosition:point];
    mainLabel.color = backColor;
    
    mainLabel.scaleX = scaleX;
    mainLabel.scaleY = scaleY;
    
    if (scene && z) {
        [scene addChild:mainLabel z:z];
    } else if (scene && z==0 ) {
        [scene addChild:mainLabel];
    }
    
    if (opacity)
        [mainLabel setOpacity:opacity];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:textString fontName:fontName fontSize:fontSize];
    [label setPosition:ccp(mainLabel.contentSize.width*0.5+xOffset, mainLabel.contentSize.height*0.5+yOffset)];
    label.color = frontColor;
    [mainLabel addChild:label z:z+1];
    
    
    return mainLabel;
}





@end
