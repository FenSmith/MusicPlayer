//
//  YTZPublic_Macro.h
//  FireflyFramework
//
//  Created by weikun on 15/10/26.
//  Copyright © 2015年 cmbc. All rights reserved.
//

#ifndef YTZPublic_Macro_h
#define YTZPublic_Macro_h

//typedef NS_OPTIONS(NSUInteger, PLAY_WAY) {
//    
//    type_next_song,
//    type_prev_song,
//    
//};

//APP代理（可以在这个代理类中声明一些所谓的全局变量）
#define APPDELEGATE (YTZAppDelegate *)[[UIApplication sharedApplication]delegate]

//NSUserDefaults存储数据的key
#define KEY_NSUserDefaults_UserPhoneNumber @"phoneNumber"         //用户登录手机号码
#define KEY_NSUserDefaults_UserPwd @"passWord"                    //用户登录密码
#define KEY_NSUserDefaults_HasSavePwd @"hasSavePassWord"          //标识用户密码是否已经添加到钥匙串保存

// 当前屏幕 width
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

// 当前屏幕 height
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//十六进制颜色,如UI标志 #ffa748,使用方式UIColorFromHex(0xffa748),将#替换为0x
#define UIColorFromHex(HexColor) [UIColor colorWithRed:((float)((HexColor & 0xFF0000) >> 16))/255.0 green:((float)((HexColor & 0xFF00) >> 8))/255.0 blue:((float)(HexColor & 0xFF))/255.0 alpha:1.0]
#define UIColorFromHexA(HexColor,A) [UIColor colorWithRed:((float)((HexColor & 0xFF0000) >> 16))/255.0 green:((float)((HexColor & 0xFF00) >> 8))/255.0 blue:((float)(HexColor & 0xFF))/255.0 alpha:A]

//十进制颜色
#define UIColorFromRGBA(R,G,B,A) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:A]
#define UIColorFromRGB(R,G,B) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:1.0]

/* 风格标准定义，以YTZStyle开头*/

//导航栏背景色
#define YTZStyle_Color_NavBar_BGColor UIColorFromHex(0xf7f7f7)

//导航栏标题色
#define YTZStyle_Color_NavBar_TitleColor UIColorFromHex(0x3d4245)

//文字正常黑色
#define YTZStyle_Color_Text_Black UIColorFromHex(0x3d4245)

//文字灰色
#define YTZStyle_Color_Text_Gray UIColorFromHex(0x999999)

//页面背景色
#define YTZStyle_Color_Content_BGColor UIColorFromHex(0xf5f5f9)

//橙色
#define YTZStyle_Color_Orange UIColorFromHex(0xf87137)

//红色
#define YTZStyle_Color_Red UIColorFromHex(0xf26666)

//蓝色
#define YTZStyle_Color_Blue UIColorFromHex(0x1caef6)

//绿色
#define YTZStyle_Color_Green UIColorFromHex(0x1bce8d)

//导航栏主标题文字大小
#define YTZStyle_FontSize_NavBar_TitleSize 18.0

//导航栏副标题文字大小
#define YTZStyle_FontSize_NavBar_SubTitleSize 15.0

//标准字大小
#define YTZStyle_FontSize_StandardTextSize 15.0

//输入框提示语字体大小
#define YTZStyle_FontSize_TipsTextSize 16.0

//所有主按钮文字大小
#define YTZStyle_FontSize_ButtonTextSize 18.0

//整体布局左右的间距、两个输入框之间的间距、按钮与按钮或其他空间之间的间距都统一
#define YTZStyle_SpacingSize 22.0

#define YTZStyle_BottomSpacingSize 30.0

#define YTZStyle_CenterSpacingSize 20.0

#define YTZStyle_LeftSpacingSize 15.0

//未激活的主按钮的背景颜色
#define YTZStyle_Color_Unactivated_Button_BGColor UIColorFromHex(0xebebf0)

//未激活的主按钮的文字颜色
#define YTZStyle_Color_Unactivated_Button_TitleColor UIColorFromHex(0xd2d2d2)

//tableView分割线颜色
#define YTZStyle_Color_Separate_LineColor UIColorFromHex(0xe6e6e6)

#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */

//图表
#define YTZStyle_Color_Chart_GrayColor UIColorFromHex(0xc7c7cd)

/*调试模式日志输出*/
//打印日志,输出当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc]\
initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] essage:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


#endif /* YTZPublic_Macro_h */
