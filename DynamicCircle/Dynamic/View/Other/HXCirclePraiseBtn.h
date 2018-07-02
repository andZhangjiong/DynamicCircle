//
//  HXCirclePraiseBtn.h
//  HongXun
//
//  Created by 赵阳 on 2018/3/28.
//

#import <UIKit/UIKit.h>

@interface HXCirclePraiseBtn : UIButton
@property (nonatomic,copy) void(^explodeStopBlock)(void);
-(void)animation;
@end
