//
//  HomePageMainViewController.m
//  MusicPlayer
//
//  Created by tangwei on 16/1/7.
//  Copyright © 2016年 tangwei. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, PLAY_WAY) {
    
    type_next_song,
    type_prev_song,
    
};

#import "HomePageMainViewController.h"

@interface HomePageMainViewController ()
{
    AppDelegate          *appDelegate;
    NetworkManager       *networkManager;
    UIImageView          *_image;
    UILabel              *_labelSongName;
    UILabel              *_labelSinger;
    NSTimer              *_timer;
    UILabel              *_labelPlayTime;
    UILabel              *_labelTotalTime;
    UISlider             *_slidePlay;
    UIButton             *_btnPlay;
    UIButton             *_btnPrevSong;
    UIButton             *_btnNextSong;
    bool                 firstPlay;
}

@end

@implementation HomePageMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[Global GlobalSingleton] set_obj_home:self];
    
    [self addNotification];
    [self init_nav];
    [self init_data];
    [self init_ui];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNextSong) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChange) name:MPMoviePlayerLoadStateDidChangeNotification object:appDelegate.player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNextSongState) name:@"playNextSong" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playPrevSongState) name:@"playPrevSong" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playRomatePause) name:@"playRomatePause" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playRomate) name:@"playRomate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playRomateNextSong) name:@"playRomateNextSong" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playRomatePrevSong) name:@"playRomatePrevSong" object:nil];
}

- (void) init_nav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:0 target:self action:@selector(presentLeftMenuViewController:)];
    
    UIButton *btnRight = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnRight addTarget:self action:@selector(on_right_click:) forControlEvents:UIControlEventTouchUpInside];
    [btnRight setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = itemRight;
}

- (void) init_data
{
    firstPlay      = true;
    networkManager = [[NetworkManager alloc]init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (void) init_ui
{
    self.view.backgroundColor = YTZStyle_Color_Content_BGColor;
    
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stars"]];
    [self.view setBackgroundColor:bgColor];
    
    UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 49 - 64)];
    viewBottom.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewBottom];
    
    UIButton *btnRefresh = [UIButton new];
    [btnRefresh setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
    [viewBottom addSubview:btnRefresh];
    [btnRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBottom.mas_left).offset(YTZStyle_SpacingSize);
        make.bottom.equalTo(viewBottom.mas_bottom).offset(- YTZStyle_BottomSpacingSize);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    _btnPlay = [UIButton new];
    [_btnPlay setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
    [_btnPlay setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateSelected];
    _btnPlay.selected = NO;
    [_btnPlay addTarget:self action:@selector(on_play) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:_btnPlay];
    [_btnPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewBottom.mas_centerX);
        make.centerY.equalTo(btnRefresh.mas_centerY);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    
    UIButton *btnDetail = [UIButton new];
    [btnDetail setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
    [viewBottom addSubview:btnDetail];
    [btnDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewBottom.mas_right).offset(-YTZStyle_SpacingSize);
        make.bottom.equalTo(viewBottom.mas_bottom).offset(- YTZStyle_BottomSpacingSize);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    _btnPrevSong = [UIButton new];
    [_btnPrevSong setImage:[UIImage imageNamed:@"prev_song"] forState:UIControlStateNormal];
    [_btnPrevSong addTarget:self action:@selector(on_prev_play) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:_btnPrevSong];
    [_btnPrevSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btnPlay.mas_left).offset(-YTZStyle_CenterSpacingSize);
        make.centerY.equalTo(btnRefresh.mas_centerY);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];

    _btnNextSong = [UIButton new];
    [_btnNextSong setImage:[UIImage imageNamed:@"next_song"] forState:UIControlStateNormal];
    [_btnNextSong addTarget:self action:@selector(on_next_play) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:_btnNextSong];
    [_btnNextSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnPlay.mas_right).offset(YTZStyle_CenterSpacingSize);
        make.centerY.equalTo(btnRefresh.mas_centerY);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    _labelPlayTime = [UILabel new];
    _labelPlayTime.font = [UIFont systemFontOfSize:13.0];
    _labelPlayTime.text = @"00:00";
    _labelPlayTime.textColor = [UIColor whiteColor];
    [viewBottom addSubview:_labelPlayTime];
    [_labelPlayTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBottom.mas_left).offset(10.0);
        make.bottom.equalTo(_btnPlay.mas_top).offset(-20.0);
    }];
    
    _labelTotalTime = [UILabel new];
    _labelTotalTime.font = [UIFont systemFontOfSize:13.0];
    _labelTotalTime.text = @"00:00";
    _labelTotalTime.textColor = [UIColor whiteColor];
    [viewBottom addSubview:_labelTotalTime];
    [_labelTotalTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewBottom.mas_right).offset(-10.0);
        make.bottom.equalTo(_btnPlay.mas_top).offset(-20.0);
    }];
    
    _slidePlay = [UISlider new];
    [_slidePlay setValue:0.0 animated:YES];
    [_slidePlay setThumbImage:[UIImage imageNamed:@"music_slider_circle"] forState:UIControlStateNormal];
    [viewBottom addSubview:_slidePlay];
    [_slidePlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelPlayTime.mas_right).offset(12.0);
        make.right.equalTo(_labelTotalTime.mas_left).offset(-12.0);
        make.centerY.equalTo(_labelPlayTime.mas_centerY);
        make.height.equalTo(@2);
    }];
    
    UIButton *btnLove = [UIButton new];
    [btnLove setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
    [viewBottom addSubview:btnLove];
    [btnLove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBottom.mas_left).offset(22.0);
        make.bottom.equalTo(_slidePlay.mas_top).offset(-35.0);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];

    _labelSinger = [UILabel new];
    _labelSinger.font = [UIFont systemFontOfSize:15.0];
    _labelSinger.text = @"";
    _labelSinger.textColor = [UIColor whiteColor];
    _labelSinger.numberOfLines = 1;
    _labelSinger.textAlignment = NSTextAlignmentCenter;
    [viewBottom addSubview:_labelSinger];
    [_labelSinger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewBottom.mas_centerX);
        make.bottom.equalTo(_slidePlay.mas_top).offset(-20.0);
        make.left.equalTo(viewBottom.mas_left).offset(45.0);
        make.right.equalTo(viewBottom.mas_right).offset(-45.0);
    }];

    _labelSongName = [UILabel new];
    _labelSongName.font = [UIFont systemFontOfSize:18.0];
    _labelSongName.text = @"";
    _labelSongName.textColor = [UIColor whiteColor];
    _labelSongName.numberOfLines = 1;
    _labelSongName.textAlignment = NSTextAlignmentCenter;
    [viewBottom addSubview:_labelSongName];
    [_labelSongName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewBottom.mas_centerX);
        make.bottom.equalTo(_labelSinger.mas_top).offset(-10.0);
        make.left.equalTo(viewBottom.mas_left).offset(45.0);
        make.right.equalTo(viewBottom.mas_right).offset(-45.0);
    }];
    
    _image = [UIImageView new];
    _image.backgroundColor = [UIColor clearColor];
    _image.layer.masksToBounds = YES;
    _image.layer.cornerRadius = 3.0f;
    [viewBottom addSubview:_image];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBottom.mas_top).offset([self getImageWidth]);
        make.bottom.equalTo(_labelSongName.mas_top).offset(-[self getImageWidth]);
        make.left.equalTo(viewBottom.mas_left).offset(60);
        make.right.equalTo(viewBottom.mas_right).offset(-60);
    }];
}

