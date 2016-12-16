//
//  Global.h
//  Anyis
//
//  Created by Jerry Chen on 15/7/12.
//  Copyright (c) 2015年 Jerry Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageMainViewController.h"

@interface Global : NSObject

+ (Global *)GlobalSingleton;

- (void) set_obj_home:(HomePageMainViewController *) obj;
- (HomePageMainViewController *) get_obj_home;

@end
