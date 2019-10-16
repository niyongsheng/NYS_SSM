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
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 拼接请求参数
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
//    parames[@"account"] = [userdefaults objectForKey:@"account"];
//    parames[@"token"] = [userdefaults objectForKey:@"token"];
//    parames[@"groupId"]  = groupId;
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
    RCUserInfo *user = [RCUserInfo new];
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 拼接请求参数
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
//    parames[@"account"] = [userdefaults objectForKey:@"account"];
//    parames[@"token"] = [userdefaults objectForKey:@"token"];
//    parames[@"staffAccount"]  = userId;
//
//    // url
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/getStaffInfo",POSTURL];
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
//                user.userId = dic[@"staffAccount"];
//                switch ([dic[@"type"] integerValue]) {
//                    case 1:
//                        user.name = [NSString stringWithFormat:@"经理-%@", dic[@"trueName"]];
//                        break;
//                    case 2:
//                        user.name = [NSString stringWithFormat:@"客服-%@", dic[@"trueName"]];
//                        break;
//                    case 3:
//                        user.name = [NSString stringWithFormat:@"维修工-%@", dic[@"trueName"]];
//                        break;
//                    case 4:
//                        user.name = [NSString stringWithFormat:@"保洁-%@", dic[@"trueName"]];
//                        break;
//
//                    default:
//                        break;
//                }
//
//                user.portraitUri = dic[@"imgAddress"];
//                completion(user);
//            }
//        } else {
//            NLog(@"QMHPChatDataSource error:%@", [JSON objectForKey:@"error"]);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NLog(@"QMHPChatDataSource网络错误:%@", error.description);
//    }];
}


@end
