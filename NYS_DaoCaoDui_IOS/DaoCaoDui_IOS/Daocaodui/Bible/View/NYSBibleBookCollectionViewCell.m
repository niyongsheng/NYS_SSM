//
//  NYSBibleBookCollectionViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBibleBookCollectionViewCell.h"

@interface NYSBibleBookCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end

@implementation NYSBibleBookCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4.0f;
    
    CALayer *layer = [self layer];
    layer.borderColor = NNavBgColorShallow.CGColor;
    layer.borderWidth = 2.0f;
}

-(void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    self.title.text = titleString;
}

-(void)setSubtitleString:(NSString *)subtitleString {
    _subtitleString = subtitleString;
    self.subtitle.text = subtitleString;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    [self.bgImageView setImage:[[UIImage imageWithColor:bgColor] imageByBlurLight]];
}

@end
