//
//  NYSAlert.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/26.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSAlert.h"
#import <UIImageView+WebCache.h>

@interface NYSAlert ()
+ (void)colourBarEffectWithView:(UIView *)view;
@end

@implementation NYSAlert

#pragma mark - 纯文本toast提示
/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message {
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    bgView.layer.cornerRadius = 5;
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.top.left.mas_equalTo(label).mas_offset(-20);
        make.bottom.right.mas_equalTo(label).mas_offset(20);
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(140);
        make.center.mas_equalTo(label.superview);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

#pragma mark - 图文toast提示
/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName {
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    bgView.layer.cornerRadius = 5;
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [bgView addSubview:imageView];
    
    // label
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:22];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.width.mas_equalTo(150);
    }];
    
    // 设置imageView的约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(130);
        make.centerX.mas_equalTo(label.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.bottom.mas_offset(-18);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

#pragma mark - 提交成功提示弹框
/** nys带按钮回调的成功提示弹框 */
+ (void)showSuccessAlertWithTitle:(NSString *)title message:(NSString *)message okButtonClickedBlock:(void(^)(void))okButtonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nys_alert_bg"]];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(RealValue(240), RealValue(250)));
    }];
    
    // 标题label
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgImageView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(bgImageView.mas_top).mas_offset(RealValue(15));
    }];
    
    // 成功图标
    UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nys_alert_success"]];
    [bgImageView addSubview:signImageView];
    [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView).mas_offset(-15);
        make.centerX.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(RealValue(70), RealValue(70)));
    }];
    
    // 详细信息
    UILabel *messageLabel = [[UILabel alloc] init];
    [bgImageView addSubview:messageLabel];
    messageLabel.textColor = [UIColor colorWithRed:0.14 green:0.72 blue:0.45 alpha:1.00];
    messageLabel.text = message;
    messageLabel.adjustsFontSizeToFitWidth = YES;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signImageView.mas_bottom).mas_offset(14);
        make.left.right.mas_equalTo(bgImageView);
    }];
    
    // ok按钮
    UIButton *okButton = [[UIButton alloc] init];
    [bgView addSubview:okButton];
    okButton.backgroundColor = NNavBgColor;
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [okButton setTitle:@"好的" forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 5.0f;
    [[okButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        okButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.bottom.mas_equalTo(bgImageView.mas_bottom).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    
    // 彩带效果
    [self colourBarEffectWithView:bgView];
}

#pragma mark - 提交失败提示弹框
/** nys带按钮回调的失败提示弹框 */
+ (void)showFailAlertWithTitle:(NSString *)title message:(NSString *)message okButtonClickedBlock:(void(^)(void))okButtonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nys_alert_bg"]];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(RealValue(240), RealValue(250)));
    }];
    
    // 标题label
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgImageView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(bgImageView.mas_top).mas_offset(RealValue(15));
    }];
    
    // 成功图标
    UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nys_alert_fail"]];
    [bgImageView addSubview:signImageView];
    [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView).mas_offset(-15);
        make.centerX.mas_equalTo(bgImageView);
        make.size.mas_equalTo(CGSizeMake(RealValue(70), RealValue(70)));
    }];
    
    // 详细信息
    UILabel *messageLabel = [[UILabel alloc] init];
    [bgImageView addSubview:messageLabel];
    messageLabel.textColor = [UIColor colorWithRed:1.00 green:0.50 blue:0.22 alpha:1.00];
    messageLabel.text = message;
    messageLabel.adjustsFontSizeToFitWidth = YES;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signImageView.mas_bottom).mas_offset(14);
        make.left.right.mas_equalTo(bgImageView);
    }];
    
    // ok按钮
    UIButton *okButton = [[UIButton alloc] init];
    [bgView addSubview:okButton];
    okButton.backgroundColor = NNavBgColor;
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [okButton setTitle:@"知道了" forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 5.0f;
    [[okButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        okButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.bottom.mas_equalTo(bgImageView.mas_bottom).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self colourBarEffectWithView:bgView];
}

#pragma mark - 带block回调的签到弹窗
+ (void)showSignAlertWithMessage:(NSAttributedString *)signMessageText infoButtonClickedBlock:(void(^)(void))buttonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_yellow_bg"]];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(NScreenWidth, RealValue(450)));
    }];
    
    // 签到label
    UILabel *signLabel = [[UILabel alloc] init];
    [signLabel setTextColor:[UIColor colorWithRed:1.00 green:0.76 blue:0.09 alpha:1.00]];
    [signLabel setNumberOfLines:0];
    signLabel.attributedText = signMessageText;
    signLabel.adjustsFontSizeToFitWidth = YES;
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = [UIFont systemFontOfSize:16];
    [bgImageView addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.centerY.mas_equalTo(bgImageView).mas_offset(- RealValue(30));
    }];
    
    // 查看详情按钮
    UIButton *conversionButton = [[UIButton alloc] init];
    [bgView addSubview:conversionButton];
    conversionButton.backgroundColor = NNavBgColorShallow;
    [conversionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [conversionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [conversionButton setTitle:@"查看详情" forState:UIControlStateNormal];
    conversionButton.layer.cornerRadius = 6;
    conversionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
    [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateNormal];
    [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateHighlighted];
    conversionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
    [[conversionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        buttonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(signLabel.mas_bottom).mas_offset(RealValue(20));
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-55);
        make.bottom.mas_equalTo(bgImageView.mas_top).mas_offset(110);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 彩带效果
    [self colourBarEffectWithView:bgView];
}

#pragma mark - 带block回调的弹窗
/** 带block回调的弹窗 */
+ (void)showAlertWithButtonClickedBlock:(void (^)(void))buttonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"签到成功"]];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(35);
        make.size.mas_equalTo(CGSizeMake(375, 450));
    }];
    
    // 签到label
    UILabel *signLabel = [[UILabel alloc] init];
    [bgImageView addSubview:signLabel];
