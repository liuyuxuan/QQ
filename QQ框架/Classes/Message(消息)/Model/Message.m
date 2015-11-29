//
//  Message.m
//  QQ
//
//  Created by yx on 15/8/26.
//  Copyright (c) 2015年 yx. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    // 字典转模型
    Message *message = [[Message alloc]init];
    message.icon = dict[@"icon"];
    message.content = dict[@"content"];
    message.time = dict[@"time"];
    message.type = [dict[@"type"] intValue];
    return message;
}
@end
