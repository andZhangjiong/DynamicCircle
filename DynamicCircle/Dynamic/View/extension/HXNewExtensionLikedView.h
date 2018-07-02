//
//  HXNewExtensionLikedView.h
//  HongXun
//
//  Created by 张炯 on 2018/1/17.
//

#import <UIKit/UIKit.h>

@interface HXNewExtensionLikedView : UIView

@property (nonatomic, strong) NSAttributedString *praiseAttributed;

@property (nonatomic, copy) void(^extensionLikedViewWithUserIdBlock)(NSString *text,NSString *type);

@property (nonatomic, strong) UIView *bottonline;

@end
