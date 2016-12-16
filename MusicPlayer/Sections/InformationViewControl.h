//
//  InformationViewControl.h
//  MusicPlayer
//
//  Created by tangwei on 16/1/15.
//  Copyright © 2016年 tangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationViewControl : UIViewController
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewInLandscapeOffsetCenterX;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewInPortraitOffsetCenterX;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewScaleValue;

@end
