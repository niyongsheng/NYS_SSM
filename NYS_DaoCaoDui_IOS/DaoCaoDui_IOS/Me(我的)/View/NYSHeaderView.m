//
//  NYSHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/30.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSHeaderView.h"
#import "NYSNickNameLbel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NYSHeaderView ()
@property(nonatomic, strong) UIImageView *bgImgView; // 背景图
@property(nonatomic, strong) NYSNickNameLbel *nickNameView; // 昵称容器 包含昵称 性别 等级
@end

@implementation NYSHeaderView

- (void)setUserInfo:(UserInfo *)userInfo {
    _userInfo = userInfo;
    
    UIImage *bgImg = [[UIImage imageNamed:@"bg"] imageByBlurRadius:0 tintColor:nil tintMode:0 saturation:1 maskImage:nil];
    [self.bgImgView setImage:bgImg];

    if (userInfo) { // 登录状态
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:userInfo.icon] placeholderImage:[UIImage imageNamed:@"me_photo_80x80_"]];
        [self.nickNameView setNickName:userInfo.nickname sex:userInfo.gender age:26 level:userInfo.grade];
    } else {
        [self.headImgView setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559388751209&di=2fbe67f6937a750695f38b37b822d26b&imgtype=0&src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170722%2F90b6ef3ed69348738e017d8b7cc3a577.png"] placeholder:ImageWithFile(@"default_icon")];
        [self.nickNameView setNickName:@"未登录" sex:0 age:0 level:0];
    }
}

#pragma mark -- 头像点击 --
-(void)headViewClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewClick)]) {
        [self.delegate headerViewClick];
    }
}
#pragma mark -- 昵称点击 --
- (void)nickNameViewClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(nickNameViewClick)]) {
        [self.delegate nickNameViewClick];
    }
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        [self addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _bgImgView;
}

- (YYAnimatedImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [YYAnimatedImageView new];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        _headImgView.userInteractionEnabled = YES;
        [_headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)]];
        
        ViewRadius(_headImgView, (90*Iphone6ScaleWidth)/2);
        [self addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(90*Iphone6ScaleWidth);
            make.centerY.mas_equalTo(self).offset(-12);
            make.centerX.mas_equalTo(self);
        }];
    }
    return _headImgView;
}

- (NYSNickNameLbel *)nickNameView {
    if (!_nickNameView) {
        _nickNameView = [NYSNickNameLbel new];
        [_nickNameView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickNameViewClick)]];
        [self addSubview:_nickNameView];
        [_nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImgView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self);
        }];
    }
    return _nickNameView;
}

@end
