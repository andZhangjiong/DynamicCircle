//
//  HXDynamicCircleImageView.h
//  HongXun
//
//  Created by 张炯 on 2017/11/28.
//

#import <UIKit/UIKit.h>

@interface HXDynamicCircleImageView : UIView

@property (nonatomic, copy) NSArray *spicpaths;
@property (nonatomic, copy) NSArray *bpicpaths;
@property (nonatomic, assign) CGFloat one_img_width;
@property (nonatomic, assign) CGFloat one_img_height;

@property (nonatomic, copy) void (^dynamicCircleImageViewWithBlock)(NSInteger row ,NSArray *images,NSArray *imageViews ,NSArray *urls, NSArray *frames);


//@property (nonatomic, weak) id <HXDynamicCircleDelegate> delegate;

- (void)buttonClicked:(UITapGestureRecognizer *)tap;

@end
