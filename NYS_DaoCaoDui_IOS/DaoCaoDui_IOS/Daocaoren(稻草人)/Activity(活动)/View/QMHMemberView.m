//
//  QMHMemberView.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/29.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHMemberView.h"
#import "QMHMemberModel.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface QMHMemberView ()
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation QMHMemberView

+ (instancetype)memberView {
    // 封装Xib的加载过程
    return [[NSBundle mainBundle] loadNibNamed:@"QMHMemberView" owner:nil options:nil].firstObject;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
       
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 22.5f;
    self.icon.clipsToBounds = YES;
}

- (void)buttonForSendData:(id)target action:(SEL)action {
    [self.icon addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMemberModel:(QMHMemberModel *)memberModel {
    _memberModel = memberModel;
    
    [self.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:memberModel.imgAddress] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认头像"]];
    [self.name setText:memberModel.nickName];
}

- (void)setIconTag:(NSInteger)iconTag {
    _iconTag = iconTag;
    [self.icon setTag:iconTag];
}

@end
