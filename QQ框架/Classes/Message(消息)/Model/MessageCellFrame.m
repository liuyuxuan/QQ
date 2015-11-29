

// cell的边框
#define kCellBorderW 10
#define kIconWH 40
// 内容最大宽度
#define kContentMaxW 200

#import "MessageCellFrame.h"
#import "Message.h"

@implementation MessageCellFrame
- (void)setMessage:(Message *)message
{
    _message = message;
    
    // 0.获得屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 1.时间
    if (message.showsTime) { // 显示时间
        CGFloat timeY = kCellBorderW;
        CGSize timeSize = [message.time sizeWithAttributes:@{NSAttachmentAttributeName:kTimeFont}];
        CGFloat timeW = timeSize.width + 20;
        CGFloat timeX = (screenW - timeW) * 0.5;
        CGFloat timeH = timeSize.height + 10;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 2.头像
    CGFloat iconX = kCellBorderW;
    
    if (message.type == kMessageTypeMe) { // 自己发的，头像排右边
        iconX = screenW - kIconWH - kCellBorderW;
    }
    
    CGFloat iconY = CGRectGetMaxY(_timeF) + kCellBorderW;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    // 3.内容
    CGFloat contentX = CGRectGetMaxX(_iconF) + kCellBorderW;
    
    CGFloat contentY = iconY;
    
    
    CGSize contentSize = [message.content sizeWithFont:kContentFont constrainedToSize:CGSizeMake(kContentMaxW, MAXFLOAT)];
    CGFloat contentW = contentSize.width + kContentWMinMargin + kContentWMaxMargin;
    CGFloat contentH = contentSize.height + kContentHTopMargin + kContentHBottomMargin;
    
    if (message.type == kMessageTypeMe) { // 自己发的，内容排头像左边
        contentX = _iconF.origin.x - kCellBorderW - contentW;
    }
    
    _contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    // 4.cell的高度
    CGFloat max = MAX(CGRectGetMaxY(_iconF), CGRectGetMaxY(_contentF));
    _cellHeight = max + kCellBorderW;
}
@end
