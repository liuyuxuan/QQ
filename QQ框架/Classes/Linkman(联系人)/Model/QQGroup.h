//
//  QQGroup.h
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQGroup : NSObject

@property (nonatomic,copy) NSString *name;  /**<  组名字*/
@property (nonatomic,copy) NSArray *friendsArray;   /**<  好友数组*/
@property (nonatomic,assign) int online;    /**<  在线人数*/
@property (nonatomic,assign) BOOL isShow;   /**<  是否显示好友*/

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end
