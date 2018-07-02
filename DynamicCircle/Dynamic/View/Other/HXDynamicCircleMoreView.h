//
//  HXDynamicCircleMoreView.h
//  HongXun
//
//  Created by 张炯 on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface HXDynamicCircleMoreView : UIView

@property (nonatomic, copy) void (^dynamicCircleMoreViewWithBlocl)(NSInteger row);
@property (nonatomic,copy) void(^priseExplodeStopCallBack)(void);

- (void)showViewFrame:(CGPoint)point;

- (void)backViewAction;

- (void)likeSelected:(BOOL)selected;

-(void)startAnimation;

@end
