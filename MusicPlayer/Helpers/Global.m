//
//  Global.m
//  Anyis
//
//  Created by Jerry Chen on 15/7/12.
//  Copyright (c) 2015年 Jerry Chen. All rights reserved.
//

#import "Global.h"


static Global *_mainconsole;

@interface Global()

@property (nonatomic,weak) HomePageMainViewController       *home;

@end

@implementation Global


+ (Global *)GlobalSingleton
{
    if (!_mainconsole) {
        _mainconsole = [[Global alloc] init];
        
    }
    return _mainconsole;
}

- (void) set_obj_home:(HomePageMainViewController *) obj
{
    _home = obj;
}

- (HomePageMainViewController *) get_obj_home
{
    return _home;
}
@end
