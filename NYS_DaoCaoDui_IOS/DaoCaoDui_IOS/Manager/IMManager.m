//
//  IMManager.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "IMManager.h"
#import <RongIMKit/RongIMKit.h>
#import "NYSChatDataSource.h"

@interface IMManager ()

@end

@implementation IMManager

SINGLETON_FOR_CLASS(IMManager);

#pragma mark —- 初始化IM -—
- (void)initRongCloudIM {
    [[RCIM sharedRCIM] initWithAppKey:RCAPPKEY];

    // 设置优先使用WebView打开URL
    [RCIM sharedRCIM].embeddedWebViewPreferred = YES;
    // 开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    // 开启输入状态提醒
    [RCIM sharedRCIM].enableTypingStatus = YES;
    // 开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    // 选择媒体资源时，包含视频文件
    [RCIM sharedRCIM].isMediaSelectorContainVideo = YES;
    // 设置头像为圆形
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    // 离线历史消息（30天）
    [[RCIMClient sharedRCIMClient] setOfflineMessageDuration:30 success:^{
        
    } failure:^(RCErrorCode nErrorCode) {
        
    }];
}

#pragma mark —- IM登录 --
- (void)IMLoginwithCurrentUserInfo:(UserInfo *)currentUserInfo completion:(loginBlock)completion {
//    [self initRongCloudIM];
    
    [[RCIM sharedRCIM] connectWithToken:currentUserInfo.imToken success:^(NSString *userId) {
        NLog(@"登陆成功。当前登录的用户ID：%@", userId);
        // 用户信息提供者
        [RCIM sharedRCIM].userInfoDataSource = [NYSChatDataSource shareInstance];
        [RCIM sharedRCIM].groupInfoDataSource = [NYSChatDataSource shareInstance];
        
        RCUserInfo *RCCurrentUserInfo = [[RCUserInfo alloc] init];
        RCCurrentUserInfo.name = currentUserInfo.nickname;
        RCCurrentUserInfo.portraitUri = currentUserInfo.icon;
        RCCurrentUserInfo.userId = currentUserInfo.account;
        RCCurrentUserInfo.extra = nil;
        
        // 设置当前登录的用户的用户信息
        [[RCIM sharedRCIM] setCurrentUserInfo:RCCurrentUserInfo];
        
    } error:^(RCConnectErrorCode status) {
        NLog(@"IM登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        // token过期或者不正确。
        // 如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        // 如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NLog(@"token错误");
    }];
}

#pragma mark —- IM退出 —-
- (void)IMLogout {
    [[RCIM sharedRCIM] logout];
    [[RCIMClient sharedRCIMClient] disconnect:NO];
}

#pragma mark - 被踢下线处理
// NPostNotification(NNotificationOnKick, nil);

@end
