//
//  QQGroup.m
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 LR. All rights reserved.
//

#import "QQGroup.h"
#import "QQFriend.h"

@implementation QQGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.online = [dict[@"online"] intValue];
        NSArray *array = dict[@"friends"];
        //遍历好友数组里面的字典,并且转换为好友模型保存到数组中
        NSMutableArray *farray = [NSMutableArray array];
        for (NSDictionary *fdict in array) {
            QQFriend *friend = [QQFriend friendWithDict:fdict];
            [farray addObject:friend];
        }
        self.friendsArray = farray;
        self.isShow = NO;
    }
    return self;
}


+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
