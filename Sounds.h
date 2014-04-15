//
//  Sounds.h
//  ThreeButtonProject
//
//  Created by artoorix on 06.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#ifndef ThreeButtonProject_Sounds_h
#define ThreeButtonProject_Sounds_h



#define THEME_MUSIC [[OALSimpleAudio sharedInstance] playBg:@"themeMusic.mp3" loop:YES];

#define THEME_MUSIC_FLAG  if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Music"] isEqualToString:@"YES"]){[[OALSimpleAudio sharedInstance] playBg:@"themeMusic.mp3" loop:YES];}else{[[OALSimpleAudio sharedInstance] stopBg];}



#define DEF_CLICK_SND if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Sound"] isEqualToString:@"YES"]) [[OALSimpleAudio sharedInstance] playEffect:@"default-click.mp3"] 

#define LEVEL_CHOOSE_SND [[OALSimpleAudio sharedInstance] playEffect:@"level-choose.mp3"]


#define READY_GO_SND [[OALSimpleAudio sharedInstance] playEffect:@"ready-go.mp3"]

#define RIGHT_SND [[OALSimpleAudio sharedInstance] playEffect:@"right.mp3"]
#define WRONG_SND [[OALSimpleAudio sharedInstance] playEffect:@"wrong.mp3"]

#define FAIL_SND [[OALSimpleAudio sharedInstance] playEffect:@"whistle.mp3"]

#define FAIL_LEVEL_SND   [[OALSimpleAudio sharedInstance] playEffect:@"fail-level.mp3"]
#define NORMAL_LEVEL_SND [[OALSimpleAudio sharedInstance] playEffect:@"normal-level.mp3"]


#define WIN_ROUND_SND   [[OALSimpleAudio sharedInstance] playEffect:@"win-click.mp3"]
#define LOOSE_ROUND_SND [[OALSimpleAudio sharedInstance] playEffect:@"wrong.mp3"]



#define SND_LABEL_FALL [[OALSimpleAudio sharedInstance] playEffect:@"label-fall.mp3"]

#endif
