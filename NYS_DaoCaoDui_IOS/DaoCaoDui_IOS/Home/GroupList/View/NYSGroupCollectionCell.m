//
//  NYSGroupCollectionCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/26.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSGroupCollectionCell.h"
#import "NYSGroupModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NYSConversationViewController.h"

@interface NYSGroupCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *memberCount;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UILabel *fellowship;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end

@implementation NYSGroupCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.icon.layer.cornerRadius = 25;
    self.icon.layer.masksToBounds = YES;
    
    self.joinBtn.backgroundColor = [UIColor whiteColor];
    self.joinBtn.layer.cornerRadius = 10.f;
    CALayer *layer = [_joinBtn layer];
    layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f].CGColor;
    layer.borderWidth = 1.2f;
    
    self.bgView.layer.cornerRadius = 7;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:.4f];
    
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 5.0f;
}

- (void)setGroupModel:(NYSGroupModel *)groupModel {
    _groupModel = groupModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:groupModel.groupIcon] placeholderImage:[UIImage imageNamed:@"chat_group"]];
    self.name.textColor = groupModel.isTop ? [UIColor redColor] : [UIColor blackColor];
    self.name.text = groupModel.groupName;
    self.memberCount.text = [NSString stringWithFormat:@"%ld人", groupModel.memberCount];
    self.introduction.text = [NSString stringWithFormat:@"简介:%@", groupModel.introduction];
    self.fellowship.text = groupModel.fellowshipName;
}

- (IBAction)joinClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NYSConversationViewController *groupConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_GROUP targetId:[NSString stringWithFormat:@"%ld", self.groupModel.groupId]];
        groupConversationVC.title = self.groupModel.groupName;
        [self.fromViewController.navigationController pushViewController:groupConversationVC animated:YES];
    });
}

@end
