//
//  NYSMyPublishTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSMyPublishTableViewCell.h"

@interface NYSMyPublishTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *collectionCount;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
@implementation NYSMyPublishTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.number.font = [UIFont fontWithName:@"04b_03b" size:20.f];
    self.icon.layer.cornerRadius = 5.f;
}

- (void)setCollectionArticleModel:(NYSArticleModel *)collectionArticleModel {
    _collectionArticleModel = collectionArticleModel;
    
    self.collectionBtn.selected = collectionArticleModel.collectionUserList.count > 0 ? YES : NO;
    [self.icon setImageWithURL:[NSURL URLWithString:collectionArticleModel.icon] placeholder:[UIImage imageNamed:@"chat_share_subject_72x72_"]];
    [self.title setText:collectionArticleModel.title];
    [self.subtitle setText:collectionArticleModel.subtitle];
    [self.time setText:collectionArticleModel.gmtCreate];
    [self.collectionCount setText:[NSString stringWithFormat:@"%ld", collectionArticleModel.collectionUserList.count]];
    [self.number setText:[NSString stringWithFormat:@"NO.%ld", collectionArticleModel.idField]];
}

- (void)setCollectionPrayModel:(NYSPrayModel *)collectionPrayModel {
    _collectionPrayModel = collectionPrayModel;
    
    self.collectionBtn.selected = collectionPrayModel.collectionUserList.count > 0 ? YES : NO;
    [self.icon setImageWithURL:[NSURL URLWithString:collectionPrayModel.icon] placeholder:[UIImage imageNamed:@"chat_share_subject_72x72_"]];
    [self.title setText:collectionPrayModel.title];
    [self.subtitle setText:collectionPrayModel.subtitle];
    [self.time setText:collectionPrayModel.gmtCreate];
    [self.collectionCount setText:[NSString stringWithFormat:@"%ld", collectionPrayModel.collectionUserList.count]];
    [self.number setText:[NSString stringWithFormat:@"NO.%ld", collectionPrayModel.idField]];
}

- (void)setCollectionMusicModel:(NYSMusicModel *)collectionMusicModel {
    _collectionMusicModel = collectionMusicModel;
    
    self.collectionBtn.selected = collectionMusicModel.collectionUserList.count > 0 ? YES : NO;
    [self.icon setImageWithURL:[NSURL URLWithString:collectionMusicModel.icon] placeholder:[UIImage imageNamed:@"chat_share_subject_72x72_"]];
    [self.title setText:collectionMusicModel.name];
    [self.subtitle setText:collectionMusicModel.singer];
    [self.time setText:collectionMusicModel.gmtCreate];
    [self.collectionCount setText:[NSString stringWithFormat:@"%ld", collectionMusicModel.collectionUserList.count]];
    [self.number setText:[NSString stringWithFormat:@"NO.%ld", collectionMusicModel.idField]];
}

- (IBAction)deleteBtnClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteItemButton:)]) {
        // 通知代理方法
        [self.delegate deleteItemButton:_index];
    }
}

@end
