//
//  NYSActivityCollectionViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSActivityCollectionViewCell.h"
#import "NYSActivityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "NYSConversationViewController.h"

@interface NYSActivityCollectionViewCell()
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

@implementation NYSActivityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.layer.cornerRadius = 30;
    self.icon.layer.masksToBounds = YES;
    CALayer *layer = [self.icon layer];
    layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f].CGColor;
    layer.borderWidth = 1.0f;
    
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
    
    // ID随机背景色
    int x = 1 + self.collectionModel.ID % 6;
    NSString *bgimgName = [NSString stringWithFormat:@"act_%d", x];
    [self.bgBtnView setBackgroundImage:[UIImage imageNamed:bgimgName] forState:UIControlStateNormal];
    self.bgBtnView.userInteractionEnabled = NO;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:collectionModel.icon] placeholderImage:[UIImage imageNamed:@"ic_album_cover_65x65_"]];
    self.title.textColor = collectionModel.isTop ? UIColorFromHex(0xFCC430) : [UIColor whiteColor];
    self.title.text = collectionModel.name;
    self.topView.hidden = collectionModel.isTop ? NO : YES;
    self.memberCount.text = [NSString stringWithFormat:@"%ld人", collectionModel.userList.count];
    self.introduction.text = collectionModel.introduction;
    self.community.text = collectionModel.fellowshipName;
    if (collectionModel.groupId) {
        self.joinBtn.hidden = NO;
        if (collectionModel.isInGroup) {
            self.joinBtn.enabled = YES;
            self.joinBtn.backgroundColor = NNavBgColorShallow;
        } else {
            self.joinBtn.enabled = NO;
            self.joinBtn.backgroundColor = [UIColor lightGrayColor];
        }
    } else {
        self.joinBtn.hidden = YES;
    }
}

- (IBAction)joinClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NYSConversationViewController *groupConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_GROUP targetId:[NSString stringWithFormat:@"%ld", self.collectionModel.groupId]];
        groupConversationVC.title = self.collectionModel.name;
        [self.fromViewController.navigationController pushViewController:groupConversationVC animated:YES];
    });
}

@end
