//
//  NYSUploadImageHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/24.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSUploadImageHeaderView.h"

@interface NYSUploadImageHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation NYSUploadImageHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];

    _uploadBtn.layer.cornerRadius = 55.0f;
    _uploadBtn.clipsToBounds = YES;
    CALayer *layer = [_uploadBtn layer];
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 1.1f;
}

- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    _uploadBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_uploadBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    // headerView background blur effect
//    [_bgImageView setImage:bgImage];
    //    _bgImageView.image = [[bgImage imageByBlurRadius:50 tintColor:nil tintMode:0 saturation:1 maskImage:nil] imageByRotateRight90];
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.frame = CGRectMake(0, 0, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
//    [_bgImageView addSubview:effectView];
}

- (void)uploadBtnForSendData:(id)target action:(SEL)action {
    [_uploadBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
