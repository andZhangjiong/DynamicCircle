
//
//  HXDynamicTableView.m
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import "HXDynamicTableView.h"

#import "HXDynamicTableViewCell.h"

#import "HXDynamic.h"

static NSString *kCellKey = @"HXDynamicTableViewCell";

@interface HXDynamicTableView ()<
UITableViewDelegate,
UITableViewDataSource,
HXNewDynamicCircleCellDelegate
>

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation HXDynamicTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = BORDERToWidth_8_Color;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        [self registerClass:[HXDynamicTableViewCell class] forCellReuseIdentifier:kCellKey];
    }
    return self;
}

- (void)setupDatas:(NSMutableArray *)datas
{
    _datas = datas.mutableCopy;
    
    [self reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellKey];
    cell.model = self.datas[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXDynamic *model = self.datas[indexPath.row];
    return model.height;
}

#pragma mark - HXNewDynamicCircleCellDelegate

- (void)reloadViewWith:(NSIndexPath *)indexPath
{
    if (indexPath) {
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    }
    else {
        [self reloadData];
    }
}

- (void)dynamicCircleWebViewWithURL:(NSString *)url
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"这是一个url：%@", url]];
}

- (void)dynamicCircleWebViewWithPhone:(NSString *)phone
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"这是一个phone：%@", phone]];
}

- (void)dynamicCircleWithUserInfoUserid:(NSString *)userinfoid
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"点击了用户昵称或头像"]];
}

- (void)dynamicCircleWithDeleteDynamicID:(NSString *)dynamicID ToTableViewCell:(UITableViewCell *)cell
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"点击了删除"]];
}

- (void)dynamicCircleWithShowImageView:(NSInteger)row images:(NSArray *)images imageViews:(NSArray *)imageViews urls:(NSArray *)urls frames:(NSArray *)frames
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"点击了图片"]];
}


- (void)dynamicCirclePraiseWithModel:(HXDynamic *)model ToTableViewCell:(UITableViewCell *)cell
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"点击了点赞"]];
}

- (void)dynamicCircleCommentWithModel:(HXDynamic *)model didWithcommModel:(HXNewDynamicCircleComment *)commModel toReplyuid:(NSString *)replyuid
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"点击了评论"]];
}

@end
