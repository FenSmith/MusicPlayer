//
//  SongInfo.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/22/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "SongInfo.h"

@implementation SongInfo
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        self.artist = [dictionary objectForKey:@"artist"];
        self.title = [dictionary objectForKey:@"title"];
        self.url = [dictionary objectForKey:@"url"];
        self.picture = [dictionary objectForKey:@"picture"];
        self.length = [dictionary objectForKey:@"length"];
        self.like = [dictionary objectForKey:@"like"];
        self.sid = [dictionary objectForKey:@"sid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.artist forKey:@"artist"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.picture forKey:@"picture"];
    [aCoder encodeObject:self.length forKey:@"length"];
    [aCoder encodeObject:self.like forKey:@"like"];
    [aCoder encodeObject:self.sid forKey:@"sid"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.artist = [aDecoder decodeObjectForKey:@"artist"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.picture = [aDecoder decodeObjectForKey:@"picture"];
        self.length = [aDecoder decodeObjectForKey:@"length"];
        self.like = [aDecoder decodeObjectForKey:@"like"];
        self.sid = [aDecoder decodeObjectForKey:@"sid"];
    }
    return self;
}
                           
@end
