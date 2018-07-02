//
//  HXDynamic.h
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRegulaURLStr  @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(m.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(((http[s]{0,1}|ftp)://|)((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"

#define kRegulaPhoneStr  @"[0-9][0-9]{4,}"

@interface HXDynamic : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userinfoid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString *imginfo;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *praisestatus;
@property (nonatomic, copy) NSString *praisestr;
@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSArray *spicpath;
@property (nonatomic, copy) NSArray *bpicpath;
@property (nonatomic, copy) NSArray *praiselist;
@property (nonatomic, copy) NSArray *webChatCommentInfoList;
@property (nonatomic, copy) NSMutableArray *commentModels;

@property (nonatomic, strong) NSMutableAttributedString *attributedText;
@property (nonatomic, strong) NSAttributedString *praiseAttributed;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat nicknameW;
@property (nonatomic, assign) CGFloat allcontentButtonH;
@property (nonatomic, assign) CGFloat addressW;
@property (nonatomic, assign) CGFloat addressH;
@property (nonatomic, assign) CGFloat timeW;
@property (nonatomic, assign) CGFloat timeH;
@property (nonatomic, assign) CGFloat width_img;
@property (nonatomic, assign) CGFloat height_img;
@property (nonatomic, assign) CGFloat spicpathHeight;
@property (nonatomic, assign) CGFloat praiseetrHeight;

@property (nonatomic, assign) CGFloat commtentTopViewH;
@property (nonatomic, assign) CGFloat commtentViewH;

@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign) BOOL isShowAllButton;
@property (nonatomic, assign) BOOL isShowAllAttributedText;//是否全部显示

@property (nonatomic, copy) NSDictionary *retunTextDic;

+ (NSMutableArray *)getLocalData;

- (void)setattributedTextWithHeight:(CGFloat)isShowAllAttributedText;


@end

@interface ZLTextPart : NSObject

/** 这段文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 是否为特殊文字 */
@property (nonatomic, assign, getter = isSpecical) BOOL special;
/** 是否为表情 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@property (nonatomic, assign, getter = isName) BOOL name;

@end

@interface ZLSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,copy)NSString *type;

@end

@interface HXNewDynamicCircleComment : NSObject

@property (nonatomic, assign) NSInteger index;
// 动态者id  名称
@property (nonatomic, copy) NSString *myuserid;
@property (nonatomic, copy) NSString *mynikename;
@property (nonatomic, copy) NSDictionary *retunTextDic;

@property (nonatomic, strong) NSMutableAttributedString *commtentAttributedString;

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *allcontent;

@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *pubdate;

@property (nonatomic, copy) NSString *replynickname;
@property (nonatomic, copy) NSString *replyuid;
@property (nonatomic, copy) NSString *webchatid;

@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *sexImageName;
@property (nonatomic, copy) NSString *userinfoid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *grade;


@property (nonatomic, assign) CGFloat height;

- (void)setUpCommtentFrame;



@end
