//
//  InformationViewControl.m
//  MusicPlayer
//
//  Created by tangwei on 16/1/15.
//  Copyright © 2016年 tangwei. All rights reserved.
//

#import "InformationViewControl.h"

@interface InformationViewControl ()
{
    UITableView     *_tableView;
}

@end

@implementation InformationViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YTZStyle_Color_Content_BGColor;
    
    [self init_data];
    [self init_ui];
}

- (void) init_data
{
    _contentViewInLandscapeOffsetCenterX = 30.f;
    _contentViewInPortraitOffsetCenterX  = 30.f;
    _contentViewScaleValue = 0.7f;
}

- (void) init_ui
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = YTZStyle_Color_Content_BGColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@([self get_view_width]));
    }];
}

- (int) get_view_width
{
    int center_x = 0;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        center_x = (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) ? self.contentViewInLandscapeOffsetCenterX + CGRectGetWidth(self.view.frame) : self.contentViewInPortraitOffsetCenterX + CGRectGetWidth(self.view.frame));
    } else {
        center_x = (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) ? self.contentViewInLandscapeOffsetCenterX + CGRectGetHeight(self.view.frame) : self.contentViewInPortraitOffsetCenterX + CGRectGetWidth(self.view.frame));
    }
    
    return center_x - ScreenWidth * 0.7f / 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int h = 50;
    if( indexPath.row == 0 || indexPath.row == 5 ){
        return (ScreenHeight - h * 4) / 2;
    }
    
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = YTZStyle_Color_Content_BGColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch ( indexPath.row ) {
        case 0:{
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
            break;
            
        case 1:{
            UIView *line1 = [UIView new];
            line1.backgroundColor = YTZStyle_Color_Separate_LineColor;
            [cell addSubview:line1];
            
            UILabel *title = [UILabel new];
            title.font = [UIFont systemFontOfSize:14.0];
            title.textColor =  YTZStyle_Color_Text_Black;
            title.textAlignment = NSTextAlignmentLeft;
            title.text = @"我的音乐";
            [cell addSubview:title];
            
            UIView *line2 = [UIView new];
            line2.backgroundColor = YTZStyle_Color_Separate_LineColor;
            [cell addSubview:line2];
            
            [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top);
                make.left.equalTo(cell.mas_left);
                make.right.equalTo(cell.mas_right);
                make.height.equalTo(@1);
            }];
            
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
            }];
            
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.mas_bottom);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
                make.right.equalTo(cell.mas_right);
                make.height.equalTo(@1);
            }];
            
            return cell;
        }
            break;
            
        case 2:{
            UILabel *title = [UILabel new];
            title.font = [UIFont systemFontOfSize:14.0];
            title.textColor =  YTZStyle_Color_Text_Black;
            title.textAlignment = NSTextAlignmentLeft;
            title.text = @"我喜欢的音乐";
            [cell addSubview:title];
            
            UIView *line2 = [UIView new];
            line2.backgroundColor = YTZStyle_Color_Separate_LineColor;
            [cell addSubview:line2];
            
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
            }];
            
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.mas_bottom);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
                make.right.equalTo(cell.mas_right);
                make.height.equalTo(@1);
            }];
            
            return cell;
        }
            break;
            
        case 3:{
            UILabel *title = [UILabel new];
            title.font = [UIFont systemFontOfSize:14.0];
            title.textColor =  YTZStyle_Color_Text_Black;
            title.textAlignment = NSTextAlignmentLeft;
            title.text = @"最近播放";
            [cell addSubview:title];
            
            UIView *line2 = [UIView new];
            line2.backgroundColor = YTZStyle_Color_Separate_LineColor;
            [cell addSubview:line2];
            
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
            }];
            
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.mas_bottom);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
                make.right.equalTo(cell.mas_right);
                make.height.equalTo(@1);
            }];
            
            return cell;
        }
            break;
            
        case 4:{
            UILabel *title = [UILabel new];
            title.font = [UIFont systemFontOfSize:14.0];
            title.textColor =  YTZStyle_Color_Text_Black;
            title.textAlignment = NSTextAlignmentLeft;
            title.text = @"正在下载";
            [cell addSubview:title];
            
            UIView *line2 = [UIView new];
            line2.backgroundColor = YTZStyle_Color_Separate_LineColor;
            [cell addSubview:line2];
            
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).offset(YTZStyle_LeftSpacingSize);
            }];
            
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.mas_bottom);
                make.left.equalTo(cell.mas_left);
                make.right.equalTo(cell.mas_right);
                make.height.equalTo(@1);
            }];
            
            return cell;
        }
            break;
            
        case 5:{
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
            break;
            
        default:{
            return nil;
        }
            break;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
