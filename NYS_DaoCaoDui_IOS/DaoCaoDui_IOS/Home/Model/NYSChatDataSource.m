//
//  NYSDataSource.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/16.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSChatDataSource.h"

@implementation NYSChatDataSource

+ (NYSChatDataSource *)shareInstance {
    static NYSChatDataSource *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - GroupInfoFetcherDelegate
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion; {
    [NYSRequest DataProviderInfoForGroupWithResMethod:GET parameters:@{@"groupId" : groupId} success:^(id response) {
        RCGroup *rcGroupInfo = [RCGroup new];
        rcGroupInfo.groupId = [[response objectForKey:@"data"] objectForKey:@"groupId"];
        rcGroupInfo.groupName = [[response objectForKey:@"data"] objectForKey:@"groupName"];
        rcGroupInfo.portraitUri = [[response objectForKey:@"data"] objectForKey:@"groupIcon"];
        completion(rcGroupInfo);
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    [NYSRequest DataProviderInfoForUserWithResMethod:GET parameters:@{@"account" : userId} success:^(id response) {
        RCUserInfo *rcUserInfo = [RCUserInfo new];
        rcUserInfo.userId = [[response objectForKey:@"data"] objectForKey:@"account"];
        rcUserInfo.name = [[response objectForKey:@"data"] objectForKey:@"nickname"];
        rcUserInfo.portraitUri = [[response objectForKey:@"data"] objectForKey:@"icon"];
        rcUserInfo.extra = [[response objectForKey:@"data"] objectForKey:@"fellowship"];
        completion(rcUserInfo);
    } failure:^(NSError *error) {
        
    } isCache:YES];
}


@end
