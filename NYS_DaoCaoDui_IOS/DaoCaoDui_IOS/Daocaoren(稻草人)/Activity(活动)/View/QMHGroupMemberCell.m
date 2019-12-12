//
//  QMHGroupMemberCell.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/29.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHGroupMemberCell.h"
#import <Masonry.h>
#import "NSArray+NYS.h"
#import "QMHMemberView.h"
#import "NYSConversationViewController.h"
#import "QMHMemberModel.h"
#import "QMHMemberListCollectionVC.h"

#define ROW_HEI 100

NSString *const XLFormRowDescriptorTypeGroupMemberView = @"XLFormRowDescriptorTypeGroupMemberView";

@interface QMHGroupMemberCell ()
@property (nonatomic, strong) NSArray *membersArray;
@end

@implementation QMHGroupMemberCell

+ (void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([QMHGroupMemberCell class]) forKey:XLFormRowDescriptorTypeGroupMemberView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configure {
    [super configure];
}

- (void)update {
    [super update];
    
    self.membersArray = self.rowDescriptor.value;
    [self initWithArray:self.rowDescriptor.value];
    
    // 防止提交表单崩溃
    self.rowDescriptor.value = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark — 初始化页面
- (void)initWithArray:(NSArray *)dataArray {
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"群成员"];
    [titleLabel setTextColor:[UIColor grayColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    
    UIImageView *image = [[UIImageView alloc] init];
    [image setImage:[UIImage imageNamed:@"右箭头"]];
    [self.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(7, 12));
        make.centerY.mas_equalTo(titleLabel);
    }];
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setTitle:@"查看更多群成员" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(image.mas_left).offset(-3);
    }];
    
    
    
    // 创建一个装载视图的容器
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    containerView.backgroundColor = [UIColor clearColor];
//    containerView.layer.borderWidth = 1;
//    containerView.layer.borderColor = [UIColor grayColor].CGColor;
    
    // 给该容器添加布局代码
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    // 为该容器添加宫格View
    CGFloat arrayCount = dataArray.count;
    if (arrayCount < 1) {
        return;
    }
    for (int i = 0; i < arrayCount; i++) {
        QMHMemberView *view = [QMHMemberView memberView];
        view.memberModel = dataArray[i];
        view.iconTag = i;
        [view buttonForSendData:self action:@selector(memberIconClick:)];
        [containerView addSubview:view];
    }
    
    // 执行布局
    [containerView.subviews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:0 fixedLineSpacing:5 fixedInteritemSpacing:5 warpCount:5 topSpacing:5 bottomSpacing:5 leadSpacing:0 tailSpacing:0];
}

//+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
//    return 300;
//}

/// 查看更多群成员
- (void)moreBtnClicked {
    QMHMemberListCollectionVC *mlVC = [[QMHMemberListCollectionVC alloc] init];
    mlVC.groupID = [(QMHMemberModel *)[self.membersArray firstObject] gid];
    [self.formViewController.navigationController pushViewController:mlVC animated:YES];
}

///  发起私聊
- (void)memberIconClick:(UIButton *)sender {
    QMHMemberModel *mm = (QMHMemberModel *)self.membersArray[sender.tag];
    NYSConversationViewController *groupConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:mm.member];
    groupConversationVC.title = mm.nickName;
    [self.formViewController.navigationController pushViewController:groupConversationVC animated:YES];
}

@end
