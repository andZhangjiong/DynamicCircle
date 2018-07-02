//
//  HXNewExtensionLikedView.m
//  HongXun
//
//  Created by 张炯 on 2018/1/17.
//

#import "HXNewExtensionLikedView.h"
#import "HXLabel.h"

@interface HXNewExtensionLikedView ()<HXLabelDelegate>
@property (nonatomic, strong) UIImageView *praiseImageView;
@property (nonatomic, strong) HXLabel *praiseAttributedLabel;

@end

@implementation HXNewExtensionLikedView

- (instancetype)init {
    if (self = [super init]) {
        
        self.praiseImageView.sd_layout
        .topSpaceToView(self, 9)
        .leftSpaceToView(self, 6.8)
        .widthIs(self.praiseImageView.image.size.width)
        .heightIs(self.praiseImageView.image.size.height);
        
        self.praiseAttributedLabel.sd_layout
        .topSpaceToView(self, 1.5)
        .leftSpaceToView(self.praiseImageView, 5.5)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
        UIView *bottonline = [[UILabel alloc] init];
        bottonline.backgroundColor = BORDERToWidth_Line_Color;
        [self addSubview:bottonline];
        _bottonline = bottonline;
        
        bottonline.sd_layout
        .bottomSpaceToView(self, 0.5)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(0.5);
    }
    return self;
}

- (void)setPraiseAttributed:(NSAttributedString *)praiseAttributed
{
    _praiseAttributed = praiseAttributed;
    
    self.praiseAttributedLabel.attributedText = praiseAttributed;
}

- (void)textWithAction:(NSString *)text toType:(NSString *)type
{
    if (_extensionLikedViewWithUserIdBlock) {
        _extensionLikedViewWithUserIdBlock(text,type);
    }
}

- (UIImageView *)praiseImageView
{
    if (!_praiseImageView) {
        _praiseImageView = [[UIImageView alloc] init];
        _praiseImageView.image = [UIImage imageNamed:@"icon_circle_like"];
        [self addSubview:_praiseImageView];
    }
    return _praiseImageView;
}

- (HXLabel *)praiseAttributedLabel
{
    if (!_praiseAttributedLabel) {
        _praiseAttributedLabel = [[HXLabel alloc] init];
        _praiseAttributedLabel.dataDelegate = self;
        _praiseAttributedLabel.backgroundColor = self.backgroundColor;
        
        [self addSubview:_praiseAttributedLabel];
    }
    return _praiseAttributedLabel;
}




@end
