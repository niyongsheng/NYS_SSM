//
//  QMHACCollectionViewCell.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/23.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHACCollectionViewCell.h"
#import "QMHCommunityActivityList.h"
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

- (void)setCollectionModel:(QMHCommunityActivityList *)collectionModel {
    _collectionModel = collectionModel;
    
    // 随机背景色
    int x = 1 + arc4random() % 6;
    NSString *bgimgName = [NSString stringWithFormat:@"act_%d", x];
    [self.bgBtnView setBackgroundImage:[UIImage imageNamed:bgimgName] forState:UIControlStateNormal];
    self.bgBtnView.userInteractionEnabled = NO;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:collectionModel.imgAddress] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.title.textColor = [collectionModel.isTop boolValue] ? UIColorFromHex(0xFCC430) : [UIColor whiteColor];
    self.title.text = collectionModel.title;
    self.topView.hidden = [collectionModel.isTop boolValue] ? NO : YES;
    self.memberCount.text = [NSString stringWithFormat:@"%@/2000", collectionModel.memberNum];
    self.introduction.text = collectionModel.content;
    self.community.text = collectionModel.comName;
    
    if ([collectionModel.inGroup boolValue]) {
        self.joinBtn.enabled = YES;
        self.joinBtn.backgroundColor = UIColorFromHex(0xFB1295);
    } else {
        self.joinBtn.enabled = NO;
        self.joinBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (IBAction)joinClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NYSConversationViewController *groupConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_GROUP targetId:self.collectionModel.groupId];
        groupConversationVC.title = self.collectionModel.title;
        [self.fromViewController.navigationController pushViewController:groupConversationVC animated:YES];
    });
}

@end
