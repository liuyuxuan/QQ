//
//  ViewController.m
//  QQ联系人
//
//  Created by yx on 15/8/29.
//  Copyright (c) 2015年 yx. All rights reserved.
//

#import "ViewController.h"
#import "QQGroup.h"
#import "QQFriend.h"
#import "QQHeader.h"
@interface ViewController ()<QQGroupHeaderDelegate>
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableArray *headerArray;
@end

@implementation ViewController

#pragma mark - 懒加载
- (NSMutableArray *)array {
    
    if (_array== nil) {
        _array = [NSMutableArray array];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        for (NSDictionary *dict in array) {
            QQGroup *group = [QQGroup groupWithDict:dict];
            [_array addObject:group];
        }
        
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _headerArray = [NSMutableArray array];
    self.tableView.sectionHeaderHeight = 44;
}


#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QQGroup *group = _array[section];
    
    return   group.isShow?group.friendsArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建一个cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //获取模型数据
    //1.获取当前组
    QQGroup *group = _array[indexPath.section];
    //2.获取好友
    QQFriend *friend = group.friendsArray[indexPath.row];
    //3.加载模型数据
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.intro;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [_array[section] name];
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_headerArray.count <= section) {
        QQHeader *header = [QQHeader header];
        header.gp = _array[section];
        header.delegate = self;
        [_headerArray addObject:header];
        return header;
    }else
    {
        return _headerArray[section];
    }
}

#pragma mark - QQGroup的代理方法,点击头部
- (void)groupHeaderClick:(QQHeader *)header
{
    //刷新表格
    [self.tableView reloadData];
}

@end
