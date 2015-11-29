//
//  QQHeader.h
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 LR. All rights reserved.
//
#import <Foundation/Foundation.h>
@class QQHeader;
@protocol QQGroupHeaderDelegate <NSObject>   //代理协议
@optional
- (void)groupHeaderClick:(QQHeader *)header;       //头部被点击时候调用方法

@end

#import <UIKit/UIKit.h>
@class QQGroup;
@interface QQHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (nonatomic,strong) QQGroup *gp;   /**<  组*/
@property (nonatomic,weak) id<QQGroupHeaderDelegate> delegate;   /**<  代理*/


- (IBAction)fbutton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *friendscount;
+ (instancetype)header;
@end
