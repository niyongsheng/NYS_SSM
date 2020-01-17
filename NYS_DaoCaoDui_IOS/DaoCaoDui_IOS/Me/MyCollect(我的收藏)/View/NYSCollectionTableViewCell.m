//
//  NYSCollectionTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/17.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSCollectionTableViewCell.h"

@interface NYSCollectionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgimageView;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@end

@implementation NYSCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.number.font = [UIFont fontWithName:@"04b_03b" size:20.f];
    self.bgimageView.layer.cornerRadius = 7.f;
    // Blur effect
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0,  RealValue(75), NScreenWidth, _bgimageView.frame.size.height);
    [_bgimageView addSubview:effectView];
}

- (IBAction)collectionBtnClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    if (self.collectionArticleModel) {
        [NYSRequest articleCollectionInOrOutWithResMethod:GET
                                               parameters:@{@"articleID" : @(self.collectionArticleModel.idField)}
                                                  success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                self.collectionBtn.selected = !self.collectionBtn.selected;
                [SVProgressHUD showSuccessWithStatus:[[response objectForKey:@"data"] objectForKey:@"info"]];
                [SVProgressHUD dismissWithDelay:1.f];
            }
        } failure:^(NSError *error) {
            
        } isCache:NO];
    }
    
    if (self.collectionPrayModel) {
        [NYSRequest prayCollectionInOrOutWithResMethod:GET
                                               parameters:@{@"prayID" : @(self.collectionPrayModel.idField)}
                                                  success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                self.collectionBtn.selected = !self.collectionBtn.selected;
                [SVProgressHUD showSuccessWithStatus:[[response objectForKey:@"data"] objectForKey:@"info"]];
                [SVProgressHUD dismissWithDelay:1.f];
            }
        } failure:^(NSError *error) {
            
        } isCache:NO];
    }
    
    if (self.collectionMusicModel) {
        [NYSRequest musicCollectionInOrOutWithResMethod:GET
                                               parameters:@{@"musicID" : @(self.collectionMusicModel.idField)}
                                                  success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                self.collectionBtn.selected = !self.collectionBtn.selected;
                [SVProgressHUD showSuccessWithStatus:[[response objectForKey:@"data"] objectForKey:@"info"]];
                [SVProgressHUD dismissWithDelay:1.f];
            }
        } failure:^(NSError *error) {
            
        } isCache:NO];
    }
}

- (void)setCollectionArticleModel:(NYSArticleModel *)collectionArticleModel {
    _collectionArticleModel = collectionArticleModel;
    
    [self.bgimageView setImageWithURL:[NSURL URLWithString:collectionArticleModel.icon] placeholder:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
//    self.bgimageView.image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:collectionArticleModel.icon]]] imageByBlurRadius:5 tintColor:nil tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
    self.collectionBtn.selected = collectionArticleModel.isCollection;
    [self.title setText:collectionArticleModel.title];
    [self.subtitle setText:collectionArticleModel.subtitle];
    [self.number setText:[NSString stringWithFormat:@"NO.%ld", collectionArticleModel.idField]];
}

- (void)setCollectionPrayModel:(NYSPrayModel *)collectionPrayModel {
    _collectionPrayModel = collectionPrayModel;
    
    [self.bgimageView setImageWithURL:[NSURL URLWithString:collectionPrayModel.icon] placeholder:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
//    self.bgimageView.image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:collectionPrayModel.icon]]] imageByBlurRadius:5 tintColor:nil tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
    self.collectionBtn.selected = collectionPrayModel.isCollection;
    [self.title setText:collectionPrayModel.title];
    [self.subtitle setText:collectionPrayModel.subtitle];
    [self.number setText:[NSString stringWithFormat:@"NO.%ld", collectionPrayModel.idField]];
}

- (void)setCollectionMusicModel:(NYSMusicModel *)collectionMusicModel {
    _collectionMusicModel = collectionMusicModel;
    
    [self.bgimageView setImageWithURL:[NSURL URLWithString:collectionMusicModel.icon] placeholder:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
//    self.bgimageView.image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:collectionMusicModel.icon]]] imageByBlurRadius:5 tintColor:nil tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
    self.collectionBtn.selected = collectionMusicModel.isCollection;
    [self.title setText:collectionMusicModel.name];
    [self.subtitle setText:collectionMusicModel.singer];
    [self.number setText:[NSString stringWithFormat:@"NO.%ld", collectionMusicModel.idField]];
}

@end
