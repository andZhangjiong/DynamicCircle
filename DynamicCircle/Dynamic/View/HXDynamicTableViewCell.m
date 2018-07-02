//
//  HXDynamicTableViewCell.m
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import "HXDynamicTableViewCell.h"

#import "HXNewExtensionCommentView.h"
#import "HXDynamicCircleImageView.h"
#import <UIButton+WebCache.h>
#import "HXLabel.h"
#import "HXDynamicCircleMoreView.h"

#import "HXDynamic.h"

@interface HXDynamicTableViewCell ()<HXLabelDelegate,HXNewExtensionCommentViewDelegate>

@property (nonatomic, strong) UIButton *headImageView;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIButton *allContentButton;
@property (nonatomic, strong) UIButton *addressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIImageView *extensionTopImageView;

@property (nonatomic, strong) HXLabel *contentLabel;
@property (nonatomic, strong) HXDynamicCircleImageView *imageViewCircle;
@property (nonatomic, strong) HXNewExtensionCommentView *extensionCommentView;

@end

@implementation HXDynamicTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

/**
 * 复制
 */
- (void)WillHideMenu:(id)sender
{
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.layer.borderColor = [UIColor clearColor].CGColor;
    _contentLabel.layer.borderWidth = 1;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)copy:(UIMenuController *)menu
{
    [SVProgressHUD showErrorWithStatus:@"已复制到剪切板"];
    
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.layer.borderColor = [UIColor clearColor].CGColor;
    _contentLabel.layer.borderWidth = 1;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [HXTool generalPasteboard:self.model.content];
    });
}


//必须要有，如果要UIMenuController显示
- (BOOL)canBecomeFirstResponder
{
    return true;
}

//监听自己的定义事件，是 return YES；  否 return NO 即移除系统；
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}

/**
 * 初始化
 */
- (void)setUpView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.moreButton.hidden = NO;
    
    CGFloat margar = 18;
    self.headImageView.sd_layout
    .topSpaceToView(self, margar)
    .leftSpaceToView(self, margar)
    .widthIs(40)
    .heightIs(40);
    
    self.nameButton.sd_layout
    .topSpaceToView(self, 20)
    .leftSpaceToView(self, 70)
    .heightIs(17);
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.nameButton, 3)
    .leftSpaceToView(self, 70);
    
    self.allContentButton.sd_layout
    .topSpaceToView(self.contentLabel, 0)
    .leftEqualToView(self.contentLabel)
    .widthIs(40)
    .heightIs(20);
    
    self.imageViewCircle.sd_layout
    .leftSpaceToView(self, 70)
    .rightSpaceToView(self, 0);
    
    HXWeakSelf(self);
    [_imageViewCircle setDynamicCircleImageViewWithBlock:^(NSInteger row, NSArray *images, NSArray *imageViews, NSArray *urls, NSArray *frames) {
        if ([weakself.delegate respondsToSelector:@selector(dynamicCircleWithShowImageView:images:imageViews:urls:frames:)] && weakself.delegate) {
            [weakself.delegate dynamicCircleWithShowImageView:row images:images imageViews:imageViews urls:urls frames:frames];
        }
    }];
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.imageViewCircle, 0)
    .leftEqualToView(self.imageViewCircle);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.addressLabel, 0)
    .leftEqualToView(self.addressLabel)
    .heightIs(20);
    
    self.deleteButton.sd_layout
    .topSpaceToView(self.timeLabel, -30)
    .leftSpaceToView(self.timeLabel, 5)
    .widthIs(50)
    .heightIs(40);
    
    self.moreButton.sd_layout
    .topEqualToView(self.deleteButton)
    .rightSpaceToView(self, -3)
    .widthIs(50)
    .heightIs(40);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BORDERToWidth_Line_Color;
    [self addSubview:line];
    
    line.sd_layout
    .bottomSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .heightIs(0.5);
    
    CGFloat w = self.extensionTopImageView.image.size.width;
    
    self.extensionTopImageView.sd_layout
    .topSpaceToView(self.timeLabel, 0)
    .leftSpaceToView(self, 77)
    .widthIs(w);
    
    self.extensionCommentView.sd_layout
    .topSpaceToView(self.extensionTopImageView, -0.5)
    .leftSpaceToView(self, 70)
    .rightSpaceToView(self, 10)
    .bottomSpaceToView(line, 11);
}

