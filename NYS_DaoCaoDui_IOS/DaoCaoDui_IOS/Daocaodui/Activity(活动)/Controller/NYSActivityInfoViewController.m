//
//  NYSActivityInfoViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/2.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSActivityInfoViewController.h"
#import "NYSUploadImageHeaderView.h"
#import "NYSButtonFooterView.h"
#import "NYSContentTableViewCell.h"
#import "NYSMembersViewController.h"
#import "NYSAlert.h"

@interface NYSActivityInfoViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NYSUploadImageHeaderView *_headerView;
    NYSButtonFooterView *_footerView;
}
@property (strong, nonatomic) UIImageView *bgimageView;

@end

@implementation NYSActivityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"活动详情"];
    
    [self initUI];
}

- (void)initUI {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight + SegmentViewHeight, 0);
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 65.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor clearColor];
    // header
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSUploadImageHeaderView" owner:self options:nil] objectAtIndex:0];
    _headerView.bgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.activityModel.icon]]];
    _headerView.uploadTitle.text = @"活动封面";
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, 200);
    [self.tableView setTableHeaderView:_headerView];
    // footer
    if ([self.activityModel.account isEqualToString:NCurrentUser.account]) {
        _footerView = [[NYSButtonFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"结束活动"];
        [_footerView buttonForSendData:self action:@selector(footerDismissButtonClicked:)];
    } else if (self.activityModel.isInGroup) {
        _footerView = [[NYSButtonFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"退出活动"];
        [_footerView buttonForSendData:self action:@selector(footerQuitButtonClicked:)];
    } else {
        _footerView = [[NYSButtonFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"报名活动"];
        [_footerView buttonForSendData:self action:@selector(footerJoinButtonClicked:)];
    }
    [self.tableView setTableFooterView:_footerView];
    
    [self.view addSubview:self.bgimageView];
    [self.view addSubview:self.tableView];
}

#pragma mark - lazy load
- (UIImageView *)bgimageView {
    if (!_bgimageView) {
        _bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
        _bgimageView.contentMode = UIViewContentModeScaleToFill;
        _bgimageView.image = [UIImage imageWithColor:[UIColor whiteColor]];
        // Blur effect
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, _bgimageView.frame.size.width, _bgimageView.frame.size.height);
        [_bgimageView addSubview:effectView];
    }
    return _bgimageView;
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"活动名称：";
            cell.detailTextLabel.text = self.activityModel.name;
        }
            break;
            
        case 1: {
            cell.textLabel.text = @"活动类型：";
            if (self.activityModel.activityType == 1) {
                cell.detailTextLabel.text = @"普通活动";
            } else if (self.activityModel.activityType == 2) {
                cell.detailTextLabel.text = @"打卡活动";
            }
        }
            break;
            
        case 2: {
            NYSContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"NYSContentTableViewCell"];
            if(contentCell == nil) {
                contentCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSContentTableViewCell" owner:self options:nil] firstObject];
            }
            contentCell.title.text = @"活动介绍：";
            contentCell.contentTextView.text = self.activityModel.introduction;
            contentCell.contentTextView.textAlignment = NSTextAlignmentRight;
            contentCell.contentTextView.textColor = [UIColor grayColor];
            contentCell.contentTextView.userInteractionEnabled = NO;
            return contentCell;
        }
            break;
            
        case 3: {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"创建者：";
            cell.detailTextLabel.text = self.activityModel.account;
        }
            break;
            
        case 4: {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"活动成员：";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld人", self.activityModel.userList.count];
        }
            break;
            
        case 5: {
            cell.textLabel.text = @"活动群组：";
            if (self.activityModel.groupId) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.activityModel.groupId];
            } else {
                cell.detailTextLabel.text = @"未创建活动群组";
            }
        }
            break;
            
        case 6: {
            cell.textLabel.text = @"过期时间：";
            if (self.activityModel.expireTime) {
                cell.detailTextLabel.text = self.activityModel.expireTime;
            } else {
                cell.detailTextLabel.text = @"未设置过期时间";
            }
        }
            break;
        
        case 7: {
            cell.textLabel.text = @"创建时间：";
            cell.detailTextLabel.text = self.activityModel.gmtCreate;
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) {
        NYSMembersViewController *membersVC = NYSMembersViewController.new;
        membersVC.memberListArray = self.activityModel.userList;
        [self.navigationController pushViewController:membersVC animated:YES];
    }
    
}

/// 报名活动
- (void)footerJoinButtonClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    WS(weakSelf);
    [NYSRequest JoinActivityWithActivityID:GET
                                   parameters:@{@"activityID" : @(self.activityModel.ID)}
                                      success:^(id response) {
        [NYSAlert showSuccessAlertWithTitle:@"活动报名" message:@"恭喜你^^报名成功啦！" okButtonClickedBlock:^{
            [NNotificationCenter postNotificationName:@"RefreshActivityListNotification" object:nil];
        }];
    } failure:^(NSError *error) {
        
    }];
}

/// 退出活动
- (void)footerQuitButtonClicked:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出当前活动吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        WS(weakSelf);
        [NYSRequest QuitActivityWithActivityID:GET
                                       parameters:@{@"activityID" : @(self.activityModel.ID)}
                                          success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"退出活动"];
                [SVProgressHUD dismissWithDelay:1.f];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [NNotificationCenter postNotificationName:@"RefreshActivityListNotification" object:nil];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

/// 解散活动
- (void)footerDismissButtonClicked:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要结束当前活动吗？" message:@"活动群组将被解散，活动信息将被清空且不可恢复！" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        WS(weakSelf);
        [NYSRequest DismissActivityWithActivityID:GET
                                       parameters:@{@"activityID" : @(self.activityModel.ID)}
                                          success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"活动结束"];
                [SVProgressHUD dismissWithDelay:1.f];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [NNotificationCenter postNotificationName:@"RefreshActivityListNotification" object:nil];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
