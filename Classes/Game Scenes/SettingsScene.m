//
//  SettingsScene.m
//  EmotionalGame
//
//  Created by artoorix on 25.03.14.
//  Copyright (c) 2014 Артур. All rights reserved.
//

#import "SettingsScene.h"

#import "CCScene+Extension.h"
#import "CCButton+Extension.h"
#import "CCLabelTTF+Extension.h"

#import "IntroScene.h"

@interface SettingsScene ()
{
    
}

@property (nonatomic, strong) CCButton *musicButton;

@property (nonatomic, strong) CCLabelTTF *musicLabel;
@property (nonatomic, strong) CCLabelTTF *soundLabel;


@end

@implementation SettingsScene

+ (SettingsScene *)scene {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    [self setBackgroundWithImage:@"settings.png"];
    [self setBackButton];
    [self setButtons];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Music"] isEqualToString:@"YES"]) {
        //THEME_MUSIC_FLAG;
        
        [self.musicLabel setString:@"Music (Off)"];
    } else {
         [self.musicLabel setString:@"Music (On)"];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Sound"] isEqualToString:@"YES"]) {
        DEF_CLICK_SND;
        
        [self.soundLabel setString:@"Sound Effect (Off)"];
    } else {
        [self.soundLabel setString:@"Sound Effect (On)"];
    }
    
    
    
    
    return self;
}

- (void)onBackButtonPressed:(id)sender
{
    DEF_CLICK_SND;
    
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5]];
}

- (void)setButtons
{
    //Music Button
    self.musicButton = [CCButton createButtonWithString:@"" andImage:@"green-btn.png" andPosition:ccp(WIDTH*0.5,HEIGHT*0.8) andNode:self andZ:0 andSelector:@selector(onMusicButton:)];
    
    self.musicLabel = [CCLabelTTF createLabelWithColor:[CCColor whiteColor] andPositionType:NO andString:@"Music" andOpacity:0.9 andFontName:@"Minnie.TTF" andFontSize:40 andPosition:ccp(_musicButton.contentSize.width*0.5, _musicButton.contentSize.height*0.5) andNode:_musicButton andZ:0];
    
    
    //Sound Effect
    CCButton *soundButton = [CCButton createButtonWithString:@"" andImage:@"green-btn.png" andPosition:ccp(WIDTH*0.5,HEIGHT*0.6) andNode:self andZ:0 andSelector:@selector(onSoundButton:)];
    
    self.soundLabel = [CCLabelTTF createLabelWithColor:[CCColor whiteColor] andPositionType:NO  andString:@"Sound (On)" andOpacity:0.9 andFontName:@"Minnie.TTF" andFontSize:40 andPosition:ccp(soundButton.contentSize.width*0.5, soundButton.contentSize.height*0.5) andNode:soundButton andZ:0];
    
    
    //Privacy Policy
    CCButton *policyButton = [CCButton createButtonWithString:@"" andImage:@"blue-btn.png" andPosition:ccp(WIDTH*0.5,HEIGHT*0.4) andNode:self andZ:0 andSelector:@selector(onButton:)];
    
    [CCLabelTTF createLabelWithColor:[CCColor whiteColor] andPositionType:NO  andString:@"Privacy Policy" andOpacity:0.9 andFontName:@"Minnie.TTF" andFontSize:40 andPosition:ccp(policyButton.contentSize.width*0.5, policyButton.contentSize.height*0.5) andNode:policyButton andZ:0];
    
    
    //Facebook Login
    CCButton *loginButton = [CCButton createButtonWithString:@"" andImage:@"blue-btn.png" andPosition:ccp(WIDTH*0.5,HEIGHT*0.2) andNode:self andZ:0 andSelector:@selector(onButton:)];
    
    [CCLabelTTF createLabelWithColor:[CCColor whiteColor] andPositionType:NO  andString:@"Facebook Login" andOpacity:0.9 andFontName:@"Minnie.TTF" andFontSize:40 andPosition:ccp(loginButton.contentSize.width*0.5, loginButton.contentSize.height*0.5) andNode:loginButton andZ:0];

}

- (void)onMusicButton:(CCButton *)sender
{
//    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Music"] isEqualToString:@"YES"]) {
//        sender.selected = YES;
//        [self.musicLabel setString:@"Music (On)"];
//    } else {
//        sender.selected = NO;
//        [self.musicLabel setString:@"Music (Off)"];
//    }
//    //Проверка selected и user defaults.
//
//    if (sender.selected == YES) {
//        sender.selected = NO;
//        //[self.musicLabel setString:@"Music (On)"];
//        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"Music"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//         THEME_MUSIC_FLAG;
//    } else {
//        sender.selected = YES;
//        //[self.musicLabel setString:@"Music (Off)"];
//        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Music"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        THEME_MUSIC_FLAG;
//    }
//        //DEF_CLICK_SND;
//    CCLOG(@"selected = %d", sender.selected);
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Music"] isEqualToString:@"YES"]) {
        [self.musicLabel setString:@"Music (On)"];
       
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"Music"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else {
        [self.musicLabel setString:@"Music (Off)"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Music"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
     THEME_MUSIC_FLAG;
}

- (void)onSoundButton:(CCButton *)sender
{
//    if (sender.selected == YES) {
//        sender.selected = NO;
//        [self.soundLabel setString:@"Sound Effect (On)"];
//
//        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Sound"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    } else {
//        sender.selected = YES;
//        [self.soundLabel setString:@"Sound Effect (Off)"];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"Sound"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    }
//    DEF_CLICK_SND;
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Sound"] isEqualToString:@"YES"]) {
        [self.soundLabel setString:@"Sound Effect (On)"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"Sound"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else {
        [self.soundLabel setString:@"Sound Effect (Off)"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Sound"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    DEF_CLICK_SND;
    
    CCLOG(@"selected = %d", sender.selected);
}

- (void)onButton:(CCButton *)sender
{
     DEF_CLICK_SND;
}






@end
