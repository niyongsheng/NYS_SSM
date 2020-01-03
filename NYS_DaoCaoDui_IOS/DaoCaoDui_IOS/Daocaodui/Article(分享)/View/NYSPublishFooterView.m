//
//  NYSPublishFooterView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/26.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "NYSPublishFooterView.h"

@interface NYSPublishFooterView ()
@property (nonatomic, strong) UIButton *isAgree;
@property (nonatomic, strong) UIButton *EULA;
@property (nonatomic, strong) UIButton *sendBtn;
@end

@implementation NYSPublishFooterView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.isAgree = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.isAgree setBackgroundImage:[UIImage imageNamed:@"ic_media_setting_selected_30x30_"] forState:UIControlStateNormal];
        [self.isAgree setBackgroundImage:[UIImage imageNamed:@"ic_media_setting_unselected_30x30_"] forState:UIControlStateSelected];
        [self.isAgree addTarget:self action:@selector(isAgreeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.isAgree.frame = CGRectMake(20, 0, 40, 40);
        [self addSubview:self.isAgree];
        
        self.EULA = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.EULA setTitle:@"《遵守用户许可协议》" forState:UIControlStateNormal];
        [self.EULA setTitleColor:NNavBgColorShallow forState:UIControlStateNormal];
        self.EULA.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.EULA.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.EULA.frame = CGRectMake(50, 0, 200, 40);
        [self addSubview:self.EULA];
        
        self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendBtn setBackgroundImage:[UIImage imageWithColor:NNavBgColorShallow] forState:UIControlStateNormal];
        [self.sendBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
        self.sendBtn.layer.cornerRadius = 20.f;
        self.sendBtn.clipsToBounds = YES;
        self.sendBtn.frame = CGRectMake(80, 50, NScreenWidth - 160, 40);
        [self setupWithBtn:self.sendBtn withTitle:title withTitleColor:[UIColor whiteColor] withFontSize:17];
        [self addSubview:self.sendBtn];
    }
    return self;
}

- (void)setupWithBtn:(UIButton *)btn withTitle:(NSString *)title withTitleColor:(UIColor *)color withFontSize:(CGFloat)fontSize {
    [self addSubview:btn];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

/// 用户许可协议同意
/// @param sender 签署许可协议按钮
- (void)isAgreeButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;

    self.sendBtn.selected = !self.sendBtn.selected;
    self.sendBtn.userInteractionEnabled = !self.sendBtn.userInteractionEnabled;
}

- (void)publishButtonForSendData:(id)target action:(SEL)action {
    [self.sendBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)EULAButtonForSendData:(id)target action:(SEL)action {
    [self.EULA addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
