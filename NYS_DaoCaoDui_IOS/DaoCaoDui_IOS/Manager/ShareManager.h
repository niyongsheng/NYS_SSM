//
//  ShareManager.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareManager : NSObject
// 单例
SINGLETON_FOR_HEADER(ShareManager)


/** 分享页面弹框 */
- (void)showShareView;

@end

NS_ASSUME_NONNULL_END
