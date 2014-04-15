//
//  LevelNameScene.h
//  ThreeButtonProject
//
//  Created by artoorix on 14.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface LevelNameScene : CCScene

@property (nonatomic, strong) NSString *word1;
@property (nonatomic, strong) NSString *word2;
@property (nonatomic, strong) NSString *word3;

@property (nonatomic, strong) NSString *stage;

+ (LevelNameScene *)scene;
- (id)init;

- (void)animateLevelName;
- (void)setLevelStage;

@end