//    signLabel.text = @"恭喜你签到成功";
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = [UIFont systemFontOfSize:16];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.centerX.mas_equalTo(bgImageView).mas_offset(-9);
        make.top.mas_equalTo(92);
    }];
    
    // 签到成功图片
    UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [bgImageView addSubview:signImageView];
    [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(signLabel);
        make.left.mas_equalTo(signLabel.mas_right).mas_offset(3);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    // 持有积分
    UILabel *scoreLabel = [[UILabel alloc] init];
    [bgImageView addSubview:scoreLabel];
    scoreLabel.textColor = [UIColor colorWithHexString:@"e83421"];
//    scoreLabel.text = @"获得10积分";
    scoreLabel.adjustsFontSizeToFitWidth = YES; // 避免尴尬情况
    scoreLabel.font = [UIFont systemFontOfSize:15];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-35);
        make.height.mas_equalTo(16);
        make.left.right.mas_equalTo(bgImageView);
    }];
    
    // 兑换按钮
//    UIButton *conversionButton = [[UIButton alloc] init];
//    [bgView addSubview:conversionButton];
//    conversionButton.backgroundColor = [UIColor colorWithHexString:@"e83421"];
//    [conversionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [conversionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [conversionButton setTitle:@"前去兑换" forState:UIControlStateNormal];
//    conversionButton.layer.cornerRadius = 6;
//    conversionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
//    [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateNormal];
//    [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateHighlighted];
//    conversionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
//    [[conversionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        buttonClickedBlock();
//        [bgView removeFromSuperview];
//    }];
//    [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(bgView);
//        make.top.mas_equalTo(bgImageView.mas_bottom).mas_offset(8);
//        make.size.mas_equalTo(CGSizeMake(84, 29));
//    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView.mas_right).mas_offset(-55);
        make.bottom.mas_equalTo(bgImageView.mas_top).mas_offset(110);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

#pragma mark - 带网络图片与block回调的弹窗
/**
 带网络图片与block回调的弹窗

 @param imageURL 图片URL
 @param buttonClickedBlock 兑换按钮点击时的回调
 */
