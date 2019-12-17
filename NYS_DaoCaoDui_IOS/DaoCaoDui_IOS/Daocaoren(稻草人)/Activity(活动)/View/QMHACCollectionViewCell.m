//
//  QMHACCollectionViewCell.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/23.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHACCollectionViewCell.h"
#import "NYSActivityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "NYSConversationViewController.h"

@interface QMHACCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *memberCount;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *bgBtnView;
@end

@implementation QMHACCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.layer.cornerRadius = 30;
    self.icon.layer.masksToBounds = YES;
    
    self.joinBtn.layer.cornerRadius = 10;
    self.joinBtn.layer.masksToBounds = YES;
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = size.height;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}

- (void)setCollectionModel:(NYSActivityModel *)collectionModel {
    _collectionModel = collectionModel;
    
    // 随机背景色
    int x = 1 + arc4random() % 6;
    NSString *bgimgName = [NSString stringWithFormat:@"act_%d", x];
    [self.bgBtnView setBackgroundImage:[UIImage imageNamed:bgimgName] forState:UIControlStateNormal];
    self.bgBtnView.userInteractionEnabled = NO;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:collectionModel.icon] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.title.textColor = collectionModel.isTop ? UIColorFromHex(0xFCC430) : [UIColor whiteColor];
    self.title.text = collectionModel.name;
    self.topView.hidden = collectionModel.isTop ? NO : YES;
    self.memberCount.text = [NSString stringWithFormat:@"%@/2000", @"0"];
    self.introduction.text = collectionModel.introduction;
    self.community.text = collectionModel.fellowshipName;
    
    if (!collectionModel.isTop) {
        self.joinBtn.enabled = YES;
        self.joinBtn.backgroundColor = UIColorFromHex(0xFB1295);
    } else {
        self.joinBtn.enabled = NO;
        self.joinBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (IBAction)joinClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];

}

@end
