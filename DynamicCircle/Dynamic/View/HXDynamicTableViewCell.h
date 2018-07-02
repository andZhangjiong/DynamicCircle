//
//  HXDynamicTableViewCell.h
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXDynamic;
@class HXNewDynamicCircleComment;

@protocol HXNewDynamicCircleCellDelegate <NSObject>

// 按户型
- (void)reloadViewWith:(NSIndexPath *)indexPath;

- (void)dynamicCircleTouchBegan;

- (void)dynamicCircleWithUserInfoUserid:(NSString *)userinfoid;

- (void)dynamicCircleWebViewWithURL:(NSString *)url;

- (void)dynamicCircleWebViewWithPhone:(NSString *)phone;

- (void)dynamicCircleAddressWithLocation:(NSString *)location;


- (void)dynamicCircleWithDeleteDynamicID:(NSString *)dynamicID ToTableViewCell:(UITableViewCell *)cell;


- (void)dynamicCircleWithShowImageView:(NSInteger)row images:(NSArray *)images imageViews:(NSArray *)imageViews urls:(NSArray *)urls frames:(NSArray *)frames;


- (void)dynamicCirclePraiseWithModel:(HXDynamic *)model ToTableViewCell:(UITableViewCell *)cell;


- (void)dynamicCircleCommentWithModel:(HXDynamic *)model didWithcommModel:(HXNewDynamicCircleComment *)commModel toReplyuid:(NSString *)replyuid;

//- (void)dynamicCircleCommentWithActionView:(UIView *)view;


@end

@interface HXDynamicTableViewCell : UITableViewCell

@property (nonatomic, strong) HXDynamic *model;

@property (nonatomic, weak) id <HXNewDynamicCircleCellDelegate>delegate;


@end
