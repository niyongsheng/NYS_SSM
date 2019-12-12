//
//  QMHMemberCollectionViewCell.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/30.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHMemberCollectionViewCell.h"
#import "QMHMemberModel.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface QMHMemberCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation QMHMemberCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.userInteractionEnabled = NO;
    self.icon.layer.cornerRadius = 25;
    self.icon.layer.masksToBounds = YES;
}

- (void)setCollectionModel:(QMHMemberModel *)collectionModel {
    _collectionModel = collectionModel;
    
    [self.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:collectionModel.imgAddress] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认头像"]];
    [self.name setText:collectionModel.nickName];
}

@end
