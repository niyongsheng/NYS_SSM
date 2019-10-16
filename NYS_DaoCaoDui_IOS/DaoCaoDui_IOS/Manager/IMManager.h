//
//  IMManager.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

typedef void (^loginBlock)(BOOL success, id _Nullable description);

NS_ASSUME_NONNULL_BEGIN

@interface IMManager : NSObject

SINGLETON_FOR_HEADER(IMManager);

/** 初始化IM */
- (void)initRongCloudIM;

/// IM登录
/// @param currentUserInfo 当前登录的用户
/// @param completion 回调
- (void)IMLoginwithCurrentUserInfo:(UserInfo *)currentUserInfo completion:(loginBlock)completion;

/** 退出IM */
- (void)IMLogout;

@end

NS_ASSUME_NONNULL_END
