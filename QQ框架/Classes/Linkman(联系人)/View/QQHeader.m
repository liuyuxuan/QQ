//
//  QQHeader.m
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 LR. All rights reserved.
//

#import "QQHeader.h"
#import "QQGroup.h"
@implementation QQHeader

- (void)setGp:(QQGroup *)gp
{
    //注意在setget方法中不能使用self.
    _gp = gp;
    [self.bt setTitle:gp.name forState:UIControlStateNormal];
    self.friendscount.text = [NSString stringWithFormat:@"%d/%lu",gp.online,gp.friendsArray.count];
}

+ (instancetype)header{
   return  [[NSBundle mainBundle] loadNibNamed:@"QQHeader" owner:nil options:nil][0];
}

- (IBAction)fbutton:(UIButton *)sender {
    _gp.isShow = !_gp.isShow;
    
    if ([_delegate respondsToSelector:@selector(groupHeaderClick:)]) {
        //调用代理方法
        [self.delegate groupHeaderClick:self];
    }
    //执行动画
    [UIView animateWithDuration:0.3 animations:^{
        //头部小图片的旋转
        if (_gp.isShow == YES) {
            //顺时针旋转90°
            _bt.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);

        }else{
            //返回初始状态
            _bt.imageView.transform = CGAffineTransformIdentity;
        }
            }];
}

#pragma mark - 当从xib中加载创建完就会被调用

-(void)awakeFromNib
{
    //中心旋转
    _bt.imageView.contentMode = UIViewContentModeCenter;
    //当图片旋转的时候不剪切
    _bt.imageView.clipsToBounds = NO;
}
@end