/**
 * 刷新数据
 */
- (void)setModel:(HXDynamic *)model
{
    _model = model;
    [self.headImageView sd_setImageWithURL:HXURL(model.photoUrl)
                                  forState:UIControlStateNormal
                          placeholderImage:[UIImage imageNamed:@"icon_default_avatar"]];
    
    [self.nameButton setTitle:model.nickname forState:(UIControlStateNormal)];
    self.contentLabel.hidden = !model.content.length;
    if (!self.contentLabel.hidden) {
        self.contentLabel.userInteractionEnabled = YES;
        if (model.attributedText) {
            self.contentLabel.attributedText = model.attributedText;
        }
    }
    
    self.imageViewCircle.bpicpaths = model.bpicpath;
    self.imageViewCircle.spicpaths = model.spicpath;
    
    if (self.imageViewCircle.bpicpaths.count == 1 && model.width_img) {
        self.imageViewCircle.one_img_width = model.width_img;
        self.imageViewCircle.one_img_height = model.height_img;
    }
    
    self.timeLabel.text = model.pubdate;
    
    self.nameButton.sd_layout.widthIs(model.nicknameW);
    
    self.contentLabel.sd_layout
    .widthIs(model.contentSize.width)
    .heightIs(model.contentSize.height);
    
    self.allContentButton.hidden = model.isShowAllButton;
    self.allContentButton.selected = model.isShowAllAttributedText;
    
    self.extensionTopImageView.hidden = !(model.commtentTopViewH || model.praiseetrHeight);
    self.extensionCommentView.hidden = self.extensionTopImageView.hidden;
    
    if (!self.extensionTopImageView.hidden) {
        self.extensionTopImageView.sd_layout.heightIs(model.commtentTopViewH);
        [self.extensionCommentView setModel:model];
        
        if (model.commtentViewH) {
            self.extensionCommentView.topView.bottonline.hidden = NO;
        }
        else {
            self.extensionCommentView.topView.bottonline.hidden = YES;
        }
    }
    
    self.addressLabel.hidden = !model.location.length;
//    self.deleteButton.hidden = !model.isMyDynamic;
    self.deleteButton.hidden = NO;
    
    UIView *temp = self.allContentButton.hidden ? _contentLabel : self.allContentButton;
    self.imageViewCircle.sd_layout
    .topSpaceToView((model.content.length ? temp : _nameButton),(!model.content.length ? 7+3 : 5))
    .heightIs(model.spicpathHeight);
    
    if (!self.addressLabel.hidden) {
        [self.addressLabel setTitle:model.location forState:(UIControlStateNormal)];
    }
    self.addressLabel.sd_layout
    .widthIs(_model.addressW)
    .heightIs(_model.addressH);
    
    self.timeLabel.sd_layout
    .widthIs(model.timeW);
}

/**
 * 交互事件
 */
- (void)dynamicCircleMoreViewWithRow:(NSInteger)row
{
    if (row == 1) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicCirclePraiseWithModel:ToTableViewCell:)]) {
            [self.delegate dynamicCirclePraiseWithModel:_model ToTableViewCell:self];
        }
    }
    else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicCircleCommentWithModel:didWithcommModel:toReplyuid:)]) {
            [self.delegate dynamicCircleCommentWithModel:_model didWithcommModel:nil toReplyuid:nil];
        }
    }
}

- (void)allContentButtonWithAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    [_model setattributedTextWithHeight:sender.selected];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadViewWith:)]) {
        [self.delegate reloadViewWith:nil];
    }
}

- (void)headViewWithAction
{
    if ([self.delegate respondsToSelector:@selector(dynamicCircleWithUserInfoUserid:)] && self.delegate) {
        [self.delegate dynamicCircleWithUserInfoUserid:_model.userinfoid];
    }
}

