//
//  AppDelegate.m
//  MusicPlayer
//
//  Created by tangwei on 16/1/7.
//  Copyright © 2016年 tangwei. All rights reserved.
//

#import "AppDelegate.h"
#import "YTZTabbarViewController.h"
#import "InformationViewControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self remoteEvent];
    [self init_ui];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIBackgroundTaskIdentifier  _bgTaskId;
    // 设置音频会话，允许后台播放
    _bgTaskId = [self.class backgroundPlayerID:_bgTaskId];
    
    [self remoteEvent];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.userInfo archiverUserInfo];
}

- (void) init_ui
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _player = [[MPMoviePlayerController alloc]init];
        _playList = [NSMutableArray array];
        _currentSong = [[SongInfo alloc]init];
        
        [self loadArchiver];
        [self initChannelsData];
        //后台播放
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
    });
    
    YTZTabbarViewController *YZTTabbarVC = [[YTZTabbarViewController alloc] init];
    /*设置导航栏和底部菜单栏全局风格属性*/
    //    [[UINavigationBar appearance] setTranslucent:NO];//关闭默认半透明效果
    [[UINavigationBar appearance] setBarTintColor:YTZStyle_Color_NavBar_BGColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:YTZStyle_Color_NavBar_TitleColor,NSFontAttributeName:[UIFont systemFontOfSize:YTZStyle_FontSize_NavBar_TitleSize]}];
    
    //设置底部导航按钮选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:YTZStyle_Color_Orange} forState:UIControlStateSelected];
    
    InformationViewControl *leftVC = [[InformationViewControl alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:YZTTabbarVC
                                                                    leftMenuViewController:leftVC
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:sideMenuViewController];
    [self.window makeKeyAndVisible];
}

+ (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    //允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if (newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}

- (void)loadArchiver{
    
    NSString *homePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *appdelegatePath = [homePath stringByAppendingPathComponent:@"appdelegate.archiver"];//添加储存的文件名
    NSData *data = [[NSData alloc]initWithContentsOfFile:appdelegatePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    _userInfo = [unarchiver decodeObjectForKey:@"userInfo"];
    [unarchiver finishDecoding];
    
    if (_currentChannel == nil) {
        _currentChannel = [[ChannelInfo alloc]init];
        _currentChannel.name = @"我的私人";
        _currentChannel.ID = @"0";
    }
    if (_userInfo == nil) {
        _userInfo = [[UserInfo alloc]init];
    }
}

- (void) remoteEvent
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlPlay:{
                NSNotification *notification = [NSNotification notificationWithName:@"playRomate" object:self userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                break;
                
            case UIEventSubtypeRemoteControlPause:{
                NSNotification *notification = [NSNotification notificationWithName:@"playRomatePause" object:self userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                NSLog(@"RemoteControlEvents: pause");
            }
                break;
                
            case UIEventSubtypeRemoteControlTogglePlayPause:{
                NSNotification *notification = [NSNotification notificationWithName:@"playRomatePause" object:self userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                NSLog(@"RemoteControlEvents: pause");
            }
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:{
                NSNotification *notification = [NSNotification notificationWithName:@"playRomateNextSong" object:self userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                NSLog(@"RemoteControlEvents: playModeNext");
            }
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:{
                NSNotification *notification = [NSNotification notificationWithName:@"playRomatePrevSong" object:self userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                NSLog(@"RemoteControlEvents: playPrev");
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)initChannelsData{
    //初始化数据源Array
    _channelsTitle = @[@"我的兆赫",@"推荐频道",@"上升最快兆赫",@"热门兆赫"];
    _channels = [NSMutableArray array];
    //我的兆赫
    ChannelInfo *myPrivateChannel = [[ChannelInfo alloc]init];
    myPrivateChannel.name = @"我的私人";
    myPrivateChannel.ID = @"0";
    ChannelInfo *myRedheartChannel = [[ChannelInfo alloc]init];
    myRedheartChannel.name = @"我的红心";
    myRedheartChannel.ID = @"-3";
    NSArray *myChannels = @[myPrivateChannel, myRedheartChannel];
    [_channels addObject:myChannels];
    //推荐兆赫
    NSArray *recommendChannels = [NSMutableArray array];
    [_channels addObject:recommendChannels];
    //上升最快兆赫
    NSMutableArray *upTrendingChannels = [NSMutableArray array];
    [_channels addObject:upTrendingChannels];
    //热门兆赫
    NSMutableArray *hotChannels = [NSMutableArray array];
    [_channels addObject:hotChannels];
}

@end
