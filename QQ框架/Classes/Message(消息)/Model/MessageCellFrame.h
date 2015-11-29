//
//  MessageCellFrame.h
//  QQ
//
//  Created by yx on 15/8/26.
//  Copyright (c) 2015年 yx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;
@interface MessageCellFrame : NSObject

@property (nonatomic,assign,readonly) CGRect iconF;  /**<  头像frame */
@property (nonatomic,assign,readonly) CGRect contentF;  /**<  正文frame */
@property (nonatomic,assign,readonly) CGRect timeF;  /**<  时间frame */
@property (nonatomic,assign,readonly) CGFloat cellHeight; /**<  cell的高度 */
@property (nonatomic,strong) Message *message;  /**<  信息模型 */
@end
