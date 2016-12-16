//
//  UtilHelper.m
//  MusicPlayer
//
//  Created by tangwei on 16/1/12.
//  Copyright © 2016年 tangwei. All rights reserved.
//
#import "sys/utsname.h"
#import "UtilHelper.h"

@implementation UtilHelper

+ (NSString *)getCurrentDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4 type";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 type";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 type";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5 type";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5 type";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5 type";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5 type";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6p type";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 type";
    if ([platform isEqualToString:@"iPhone7,3"]) return @"iPhone 6p type";
    if ([platform isEqualToString:@"iPhone7,4"]) return @"iPhone 6 type";
    
    return @"other type";
}

@end
