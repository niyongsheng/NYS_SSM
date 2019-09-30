//
//  IMManager.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^loginBlock)(BOOL success, id _Nullable description);

NS_ASSUME_NONNULL_BEGIN

@interface IMManager : NSObject

SINGLETON_FOR_HEADER(IMManager);

/** 初始化IM */
-(void)initIM;

/**
 登录IM
 
 @param IMID IM账号
 @param IMPwd IM密码
 @param completion block回调
 */
- (void)IMLogin:(NSString *)IMID IMPwd:(NSString *)IMPwd completion:(loginBlock)completion;

/** 退出IM */
- (void)IMLogout;

@end

NS_ASSUME_NONNULL_END
