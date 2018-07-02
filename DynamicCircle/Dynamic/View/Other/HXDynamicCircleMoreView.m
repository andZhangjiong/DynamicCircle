//
//  HXDynamicCircleMoreView.m
//  HongXun
//
//  Created by 张炯 on 2017/12/18.
//

#import "HXDynamicCircleMoreView.h"
#import "HXCirclePraiseBtn.h"

@interface HXDynamicCircleMoreView ()

@property (nonatomic, strong) UIView *moreView;

@property (nonatomic, strong) HXCirclePraiseBtn *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic,assign) CGPoint frpoint;

@end



@implementation HXDynamicCircleMoreView

- (instancetype)init
{
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    UIView *backView = [[UIView  alloc] init];
    [self addSubview:backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewAction)];
    [backView addGestureRecognizer:tap];
    
    backView.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);
    
    UIView *moreView = [[UIView alloc] init];
    moreView.backgroundColor = [UIColor colorWithHex:0x4d5153];
    moreView.layer.cornerRadius = 5;
    moreView.layer.masksToBounds = YES;
    [self addSubview:moreView];
    _moreView = moreView;
    
    HXCirclePraiseBtn *leftButton = [HXCirclePraiseBtn buttonWithType:(UIButtonTypeCustom)];
    __weak typeof(self) weakself = self;
    leftButton.explodeStopBlock = ^{
        if (weakself.priseExplodeStopCallBack) {
            weakself.priseExplodeStopCallBack();
        }
    };
    [leftButton setImage:[UIImage imageNamed:@"icon_circle_open_like"] forState:UIControlStateNormal];
    [leftButton setTitle:@" 赞" forState:(UIControlStateNormal)];
    [leftButton setTitle:@" 取消" forState:(UIControlStateSelected)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreView addSubview:leftButton];
    leftButton.frame = CGRectMake(0, 0, 64, 40);
    _leftButton = leftButton;
    
    [leftButton addTarget:self action:@selector(leftButtonWithAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setImage:[UIImage imageNamed:@"icon_circle_open_comment"] forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton setTitle:@" 评论" forState:(UIControlStateNormal)];
    [moreView addSubview:rightButton];
    rightButton.frame = CGRectMake(65, 0, 64, 40);
    _rightButton = rightButton;
    
    [rightButton addTarget:self action:@selector(rightButtonWithAction:) forControlEvents:(UIControlEventTouchUpInside)];

    UIView *cenLen = [[UIView alloc] init];
    cenLen.backgroundColor = BORDER_TextBlack_Color;
    cenLen.frame = CGRectMake(60, 8, 1, 40-16);
    [moreView addSubview:cenLen];
}

-(void)startAnimation{
    [_leftButton animation];
}

- (void)likeSelected:(BOOL)selected
{
    _leftButton.selected = selected;
}

- (void)leftButtonWithAction:(UIButton *)sender
{
    sender.selected = !sender.selected;

    if (_dynamicCircleMoreViewWithBlocl) {
        _dynamicCircleMoreViewWithBlocl(1);
    }
    
}

- (void)rightButtonWithAction:(UIButton *)sender
{
    if (_dynamicCircleMoreViewWithBlocl) {
        _dynamicCircleMoreViewWithBlocl(2);
    }
}

- (void)showViewFrame:(CGPoint)point
{
    _frpoint = point;
    
    CGFloat WIDTH = 130;
    
    _moreView.frame = CGRectMake(point.x, point.y-5, 0, 40);

    [UIView animateWithDuration:0.2 animations:^{
        self.moreView.frame = CGRectMake(point.x-WIDTH, point.y-5, WIDTH, 40);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)backViewAction
{
    [UIView animateWithDuration:0.2 animations:^{
        self.moreView.frame = CGRectMake(_frpoint.x, _frpoint.y-5, 0, 40);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
