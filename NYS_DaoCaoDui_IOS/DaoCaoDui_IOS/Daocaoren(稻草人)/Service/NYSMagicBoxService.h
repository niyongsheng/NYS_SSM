//
//  NYSMagicBoxService.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/15.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessHandler)(NSDictionary *dict);
typedef void(^FailHandler)(NSDictionary *dict);

@interface NYSMagicBoxService : NSObject

- (void)getMagicBoxInfosSuccess:(SuccessHandler)success andFail:(FailHandler)fail;

@end

NS_ASSUME_NONNULL_END
