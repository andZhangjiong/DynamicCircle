//
//  HXLabel.h
//  HongXun
//
//  Created by 张炯 on 2018/1/18.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol HXLabelDelegate <NSObject>

- (void)textWithAction:(NSString *)text toType:(NSString *)type;



@end

@interface HXLabel : UITextView

@property (nonatomic, weak) id <HXLabelDelegate> dataDelegate;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) void(^textEvenTochWithBlock)(void);
@property (nonatomic, copy) void(^textLongPongPressGestureRecognizerTochWithBlock)(void);

@end
