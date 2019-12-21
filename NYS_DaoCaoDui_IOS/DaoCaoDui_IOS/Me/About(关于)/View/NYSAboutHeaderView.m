//
//  NYSAboutHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/20.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSAboutHeaderView.h"

@interface NYSAboutHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *appIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *buildLabel;

@end

@implementation NYSAboutHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _appIconImageView.layer.cornerRadius = 10.0f;
    CALayer *layer = [_appIconImageView layer];
    layer.borderColor = NBgColorLightGray.CGColor;
    layer.borderWidth = 1.0f;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    self.appName.text = appCurName;
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"Version:%@", appCurVersion];
    // 当前应用版本号码 int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    self.buildLabel.text = [NSString stringWithFormat:@"Build:%@", appCurVersionNum];
}

@end
