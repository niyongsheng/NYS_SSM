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
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setGroupModel:(NYSGroupModel *)groupModel {
    _groupModel = groupModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:groupModel.groupIcon] placeholderImage:[UIImage imageNamed:@"logo_60x60"]];
    self.name.textColor = groupModel.isTop ? [UIColor redColor] : [UIColor blackColor];
    self.name.text = groupModel.groupName;
    self.memberCount.text = [NSString stringWithFormat:@"%ld/2000", groupModel.memberCount];
    self.introduction.text = groupModel.description;
    self.fellowship.text = [NSString stringWithFormat:@"%ld", groupModel.fellowship];
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