+ (void)showAlertWithImageURL:(NSString *)imageURL ButtonClickedBlock:(void (^)(void))buttonClickedBlock {
    // 先获取网络图片
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    goodsImageView.layer.cornerRadius = 10.0f;
    goodsImageView.clipsToBounds = YES;
//    goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 获取图片成功后再搭建UI
        
        // 大背景
        UIView *bgView = [[UIView alloc] init];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        // 网络图片
        [bgView addSubview:goodsImageView];
        [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView.centerX);
            make.centerY.mas_equalTo(bgView.centerY);
            make.size.mas_equalTo(CGSizeMake(NScreenWidth * 0.7, NScreenWidth * 0.7 * 4/3));
        }];
        
//        // 签到label
//        UILabel *signLabel = [[UILabel alloc] init];
//        [bgView addSubview:signLabel];
//        signLabel.text = @"今日签到获得+10积分";
//        signLabel.textAlignment = NSTextAlignmentCenter;
//        signLabel.font = [UIFont systemFontOfSize:15];
//        signLabel.textColor = [UIColor whiteColor];
//        [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(16);
//            make.centerX.mas_equalTo(bgView).mas_offset(-9);
//            make.top.mas_equalTo(goodsImageView.mas_bottom).mas_offset(8);
//        }];
//
//        // 签到成功图片
//        UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_success"]];
//        [bgView addSubview:signImageView];
//        [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(signLabel);
//            make.left.mas_equalTo(signLabel.mas_right).mas_offset(3);
//            make.size.mas_equalTo(CGSizeMake(14, 14));
//        }];
//
//        // 持有积分
//        UILabel *scoreLabel = [[UILabel alloc] init];
//        [bgView addSubview:scoreLabel];
//        scoreLabel.textColor = [UIColor whiteColor];
//        scoreLabel.text = @"小主~您的积分已达到500";
//        scoreLabel.adjustsFontSizeToFitWidth = YES; // 避免尴尬情况
//        scoreLabel.font = [UIFont systemFontOfSize:15];
//        scoreLabel.textAlignment = NSTextAlignmentCenter;
//        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(signLabel.mas_bottom).mas_offset(7);
//            make.height.mas_equalTo(16);
//            make.left.right.mas_equalTo(goodsImageView);
//        }];
        
        // 兑换按钮
        UIButton *conversionButton = [[UIButton alloc] init];
        [bgView addSubview:conversionButton];
        conversionButton.backgroundColor = [UIColor colorWithHexString:@"e83421"];
        [conversionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [conversionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [conversionButton setTitle:@"查看详情" forState:UIControlStateNormal];
        conversionButton.layer.cornerRadius = 6;
        conversionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
        [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateNormal];
        [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateHighlighted];
        conversionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
        [[conversionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            buttonClickedBlock(); // 回调block
            [bgView removeFromSuperview];
        }];
        [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.top.mas_equalTo(goodsImageView.mas_bottom).mas_offset(9);
            make.size.mas_equalTo(CGSizeMake(84, 29));
        }];
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc] init];
        [bgView addSubview:cancelButton];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
        [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [bgView removeFromSuperview];
        }];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(goodsImageView);
            make.bottom.mas_equalTo(goodsImageView.mas_top).mas_offset(-22);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }];
}

#pragma mark - 炫彩弹窗
/**
 兑换成功后展示的弹窗
 
 @param couponName 优惠券名称
 @param validityTime 有效期
 @param checkButtonClickedBlock “查看优惠券”按钮点击后的回调
 */
