//
//  NYSMusicMenuHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/18.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMusicMenuHeaderView.h"

@interface NYSMusicMenuHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation NYSMusicMenuHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

//    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    self.bgImageView.image = [[UIImage imageNamed:@"makeup"] imageByBlurRadius:10 tintColor:nil tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

@end
