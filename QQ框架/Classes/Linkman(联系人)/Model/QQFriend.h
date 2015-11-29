//
//  QQFriend.h
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQFriend : NSObject

@property (nonatomic,copy) NSString *name;   /**<  好友名字*/
@property (nonatomic,copy) NSString *icon;   /**<  头像*/
@property (nonatomic,copy) NSString *intro;   /**<  个性签名*/
@property (nonatomic,assign) BOOL vip;  /**<  会员*/

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;
@end
