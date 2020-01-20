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
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *musicCount;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation NYSMusicMenuHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

    CALayer *layer = [self.playBtn layer];
    layer.borderColor = NNavBgColorShallow.CGColor;
    layer.borderWidth = 1.5f;
    
    self.bgImageView.layer.cornerRadius = 7.f;
    self.playBtn.layer.cornerRadius = 4.f;
}

- (void)setMusicMenu:(NYSMusicListModel *)musicMenu {
    _musicMenu = musicMenu;
    
    self.title.text = musicMenu.name;
    self.time.text = [NSString stringWithFormat:@"%@ 创建", musicMenu.gmtCreate];
    self.musicCount.text = [NSString stringWithFormat:@"歌曲数：%lu首", (unsigned long)musicMenu.musicList.count];
    self.introduction.text = [NSString stringWithFormat:@"简介：%@", musicMenu.introduction];
    [self.bgImageView setImageWithURL:[NSURL URLWithString:musicMenu.icon] placeholder:[UIImage imageNamed:@"ic_cover_default_music_80x80_"]];
}

- (IBAction)playBtnClicked:(UIButton *)sender {
}

@end
