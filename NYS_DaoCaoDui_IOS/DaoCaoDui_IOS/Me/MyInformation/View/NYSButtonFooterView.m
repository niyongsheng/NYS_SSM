//
//  NYSButtonFooterView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/5.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSButtonFooterView.h"

@interface NYSButtonFooterView ()
@property (nonatomic, strong) UIButton *sendBtn;
@end

@implementation NYSButtonFooterView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sendBtn.backgroundColor = NNavBgColor;
        self.sendBtn.layer.cornerRadius = 20.f;
        self.sendBtn.frame = CGRectMake(80 , 30 , NScreenWidth - 160 , 40);
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

- (void)buttonIsEnable:(BOOL)isEnable withTitle:(NSString *)title {
    [self.sendBtn setEnabled:isEnable];
    title ? [self.sendBtn setTitle:title forState:UIControlStateNormal] : nil;
}

- (void)buttonForSendData:(id)target action:(SEL)action {
    [self.sendBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
