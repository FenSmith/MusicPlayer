//
//  YTZTabbarViewController.m
//  FireflyFramework
//
//  Created by weikun on 15/10/28.
//  Copyright © 2015年 cmbc. All rights reserved.
//

#import "YTZTabbarViewController.h"
#import "YTZNavigationViewController.h"//自定义导航控制器
#import "HomePageMainViewController.h"
#import "PersonInfoMainViewController.h"

@interface YTZTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation YTZTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置底部菜单四个模块
    [self setNavigtaionViewControllers];
    self.delegate = self;
}

- (void)setNavigtaionViewControllers{
    
    HomePageMainViewController *homePageVC = [[HomePageMainViewController alloc]init];
    YTZNavigationViewController *homePageNavVC = [[YTZNavigationViewController alloc]
                                                  initWithRootViewController:homePageVC];
    [self setTabbarImage:@"music" WithVC:homePageVC];
    homePageVC.title = @"音乐";

    PersonInfoMainViewController *personInfoVC = [[PersonInfoMainViewController alloc]init];
    YTZNavigationViewController *personInfoNavVC = [[YTZNavigationViewController alloc]
                                                    initWithRootViewController:personInfoVC];
    [self setTabbarImage:@"user" WithVC:personInfoVC];
    personInfoVC.title = @"个人";
        
    self.viewControllers = @[homePageNavVC,personInfoNavVC];
}

//设置菜单栏点击图片
- (void)setTabbarImage:(NSString*)image WithVC:(UIViewController*)vc{
    NSString *selectedImage = [image stringByAppendingString:@"_normal"];
    NSString *normalImage = [image stringByAppendingString:@"_normal"];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:vc.title image:
                          [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:
                          [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //调整tabBarItem文字位置
    [item setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    vc.tabBarItem = item;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
