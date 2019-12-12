//
//  CRGroupCardViewController.m
//  28ChatRoom
//
//  Created by 倪永胜 on 2018/12/17.
//  Copyright © 2018 qingmai. All rights reserved.
//

#import "QMHGroupCardViewController.h"
#import "NYSDisplayIconCell.h"
#import "QMHLeftTextCell.h"
#import "NYSConversationViewController.h"
#import "QMHCommunityActivityDetail.h"
#import "QMHGroupMemberCell.h"
#import "QMHMemberModel.h"

#define ROW_HEIGHT 50

@interface QMHGroupCardViewController ()
@property(nonatomic, strong) QMHCommunityActivityDetail *activityDetail;
/** 群成员 */
@property(nonatomic, copy) NSArray *memberData;

@end

@implementation QMHGroupCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self getActivityDetail];
}
 
- (void)getActivityDetail {
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    parames[@"account"]  =  [userdefaults objectForKey:@"account"];
    parames[@"token"] = [userdefaults objectForKey:@"token"];
    parames[@"id"] = self.aID;
    WS(weakSelf);
//    [QMHNetworkingRequestLayer requestWithAPI:@"/api/activity/getActivity" parameters:parames success:^(id response) {
//        NSDictionary *dict = [response objectForKey:@"returnValue"];
//        [QMHCommunityActivityDetail mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"ID" : @"id"};
//        }];
//        weakSelf.activityDetail = [QMHCommunityActivityDetail mj_objectWithKeyValues:dict];
//        [QMHMemberModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"ID" : @"id"};
//        }];
//        weakSelf.memberData = [QMHMemberModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"list"]];
//        [self teamCardXLForm];
//    } failure:^(NSError *error) {
//        NLog(@"网络错误:%@", error);
//    } showLoadingStatusMessages:nil isCache:NO];
}

- (void)teamCardXLForm {
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormRowDescriptor *row;
    // 1、头像图片
//    XLFormSectionDescriptor *section1 = [XLFormSectionDescriptor formSectionWithTitle:@" "];
//    [form addFormSection:section1];
//    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:@"imagesDisplay" rowType:XLFormRowDescriptorTypeDisplayIcon];
//    row.value = self.activityDetail.imgAddress;
//    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"contentView.backgroundColor"];
//    [section1 addFormRow:row];
    // 2、群成员
    XLFormSectionDescriptor *section2 = [XLFormSectionDescriptor formSectionWithTitle:@"基本信息"];
    [form addFormSection:section2];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"groupMembers" rowType:XLFormRowDescriptorTypeGroupMemberView title:@"群成员"];
    row.value = self.memberData;
    if (self.memberData.count % 5 == 0) {
        row.height = (self.memberData.count / 5) * 80 + 30;
    } else {
        row.height = (self.memberData.count / 5 + 1) * 80 + 30;
    }
    [section2 addFormRow:row];
    // 3、群昵称
    XLFormSectionDescriptor *section3 = [XLFormSectionDescriptor formSectionWithTitle:@" "];
    [form addFormSection:section3];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"nickName" rowType:XLFormRowDescriptorTypeName title:@"群名称"];
    row.height = ROW_HEIGHT;
    row.value = self.activityDetail.title;
    row.disabled = @(YES);
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section3 addFormRow:row];
    // 4、群简介
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"intro" rowType:XLFormRowDescriptorTypeTextView title:@"群简介"];
    row.value = self.activityDetail.content;
    row.disabled = @(YES);
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textView.textAlignment"];
    [section3 addFormRow:row];
    // 5、群主
    XLFormSectionDescriptor *section4 = [XLFormSectionDescriptor formSectionWithTitle:@" "];
    [form addFormSection:section4];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"owner" rowType:XLFormRowDescriptorTypeName title:@"群主"];
    row.height = ROW_HEIGHT;
    row.value = self.activityDetail.nickName;
    row.disabled = @(YES);
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section4 addFormRow:row];
    // 6、ID
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ID" rowType:XLFormRowDescriptorTypeName title:@"群ID"];
    row.height = ROW_HEIGHT;
    row.value = self.activityDetail.groupId;
    row.disabled = @(YES);
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section4 addFormRow:row];
    // 7、创建时间
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"creatTime" rowType:XLFormRowDescriptorTypeName title:@"创建于"];
    row.height = ROW_HEIGHT;
    row.value = self.activityDetail.gmtCreate;
    row.disabled = @(YES);
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section4 addFormRow:row];
    // 8、加入群聊
    if (!self.inGroup) {
        XLFormSectionDescriptor *section5 = [XLFormSectionDescriptor formSectionWithTitle:@" "];
        [form addFormSection:section5];
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"joinGroup" rowType:XLFormRowDescriptorTypeButton title:@"加入群聊"];
        row.height = ROW_HEIGHT;
        [row.action setFormBlock:^(XLFormRowDescriptor * _Nonnull sender) {
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
            parames[@"account"]  =  [userdefaults objectForKey:@"account"];
            parames[@"token"] = [userdefaults objectForKey:@"token"];
            parames[@"id"] = self.aID;
//            [QMHNetworkingRequestLayer requestWithAPI:@"/api/activity/joinGroup" parameters:parames success:^(id response) {
//                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"msg"]];
//                [SVProgressHUD dismissWithDelay:1.f completion:^{
//                    NYSConversationViewController *groupConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_GROUP targetId:self.groupId];
//                    groupConversationVC.title = [userdefaults objectForKey:@"nickName"];
//                    [self.navigationController pushViewController:groupConversationVC animated:YES];
//                }];
//            } failure:^(NSError *error) {
//                NLog(@"网络错误:%@", error);
//            } showLoadingStatusMessages:nil isCache:NO];
        }];
        [section5 addFormRow:row];
    } else {
        XLFormSectionDescriptor *section5 = [XLFormSectionDescriptor formSectionWithTitle:@" "];
        [form addFormSection:section5];
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"quitGroup" rowType:XLFormRowDescriptorTypeButton title:@"退出群聊"];
        row.height = ROW_HEIGHT;
        [row.action setFormBlock:^(XLFormRowDescriptor * _Nonnull sender) {
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
            parames[@"account"]  =  [userdefaults objectForKey:@"account"];
            parames[@"token"] = [userdefaults objectForKey:@"token"];
            parames[@"id"] = self.aID;
//            [QMHNetworkingRequestLayer requestWithAPI:@"/api/activity/quitGroup" parameters:parames success:^(id response) {
//                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"msg"]];
//                [SVProgressHUD dismissWithDelay:1.f completion:^{
//                    [self.navigationController popViewControllerAnimated:YES];
//                }];
//            } failure:^(NSError *error) {
//                NLog(@"网络错误:%@", error);
//            } showLoadingStatusMessages:nil isCache:NO];
        }];
        [section5 addFormRow:row];
    }
    self.form = form;
}



#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

#pragma mark - XLFormDescriptorDelegate
- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue {
    [super formRowDescriptorValueHasChanged:formRow oldValue:oldValue newValue:newValue];
    NLog(@"oldValue:%@  newValue:%@-class:%@", oldValue, newValue, [newValue class]);
}

@end
