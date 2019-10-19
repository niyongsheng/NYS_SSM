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
    RCGroup *groupInfo = [RCGroup new];
    
    // 拼接请求参数
//    [NYSRequest DataProviderInfoForGroupWithResMethod:GET parameters: success:^(id response) {
//        <#code#>
//    } failure:^(NSError *error) {
//        <#code#>
//    } isCache:YES];
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//
//    // url
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/communityActivity/getCommunityActivitiesGroupInfo",POSTURL];
//    NLog(@"requestUrl = %@",requestUrl);
//    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NLog(@"请求成功JSON:%@", JSON);
//        NSString * success = [NSString stringWithFormat:@"%@",JSON[@"success"]];
//        if ([success isEqualToString:@"1"]) {
//            NSDictionary * dic = JSON[@"returnValue"];
//            if (dic != nil) {
//                groupInfo.groupId = dic[@"groupId"];
//                groupInfo.groupName = dic[@"name"];
//                groupInfo.portraitUri = dic[@"image"];
//                completion(groupInfo);
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NLog(@"请求失败:%@", error.description);
//    }];
}

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    RCUserInfo *rcUserInfo = [RCUserInfo new];
    
    // 拼接请求参数
    [NYSRequest DataProviderInfoForUserWithResMethod:GET parameters:@{@"account" : [UserManager sharedUserManager].currentUserInfo.imToken} success:^(id response) {
        rcUserInfo.userId = [[response objectForKey:@"data"] objectForKey:@"account"];
        rcUserInfo.name = [[response objectForKey:@"data"] objectForKey:@"nickname"];
        rcUserInfo.portraitUri = [[response objectForKey:@"data"] objectForKey:@"icon"];
        completion(rcUserInfo);
    } failure:^(NSError *error) {
        
    } isCache:YES];
}


@end