+ (void)showConversionSucceedAlertWithCouponName:(NSString *)couponName validityTime:(NSString *)validityTime checkCouponButtonClickedBlock:(void (^)(void))checkButtonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 白色view
    UIView *whiteView = [[UIView alloc] init];
    [bgView addSubview:whiteView];
    whiteView.clipsToBounds = YES;
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(255);
        make.center.mas_equalTo(bgView);
    }];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [whiteView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"兑换成功";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(17);
    }];
    
    // 优惠券label
    UILabel *couponLabel = [[UILabel alloc] init];
    [whiteView addSubview:couponLabel];
    couponLabel.text = couponName;
    couponLabel.textAlignment = NSTextAlignmentCenter;
    couponLabel.font = [UIFont systemFontOfSize:14];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(whiteView);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(13);
        make.height.mas_equalTo(14);
    }];
    
    // 有效期label
    UILabel *timeLabel = [[UILabel alloc] init];
    [whiteView addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor colorWithRed:0.84 green:0.33 blue:0.44 alpha:1.00];
    timeLabel.text = validityTime;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(couponLabel);
        make.top.mas_equalTo(couponLabel.mas_bottom).mas_offset(10);
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [whiteView addSubview:cancelButton];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // 点击取消按钮移除弹窗
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(whiteView.mas_centerX);
        make.height.mas_equalTo(43);
    }];
    
    // 查看优惠券按钮
    UIButton *checkButton = [[UIButton alloc] init];
    [whiteView addSubview:checkButton];
    [checkButton setTitle:@"查看优惠券" forState:UIControlStateNormal];
    [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [checkButton setTitleColor:[UIColor colorWithRed:0.42 green:0.74 blue:0.67 alpha:1.00] forState:UIControlStateNormal];
    [[checkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
        checkButtonClickedBlock();
    }];
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.mas_equalTo(cancelButton);
        make.left.mas_equalTo(cancelButton.mas_right);
        make.bottom.mas_equalTo(whiteView);
    }];
    
    // 横线灰色线
    UIView *grayLineView1 = [[UIView alloc] init];
    [whiteView addSubview:grayLineView1];
    grayLineView1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [grayLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
    }];
    
    // 竖向灰色线
    UIView *grayLineView2 = [[UIView alloc] init];
    [whiteView addSubview:grayLineView2];
    grayLineView2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [grayLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayLineView1.mas_bottom);
        make.bottom.mas_equalTo(whiteView);
        make.centerX.mas_equalTo(whiteView);
        make.width.mas_equalTo(1);
    }];
}

#pragma mark - 彩带效果 #############################################################
+ (void)colourBarEffectWithView:(UIView *)view {
    CAEmitterLayer *colourBarEmitter = [CAEmitterLayer layer];
    // 例子发射位置
    colourBarEmitter.emitterPosition = CGPointMake(NScreenWidth/2,-30);
    colourBarEmitter.preservesDepth = YES;
    colourBarEmitter.lifetime = 1.5;
    
    // 发射源的尺寸大小
    colourBarEmitter.emitterSize = CGSizeMake(NScreenWidth*2, NScreenHeight);
    // 发射模式
    colourBarEmitter.emitterMode = kCAEmitterLayerOutline;
    // 发射源的形状
    colourBarEmitter.emitterShape = kCAEmitterLayerLine;
    
    NSMutableArray *cellArr=[[NSMutableArray alloc] init];
    for (int i=1; i<9; i++) {
        CAEmitterCell *colourBarflake = [CAEmitterCell emitterCell];
        colourBarflake.birthRate     = 10.0;
        colourBarflake.lifetime      = 4.0;
        colourBarflake.alphaSpeed    = -0.1;
        colourBarflake.alphaRange    = 0.2;
        colourBarflake.velocity      = 150;
        colourBarflake.velocityRange = 30;
        colourBarflake.yAcceleration = 100;
        colourBarflake.emissionRange = M_PI;        // some variation in angle
        colourBarflake.spinRange     = M_PI;        // slow spin
        colourBarflake.contents      = (id)[[UIImage imageNamed:[NSString stringWithFormat:@"stepPk_win_colour%d",i]] CGImage];
        [cellArr addObject:colourBarflake];
    }
    colourBarEmitter.shadowOpacity = 1.0;
    colourBarEmitter.shadowRadius = 0.0;
    colourBarEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    
    colourBarEmitter.emitterCells = cellArr;
    [view.layer addSublayer:colourBarEmitter];
    
    // 延时关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        colourBarEmitter.birthRate = 0;
    });
}

@end