-(void)loadPlaylist{
    [networkManager loadPlaylistwithType:@"n"];
}

- (void) refreshUI
{
    if( appDelegate.currentSong.picture.length != 0 ){
        [_image sd_setImageWithURL:[[NSURL alloc] initWithString:appDelegate.currentSong.picture] placeholderImage:nil];
    }
    
    _labelSongName.text = appDelegate.currentSong.title;
    _labelSinger.text   = appDelegate.currentSong.artist;
    
    unsigned TotalTimeSeconds = (unsigned) [appDelegate.currentSong.length intValue] % 60;
    unsigned TotalTimeMinutes = (unsigned) [appDelegate.currentSong.length intValue] / 60;
    _labelTotalTime.text = [NSString stringWithFormat:@"%.2u:%.2u", TotalTimeMinutes, TotalTimeSeconds];
}

- (int) getImageWidth
{
    NSString *osType = [UtilHelper getCurrentDeviceModel];
    if( [osType isEqualToString:@"iPhone 4 type"] ){
        return 15;
    }
    else if( [osType isEqualToString:@"iPhone 5 type"] ){
        return 40;
    }
    else if( [osType isEqualToString:@"iPhone 6 type"] ){
        return 55;
    }
    else if( [osType isEqualToString:@"iPhone 6p type"] ){
        return 70;
    }
    else{
        return 25;
    }
}

-(void) updateProgress{
    if( appDelegate.currentSong.title != nil ){
        [self setLockScreenNowPlayingInfo];
    }
    unsigned currentTimeMinutes = (unsigned)appDelegate.player.currentPlaybackTime / 60;
    unsigned currentTimeSeconds = (unsigned)appDelegate.player.currentPlaybackTime % 60;
    _labelPlayTime.text = [NSString stringWithFormat:@"%.2u:%.2u", currentTimeMinutes, currentTimeSeconds];
    [_slidePlay setValue:appDelegate.player.currentPlaybackTime / [appDelegate.currentSong.length intValue] animated:YES];
    
//    类转nsdata
//    NSData *lastSongData = [NSKeyedArchiver archivedDataWithRootObject:appDelegate.lastSong];
//    NSData *currentSongData = [NSKeyedArchiver archivedDataWithRootObject:appDelegate.currentSong];
}

