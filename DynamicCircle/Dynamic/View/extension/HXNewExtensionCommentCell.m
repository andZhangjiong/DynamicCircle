//
//  HXNewExtensionCommentCell.m
//  HongXun
//
//  Created by 张炯 on 2018/1/17.
//

#import "HXNewExtensionCommentCell.h"
#import "HXLabel.h"

@interface HXNewExtensionCommentCell ()<HXLabelDelegate>

@property (nonatomic, strong) HXLabel *commtentAttributedLabel;

@end

@implementation HXNewExtensionCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.commtentAttributedLabel.sd_layout
        .topSpaceToView(self, 1)
        .leftSpaceToView(self, 5)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        self.backgroundColor = BORDERToWidth_8_Color;
    }
    return self;
}

- (void)WillHideMenu:(id)sender
{
    self.backgroundColor = BORDERToWidth_8_Color;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)copy:(UIMenuController *)menu
{
    
    [SVProgressHUD showErrorWithStatus: @"已复制到剪切板"];
    
    self.backgroundColor = BORDERToWidth_8_Color;
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


- (void)setModel:(HXNewDynamicCircleComment *)model
{
    _model = model;
    self.commtentAttributedLabel.attributedText = model.commtentAttributedString;
}

- (void)textWithAction:(NSString *)text toType:(NSString *)type
{
    if (_textWithBlock) {
        _textWithBlock(text,type);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDidSelectWithText:type:)]) {
        [self.delegate cellDidSelectWithText:text type:type];
    }
}

- (void)setTextEvenToch
{
    if (_textEvenTochWithBlock) {
        _textEvenTochWithBlock(_model);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellTextEvenTochWithModel:)]) {
        [self.delegate cellTextEvenTochWithModel:_model];
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)tap
{
    [self becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        return;
    }
    
    CGRect frame = self.commtentAttributedLabel.bounds;
    frame.size.width = frame.size.width/2;
    
    [menu setTargetRect:frame inView:self.commtentAttributedLabel];
    
    [menu setMenuVisible:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WillHideMenu:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
    
    self.backgroundColor = BORDERToWidth_4_Color;
}

- (HXLabel *)commtentAttributedLabel
{
    if (!_commtentAttributedLabel) {
        _commtentAttributedLabel = [[HXLabel alloc] init];
        _commtentAttributedLabel.dataDelegate = self;
        _commtentAttributedLabel.type = @"comment";
        _commtentAttributedLabel.backgroundColor = self.backgroundColor;
        
        [self addSubview:_commtentAttributedLabel];
        
        HXWeakSelf(self);
        [_commtentAttributedLabel setTextEvenTochWithBlock:^{
            [weakself setTextEvenToch];
        }];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_commtentAttributedLabel addGestureRecognizer:longPress];
    }
    return _commtentAttributedLabel;
}


@end
