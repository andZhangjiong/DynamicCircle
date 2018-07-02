//
//  HXNewExtensionCommentCell.h
//  HongXun
//
//  Created by 张炯 on 2018/1/17.
//

#import <UIKit/UIKit.h>
#import "HXDynamic.h"

@protocol HXNewExtensionCommentCellDelegate <NSObject>

- (void)cellDidSelectWithText:(NSString *)text type:(NSString *)type;

- (void)cellTextEvenTochWithModel:(HXNewDynamicCircleComment *)model;


@end


@interface HXNewExtensionCommentCell : UITableViewCell

@property (nonatomic, strong) HXNewDynamicCircleComment *model;

@property (nonatomic, weak) id <HXNewExtensionCommentCellDelegate> delegate;

@property (nonatomic, copy) void(^textWithBlock)(NSString *text,NSString *type);

@property (nonatomic, copy) void(^textEvenTochWithBlock)(HXNewDynamicCircleComment *model);

@end