- (void)deleteButtonWithAction
{
    if ([self.delegate respondsToSelector:@selector(dynamicCircleWithDeleteDynamicID:ToTableViewCell:)] && self.delegate) {
        [self.delegate dynamicCircleWithDeleteDynamicID:_model.ID ToTableViewCell:self];
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)tap
{
    [self becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        return;
    }
    
    CGRect frame = _contentLabel.bounds;
    frame.size.width = frame.size.width/2;
    
    [menu setTargetRect:frame inView:_contentLabel];
    
    [menu setMenuVisible:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WillHideMenu:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
    
    _contentLabel.backgroundColor = BORDERToWidth_8_Color;
    _contentLabel.layer.borderColor = BORDERToWidth_8_Color.CGColor;
    _contentLabel.layer.borderWidth = 1;
}

- (void)moreBUttonWithAction:(UIButton *)sender
{
    HXDynamicCircleMoreView *moreView = [[HXDynamicCircleMoreView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:moreView];
    
    moreView.sd_layout
    .topSpaceToView([UIApplication sharedApplication].keyWindow, 0)
    .leftSpaceToView([UIApplication sharedApplication].keyWindow, 0)
    .rightSpaceToView([UIApplication sharedApplication].keyWindow, 0)
    .bottomSpaceToView([UIApplication sharedApplication].keyWindow, 0);
    
    CGPoint fromCenter = [_moreButton
                          convertPoint:CGPointMake(_moreButton.frame.size.width * 0.1f, _moreButton.frame.size.height * 0.1f)
                          toView:[UIApplication sharedApplication].keyWindow];
    
    [moreView showViewFrame:fromCenter];
    
    [moreView likeSelected:_model.praisestatus.integerValue];
    
    HXWeakSelf(moreView);
    HXWeakSelf(self);
    [moreView setDynamicCircleMoreViewWithBlocl:^(NSInteger row) {
        [weakself dynamicCircleMoreViewWithRow:row];
        if (row == 1) {
            [weakmoreView startAnimation];
        }
        else {
            [weakmoreView backViewAction];
        }
    }];
    [moreView setPriseExplodeStopCallBack:^{
        [weakmoreView backViewAction];
    }];
}

- (void)addressLabelWithAction
{
    if ([self.delegate respondsToSelector:@selector(dynamicCircleAddressWithLocation:)] && self.delegate) {
        [self.delegate dynamicCircleAddressWithLocation:_model.location];
    }
}

#pragma mark HXLabelDelegate
- (void)textWithAction:(NSString *)text toType:(NSString *)type
{
    if (![type isEqualToString:@"name"]) {
        NSString *newStr = text;
        NSError *error;
        NSRange stringRange = NSMakeRange(0, newStr.length);
        
        NSString *regulaStr = kRegulaURLStr;
        
        NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
        NSArray *numbers = [regexps matchesInString:newStr options:NSMatchingReportProgress range:stringRange];
        
        // url
        if (numbers.count) {
            if ([self.delegate respondsToSelector:@selector(dynamicCircleWebViewWithURL:)]) {
                [self.delegate dynamicCircleWebViewWithURL:text];
            }
            return;
        }
        
        // 手机号
        regulaStr = kRegulaPhoneStr;
        regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
        numbers = [regexps matchesInString:newStr options:NSMatchingReportProgress range:stringRange];
        if (numbers.count) {
            if ([self.delegate respondsToSelector:@selector(dynamicCircleWebViewWithPhone:)]) {
                [self.delegate dynamicCircleWebViewWithPhone:text];
            }
            return;
        }
    }
    
    // 姓名
    NSString *userid = nil;
    for (HXNewDynamicCircleComment *comment in _model.commentModels) {
        
        if (comment.replynickname.length) {  // 评论者
            
            if ([comment.replynickname isEqualToString:text]) {
                if ([comment.replynickname isEqualToString:comment.mynikename]) {
                    userid = comment.myuserid;
                }
                else {
                    if (comment.replyuid.length) {
                        userid = comment.replyuid;
                    }
                    else {
                        userid = comment.userinfoid;
                    }
                }
                break;
            }
        }
        
        if (comment.nickname.length) {  // 评论
            
            if ([comment.nickname isEqualToString:text]) {
                if ([comment.nickname isEqualToString:comment.mynikename]) {
                    userid = comment.myuserid;
                }
                else {
                    userid = comment.userinfoid;
                }
                break;
            }
        }
    }
    
    if (userid) {
        if ([self.delegate respondsToSelector:@selector(dynamicCircleWithUserInfoUserid:)] && self.delegate) {
            [self.delegate dynamicCircleWithUserInfoUserid:userid];
        }
    }
}

- (void)newExtensionCommentViewtextWithUserId:(NSString *)text
{
    if ([self.delegate respondsToSelector:@selector(dynamicCircleWithUserInfoUserid:)] && self.delegate) {
        [self.delegate dynamicCircleWithUserInfoUserid:text];
    }
}

#pragma mark HXNewExtensionCommentViewDelegate
- (void)newExtensionCommentViewtextWithAction:(NSString *)text toType:(NSString *)type
{
    [self textWithAction:text toType:type];
}

- (void)newExtensionCommentViewDidSelectRowAtModel:(HXNewDynamicCircleComment *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicCircleCommentWithModel:didWithcommModel:toReplyuid:)]) {
        [self.delegate dynamicCircleCommentWithModel:_model didWithcommModel:model toReplyuid:nil];
    }
}

