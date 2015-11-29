//
//  MessageCell.m
//  QQ
//
//  Created by yx on 15/8/26.
//  Copyright (c) 2015年 yx. All rights reserved.
//

#import "MessageCell.h"
#import "MessageCellFrame.h"
#import "Message.h"
@implementation MessageCell
{
    UIImageView *_icon; /**<  头像控件 */
    UIButton *_content; /**<  正文控件 */
    UIButton *_time; /**<  时间控件 */
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //时间
        _time = [[UIButton alloc]init];
        _time.enabled = NO;
        [self.contentView addSubview:_time];
        _time.titleLabel.font = kTimeFont;
        [_time setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_time setBackgroundImage:[self imageNamed:@"chat_timeline_bg.png" leftScale:0.5 topScale:0.7] forState:UIControlStateNormal];
        //头像
        _icon = [[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        //正文
        _content = [[UIButton alloc]init];
        _content.titleLabel.font = kContentFont;
        _content.titleLabel.numberOfLines = 0;
        [_content setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_content];
    }
    return self;
}

- (void)setMessagecellframe:(MessageCellFrame *)messagecellframe
{
    _messagecellframe = messagecellframe;
    [self addDate];
    [self setFrame];
}
        //添加数据
- (void)addDate
{
    Message *message = _messagecellframe.message;
    _icon.image = [UIImage imageNamed:message.icon];
    [_time setTitle:message.time forState:UIControlStateNormal];
    [_content setTitle:message.content forState:UIControlStateNormal];
    
    NSString *normal = nil,*focused = nil;
    if(message.type == kMessageTypeMe)
    {
        normal = @"chatto_bg_normal.png";
        focused = @"chatto_bg_focused.png";
                _content.contentEdgeInsets = UIEdgeInsetsMake(kContentHTopMargin, kContentWMinMargin, kContentHBottomMargin, kContentWMaxMargin);
    }else
    {
        normal = @"chatfrom_bg_normal.png";
        
        focused = @"chatfrom_bg_focused.png";
          _content.contentEdgeInsets = UIEdgeInsetsMake(kContentHTopMargin, kContentWMaxMargin, kContentHBottomMargin, kContentWMinMargin);
    }
    [_content setBackgroundImage:[self imageNamed:normal leftScale:0.5 topScale:0.7] forState:UIControlStateNormal];
    [_content setBackgroundImage:[self imageNamed:focused leftScale:0.5 topScale:0.7] forState:UIControlStateHighlighted];
}
        //添加frame
- (void)setFrame{
    _icon.frame = _messagecellframe.iconF;
    _content.frame = _messagecellframe.contentF;
    _time.frame = _messagecellframe.timeF;
}

- (UIImage *)imageNamed:(NSString *)imageNamed leftScale:(CGFloat)left topScale:(CGFloat)top
{   //创建一个图片
    UIImage *image = [UIImage imageNamed:imageNamed];
    //保护拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
    return image;
}
@end
