//
//  QQFriend.m
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 LR. All rights reserved.
//

#import "QQFriend.h"

@implementation QQFriend

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        self.vip = [dict[@"vip"] boolValue];
        self.intro = dict[@"intro"];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
