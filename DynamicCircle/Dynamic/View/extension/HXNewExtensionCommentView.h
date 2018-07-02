//
//  HXNewExtensionCommentView.h
//  HongXun
//
//  Created by 张炯 on 2018/1/18.
//

#import <UIKit/UIKit.h>
#import "HXNewExtensionLikedView.h"

@class HXDynamic;
@class HXNewDynamicCircleComment;

@protocol HXNewExtensionCommentViewDelegate <NSObject>

- (void)newExtensionCommentViewtextWithAction:(NSString *)text toType:(NSString *)type;

- (void)newExtensionCommentViewtextWithUserId:(NSString *)text;

- (void)newExtensionCommentViewDidSelectRowAtModel:(HXNewDynamicCircleComment *)model;

- (void)newExtensionCommentViewDidSelectRowAtView:(UIView *)view;

@end

@interface HXNewExtensionCommentView : UIView

@property (nonatomic, strong) HXDynamic *model;

@property (nonatomic, weak) HXNewExtensionLikedView *topView;

@property (nonatomic, weak) id<HXNewExtensionCommentViewDelegate> delegate;

@end
