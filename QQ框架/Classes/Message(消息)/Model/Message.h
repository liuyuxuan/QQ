//
//  Message.h
//  QQ
//
//  Created by yx on 15/8/26.
//  Copyright (c) 2015年 yx. All rights reserved.
//
#define kTimeFont [UIFont systemFontOfSize:13]
#define kContentFont [UIFont systemFontOfSize:15]
// 按钮左右间距
#define kContentWMinMargin 15
#define kContentWMaxMargin 25

// 按钮上下间距
#define kContentHTopMargin 10
#define kContentHBottomMargin 15

#import <Foundation/Foundation.h>

typedef enum {
    kMessageTypeMe,
    kMessageTypeOther
} MessageType;

@interface Message : NSObject
@property (nonatomic,copy) NSString *icon; /**<  头像 */
@property (nonatomic,copy) NSString *content; /**<  正文 */
@property (nonatomic,copy) NSString *time; /**<  时间 */
@property (nonatomic,assign) MessageType type; /**<  信息类型 */
@property (nonatomic,assign) BOOL showsTime; /**<  是否显示时间 */
+ (instancetype)messageWithDict:(NSDictionary *)dict; 
@end
