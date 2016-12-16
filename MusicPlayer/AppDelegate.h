//
//  AppDelegate.h
//  MusicPlayer
//
//  Created by tangwei on 16/1/7.
//  Copyright © 2016年 tangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ChannelInfo.h"
#import "SongInfo.h"
#import "UserInfo.h"
#import "RESideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) MPMoviePlayerController *player;
@property (nonatomic) NSMutableArray *playList;
@property (nonatomic) SongInfo *currentSong;
@property (nonatomic) int currentSongIndex;
@property (nonatomic) ChannelInfo *currentChannel;
@property (nonatomic) UserInfo *userInfo;

@property (nonatomic) NSArray *channelsTitle;
@property (nonatomic) NSMutableArray *channels;

@end

