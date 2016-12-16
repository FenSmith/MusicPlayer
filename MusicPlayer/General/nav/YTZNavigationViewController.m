//
//  YTZNavigationViewController.m
//  FireflyFramework
//
//  Created by weikun on 15/10/28.
//  Copyright © 2015年 cmbc. All rights reserved.
//

#import "YTZNavigationViewController.h"

@interface YTZNavigationViewController ()

@end

@implementation YTZNavigationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setTintColor:[UIColor whiteColor]];
    self.navigationBar.barTintColor = YTZStyle_Color_NavBar_BGColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:YTZStyle_Color_NavBar_TitleColor};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;//push新页面后隐藏底部菜单栏
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 12)];//调整返回箭头位置稍向左12个单位
        [btn setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark 添加右滑手势
- (void)addSwipeRecognizer
{
    // 初始化手势并添加执行方法
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(back)];
    // 手势方向
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    swipeRecognizer.delegate = self;
    
    // 响应的手指数
    swipeRecognizer.numberOfTouchesRequired = 1;
    
    // 添加手势
    [[self view] addGestureRecognizer:swipeRecognizer];
}

#pragma mark 返回上一级
- (void)back{
    self.hidesBottomBarWhenPushed = NO;
    [self popViewControllerAnimated:YES];
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
