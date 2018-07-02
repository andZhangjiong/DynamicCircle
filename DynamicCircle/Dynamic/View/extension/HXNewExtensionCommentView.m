//
//  HXNewExtensionCommentView.m
//  HongXun
//
//  Created by 张炯 on 2018/1/18.
//

#import "HXNewExtensionCommentView.h"
#import "HXNewExtensionCommentCell.h"

#import "HXDynamic.h"

static NSString *const kReuseIdentifier = @"HXNewExtensionCommentCell";

@interface HXNewExtensionCommentView ()<UITableViewDelegate,UITableViewDataSource,HXNewExtensionCommentCellDelegate>



@property (nonatomic, strong) HXNewExtensionLikedView *likedView;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation HXNewExtensionCommentView

- (instancetype)init
{
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    [self.tableView registerClass:[HXNewExtensionCommentCell class] forCellReuseIdentifier:kReuseIdentifier];
    
    self.tableView.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);
}

- (void)setModel:(HXDynamic *)model
{
    _model = model;
    if (!model) {
        return;
    }
    if (model.praiseetrHeight) {
        self.likedView.frame = CGRectMake(0, 0, WIDTH_SCREEN-90, model.praiseetrHeight);
        self.likedView.praiseAttributed = model.praiseAttributed;
        [self.tableView setTableHeaderView:self.likedView];
        _topView = _likedView;
    }
    else {
        [self.tableView setTableHeaderView:nil];
    }
    
    [self.tableView reloadData];
}

- (void)extensionLikedViewWithUserName:(NSString *)nickname ToType:(NSString *)type
{
    for (NSDictionary *dict in _model.praiselist) {
        if ([dict[@"nickname"] isEqualToString:nickname]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(newExtensionCommentViewtextWithUserId:)]) {
                [self.delegate newExtensionCommentViewtextWithUserId:dict[@"id"]];
            }
        }
    }
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.commentModels.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *keyHead = @"keyHead";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:keyHead];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:keyHead];
        UIView *backView = [[UIView alloc] init];
        [headerView addSubview:backView];
        
        backView.backgroundColor = BORDERToWidth_8_Color;
        backView.sd_layout
        .topSpaceToView(headerView, 0)
        .leftSpaceToView(headerView, 0)
        .rightSpaceToView(headerView, 0)
        .bottomSpaceToView(headerView, 0);
        
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.model.commentModels;
    HXNewExtensionCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    cell.model = array[indexPath.row];
    cell.delegate = self;
    
//    HXWeakSelf(self);
//    [cell setTextWithBlock:^(NSString *text,NSString *type) {
//        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(newExtensionCommentViewtextWithAction:toType:)]) {
//            [weakself.delegate newExtensionCommentViewtextWithAction:text toType:type];
//        }
//    }];
//
//    HXWeakSelf(cell);
//    [cell setTextEvenTochWithBlock:^(HXNewDynamicCircleComment *model) {
//
//        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(newExtensionCommentViewDidSelectRowAtView:)]) {
//            [weakself.delegate newExtensionCommentViewDidSelectRowAtView:weakcell];
//        }
//
//
//        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(newExtensionCommentViewDidSelectRowAtModel:)]) {
//            [weakself.delegate newExtensionCommentViewDidSelectRowAtModel:model];
//        }
//    }];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *keyHead = @"keyFooter";
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:keyHead];
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:keyHead];
        UIView *backView = [[UIView alloc] init];
        [footerView addSubview:backView];
        
        backView.backgroundColor = BORDERToWidth_8_Color;
        backView.sd_layout
        .topSpaceToView(footerView, 0)
        .leftSpaceToView(footerView, 0)
        .rightSpaceToView(footerView, 0)
        .bottomSpaceToView(footerView, 0);
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.model.commentModels.count) {
        return 3;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.model.commentModels.count) {
        return 3;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.model.commentModels;
    HXNewDynamicCircleComment *model = array[indexPath.row];
    return model.height;
    return 0;
}

#pragma mark - HXNewExtensionCommentCellDelegate
- (void)cellDidSelectWithText:(NSString *)text type:(NSString *)type
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newExtensionCommentViewtextWithAction:toType:)]) {
        [self.delegate newExtensionCommentViewtextWithAction:text toType:type];
    }
}

- (void)cellTextEvenTochWithModel:(HXNewDynamicCircleComment *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newExtensionCommentViewDidSelectRowAtModel:)]) {
        [self.delegate newExtensionCommentViewDidSelectRowAtModel:model];
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = BORDERToWidth_8_Color;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [self addSubview:_tableView];
        
        _tableView.layer.cornerRadius = 4;
        _tableView.layer.masksToBounds = YES;
    }
    return _tableView;
}

- (HXNewExtensionLikedView *)likedView
{
    if (!_likedView) {
        _likedView = [HXNewExtensionLikedView new];
        HXWeakSelf(self);
        [_likedView setExtensionLikedViewWithUserIdBlock:^(NSString *text,NSString *type) {
            [weakself extensionLikedViewWithUserName:text ToType:type];
        }];
    }
    return _likedView;
}

@end
