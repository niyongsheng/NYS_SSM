//
//  NYSDataSource.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/16.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSChatDataSource.h"
#import "NYSGroupModel.h"
#import "UserInfo.h"

#define SigleIcon @"http://image.daocaodui.top/config/icon/chat_single.png"
#define GroupIcon @"http://image.daocaodui.top/config/icon/chat_group.png"

@implementation NYSChatDataSource

+ (NYSChatDataSource *)shareInstance {
    static NYSChatDataSource *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion {
    [NYSRequest DataProviderInfoForUserWithResMethod:GET
                                          parameters:@{@"account" : userId}
                                             success:^(id response) {
        UserInfo *userInfo = [UserInfo mj_objectWithKeyValues:[response objectForKey:@"data"]];
        RCUserInfo *rcUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:userInfo.nickname portrait:userInfo.icon];
        rcUserInfo.extra = [NSString stringWithFormat:@"%ld", (long)userInfo.fellowship];
        completion(rcUserInfo);
    } failure:^(NSError *error) {
        completion([[RCUserInfo alloc] initWithUserId:userId name:@"User" portrait:SigleIcon]);
    } isCache:YES];
}

#pragma mark - GroupInfoFetcherDelegate
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion {
    [NYSRequest DataProviderInfoForGroupWithResMethod:GET
                                           parameters:@{@"groupId" : groupId}
                                              success:^(id response) {
        NYSGroupModel *groupModel = [NYSGroupModel mj_objectWithKeyValues:[response objectForKey:@"data"]];
        RCGroup *groupInfo = [[RCGroup alloc] initWithGroupId:groupId groupName:groupModel.groupName portraitUri:groupModel.groupIcon];
        completion(groupInfo);
    } failure:^(NSError *error) {
        completion([[RCGroup alloc] initWithGroupId:groupId groupName:@"Group" portraitUri:GroupIcon]);
    } isCache:YES];
}

#pragma mark - RCIMGroupMembersDataSource
- (void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock {
    NSMutableArray<NSString *> *accountsArray = [NSMutableArray array];
    [NYSRequest DataProviderInfoForGroupMembersWithResMethod:GET
                                                  parameters:@{@"groupId" : groupId}
                                                     success:^(id response) {
        NSArray *usersArray = [UserInfo mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        for (UserInfo *user in usersArray) {
            [accountsArray addObject:user.account];
        }
        resultBlock(accountsArray);
    } failure:^(NSError *error) {
        resultBlock(accountsArray);
    } isCache:YES];
}

@end
