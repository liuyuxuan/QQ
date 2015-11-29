//
//  QQMessageViewController.m
//  QQ框架
//
//  Created by yx on 15/9/8.
//  Copyright (c) 2015年 yx. All rights reserved.
//

#import "QQMessageViewController.h"
#import "Message.h"
#import "MessageCell.h"
#import "MessageCellFrame.h"
#import "UIImage+Image.h"
@interface QQMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *messagesArray;
@end

@implementation QQMessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"06副本.jpg"]];
    
    //从文件总加载数据
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil]];
    _messagesArray = [NSMutableArray array];
    Message *msg = nil;
    for (NSDictionary *dict in array) {
        Message *message = [Message messageWithDict:dict];
        if ([message.time isEqual:msg.time]) {
            message.showsTime = NO;
        }else
        {
            message.showsTime = YES;
        }
        MessageCellFrame *messagecellframe = [[MessageCellFrame alloc]init];
        messagecellframe.message = message;
        [_messagesArray addObject:messagecellframe];
        msg = message;
    }
    
    //键盘的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - textfield 的代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //输入的内容
    NSString *text = textField.text;
    //创建一个消息,加载数据
    if(_messagesArray.count % 2 == 0)
    {
        [self addNewMsg:text andIcon:@"icon01.png" andType:kMessageTypeMe];
    }else
    {
        [self addNewMsg:text andIcon:@"icon02.png" andType:kMessageTypeOther];
    }
    
    //刷新数据
    [self.tableView reloadData];
    //清空文本框
    textField.text = nil;
    //获取最后一行的地址
    NSIndexPath *path = [NSIndexPath indexPathForRow:_messagesArray.count - 1 inSection:0];
    //跳转到最后一行
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return YES;
}

- (void)addNewMsg:(NSString *)text andIcon:(NSString *)icon andType:(MessageType)type
{
    //创建模型
    MessageCellFrame  *messagecellframe = [[MessageCellFrame alloc]init];
    Message *msg = [[Message alloc]init];
    
    //获取当前的时间
    NSDate *date = [NSDate date];
    //自定义时间格式
    NSDateFormatter *dft = [[NSDateFormatter alloc]init];
    dft.dateFormat = @"HH:mm";
    msg.time = [dft stringFromDate:date];
    msg.type = type;
    msg.icon = icon;
    msg.content = text;
    //获取上一条信息的时间
    MessageCellFrame *lastf = [_messagesArray lastObject];
    NSString *lastTime = lastf.message.time;
    msg.showsTime = ![msg.time isEqualToString:lastTime];
    messagecellframe.message = msg;
    //将数据加载到数组中
    [_messagesArray addObject:messagecellframe];
}

#pragma mark -- 键盘处理
//键盘弹出
- (void)keyBoardWillShow:(NSNotification *)note
{
    //获取键盘弹出时间
    CGFloat time =[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    //执行动画
    //获取键盘高度
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:time animations:^{
        //平移
        self.view.transform = CGAffineTransformMakeTranslation(0, -rect.size.height);
        
    }];
}
//键盘收回
- (void)keyBoardWillHide:(NSNotification *)note
{
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        //回到最初的状态
        self.view.transform = CGAffineTransformIdentity;
    }];
    
}
#pragma mark -- 代理方法
//开始触摸
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark -- 数据源
#pragma  mark --默认是1组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    MessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.messagecellframe = _messagesArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCellFrame *messagecellframe = _messagesArray[indexPath.row];
    return messagecellframe.cellHeight;
}


@end