#pragma mark - Getter
- (UIButton *)headImageView
{
    if (!_headImageView) {
        _headImageView = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_headImageView addTarget:self action:@selector(headViewWithAction) forControlEvents:(UIControlEventTouchUpInside)];
        _headImageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_headImageView];
    }
    return _headImageView;
}

- (UIButton *)nameButton
{
    if (!_nameButton) {
        _nameButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_nameButton setTitleColor:[UIColor colorWithHex:0x046363] forState:UIControlStateNormal];
        _nameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_nameButton addTarget:self action:@selector(headViewWithAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_nameButton];
    }
    return _nameButton;
}

- (HXLabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[HXLabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.dataDelegate = self;
        [self addSubview:_contentLabel];
        
        _contentLabel.layer.cornerRadius  = 4;
        _contentLabel.layer.masksToBounds = YES;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_contentLabel addGestureRecognizer:longPress];
    }
    return _contentLabel;
}

- (HXDynamicCircleImageView *)imageViewCircle
{
    if (!_imageViewCircle) {
        _imageViewCircle = [[HXDynamicCircleImageView alloc] init];
        [self addSubview:_imageViewCircle];
    }
    return _imageViewCircle;
}

- (UIButton *)allContentButton
{
    if (!_allContentButton) {
        _allContentButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_allContentButton setTitleColor:[UIColor colorWithHex:0x046363] forState:UIControlStateNormal];
        _allContentButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_allContentButton setTitle:@"全文" forState:(UIControlStateNormal)];
        [_allContentButton setTitle:@"收起" forState:(UIControlStateSelected)];
        _allContentButton.titleEdgeInsets = UIEdgeInsetsMake(-1, -6, 1, 6);
        [_allContentButton addTarget:self action:@selector(allContentButtonWithAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_allContentButton];
    }
    return _allContentButton;
}

- (UIButton *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addressLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [_addressLabel setTitleColor:[UIColor colorWithHex:0x046363] forState:(UIControlStateNormal)];
        [self addSubview:_addressLabel];
        [_addressLabel addTarget:self action:@selector(addressLabelWithAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addressLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = BORDER_TextGrey1_Color;
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_deleteButton addTarget:self action:@selector(deleteButtonWithAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_deleteButton setTitleColor:[UIColor colorWithHex:0x046363] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
    }
    return _deleteButton;
}

- (UIImageView *)extensionTopImageView
{
    if (!_extensionCommentView) {
        _extensionTopImageView = [[UIImageView alloc] init];
        _extensionTopImageView.image = [UIImage imageNamed:@"icon_circle_triangle"];
        [self addSubview:_extensionTopImageView];
    }
    return _extensionTopImageView;
}

- (HXNewExtensionCommentView *)extensionCommentView
{
    if (!_extensionCommentView) {
        _extensionCommentView = [[HXNewExtensionCommentView alloc] init];
        _extensionCommentView.delegate = self;
        _extensionCommentView.backgroundColor = BORDERToWidth_8_Color;
        _extensionCommentView.layer.cornerRadius = 3;
        _extensionCommentView.layer.masksToBounds = YES;
        [self addSubview:_extensionCommentView];
    }
    return _extensionCommentView;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _moreButton.backgroundColor = [UIColor whiteColor];
        [_moreButton setImage:[UIImage imageNamed:@"icon_circle_open"] forState:(UIControlStateNormal)];
        [_moreButton addTarget:self action:@selector(moreBUttonWithAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_moreButton];
    }
    return _moreButton;
}

@end