- (void) setLockScreenNowPlayingInfo
{
    //更新锁屏时的歌曲信息
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        //歌曲名称
        [dict setObject:appDelegate.currentSong.title forKey:MPMediaItemPropertyTitle];
        
        //演唱者
        [dict setObject:appDelegate.currentSong.artist forKey:MPMediaItemPropertyArtist];
        
        //专辑名
        [dict setObject:@"" forKey:MPMediaItemPropertyAlbumTitle];
        
        //专辑缩略图
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:appDelegate.currentSong.picture]];
        UIImage *image = [UIImage imageWithData:imageData];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        
        //音乐剩余时长
        [dict setObject:[NSNumber numberWithDouble:appDelegate.player.duration] forKey:MPMediaItemPropertyPlaybackDuration];
        
        //音乐当前播放时间 在计时器中修改
        //[dict setObject:[NSNumber numberWithDouble:0.0] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        //设置锁屏状态下屏幕显示播放音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

- (void) on_play
{
    if( firstPlay ){
        [self loadPlaylist];
        firstPlay = false;
    }
    else{
        if( _btnPlay.selected ){
            [appDelegate.player pause];
        }
        else{
            [appDelegate.player play];
        }
    }
    _btnPlay.selected = !_btnPlay.selected;
}

-(void)likeSong{
    [networkManager loadPlaylistwithType:@"r"];
}

-(void)dislikesong{
    [networkManager loadPlaylistwithType:@"u"];
}

-(void)deleteSong{
    [networkManager loadPlaylistwithType:@"b"];
}

-(void)skipSong{
    [networkManager loadPlaylistwithType:@"s"];
}

-(void) on_prev_play
{
    _btnPrevSong.enabled = NO;
    [self playPrevSong];
}

-(void) on_next_play
{
    _btnNextSong.enabled = NO;
    [self playNextSong];
}

- (void) playNextSongState
{
    _btnNextSong.enabled = YES;
}

- (void) playPrevSongState
{
    _btnPrevSong.enabled = YES;
}

- (void) playRomateNextSong
{
    [self playNextSong];
}

- (void) playRomatePrevSong
{
    [self playPrevSong];
}

- (void) playRomatePause
{
    [appDelegate.player pause];
}

- (void) playRomate
{
    [appDelegate.player play];
}

- (void) playPrevSong
{
    if ( appDelegate.currentSongIndex == 0 ) {
        NSLog(@"第一首");
        _btnPrevSong.enabled = YES;
    }
    else if( appDelegate.currentSongIndex > 0 ){
        appDelegate.currentSongIndex --;
        appDelegate.currentSong = [appDelegate.playList objectAtIndex:appDelegate.currentSongIndex];
        [appDelegate.player setContentURL:[NSURL URLWithString:appDelegate.currentSong.url]];
        [appDelegate.player play];
        [self refreshUI];
        _btnPrevSong.enabled = YES;
    }
}

- (void) playNextSong
{
    @try {
        if( [appDelegate.playList count] == 0 ){
            _btnNextSong.enabled = YES;
            return;
        }
        
        if ( appDelegate.currentSongIndex == [appDelegate.playList count] - 1 ) {
            [networkManager loadPlaylistwithType:@"s"];
        }
        else{
            appDelegate.currentSongIndex ++;
            appDelegate.currentSong = [appDelegate.playList objectAtIndex:appDelegate.currentSongIndex];
            [appDelegate.player setContentURL:[NSURL URLWithString:appDelegate.currentSong.url]];
            [appDelegate.player play];
            [self refreshUI];
            _btnNextSong.enabled = YES;
        }
    }
    @catch (NSException *exception) {
    }
}

- (void) moviePlayerLoadStateDidChange
{
    switch (appDelegate.player.loadState) {
            
        case MPMovieLoadStatePlayable:{
            _btnPlay.selected = YES;
            [appDelegate.player play];
        }
            break;
            
        case MPMovieLoadStatePlaythroughOK:{
            _btnPlay.selected = YES;
            [appDelegate.player play];
        }
            break;
            
        case MPMovieLoadStateStalled:{
            _btnPlay.selected = NO;
            [appDelegate.player pause];
        }
            break;
            
        case MPMovieLoadStateUnknown:{
            
        }
            break;
            
        default:
            break;
    }
}

- (void) on_left_click
{
    
}

- (void) on_right_click:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"下载这首歌"
                     image:[UIImage imageNamed:@"download"]
                    target:self
                    action:@selector(downloadSong:)],
      
      [KxMenuItem menuItem:@"标记为喜欢"
                     image:[UIImage imageNamed:@"red_heart"]
                    target:self
                    action:@selector(loveSongItem:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentLeft;
    
    OptionalConfiguration options = {
        9,
        7,
        5,
        25,
        6.5,
        true,
        false,
        true,
        false,
        {0, 0, 0},
        {1, 1, 1}
    };
    
    CGRect rect = CGRectMake(sender.frame.origin.x, 34, sender.frame.size.width, sender.frame.size.height);
    [KxMenu showMenuInView:self.view
                  fromRect:rect
                 menuItems:menuItems
               withOptions:options];
}

- (void) downloadSong:(id)sender
{
    [self.view makeToast:@"下载" duration:2.0 position:CSToastPositionCenter];
}

- (void) loveSongItem:(id)sender
{
    [self.view makeToast:@"喜欢" duration:2.0 position:CSToastPositionCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
