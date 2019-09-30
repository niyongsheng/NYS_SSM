//
//  NYSMagicBoxService.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/15.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMagicBoxService.h"

@implementation NYSMagicBoxService

- (void)getMagicBoxInfosSuccess:(SuccessHandler)success andFail:(FailHandler)fail {
    NSArray *result = @[@{@"title":@"Tom",
                          @"detail":@"DaoCaoDui_IOS",
                          @"iconUrl":@"https://raw.githubusercontent.com/niyongsheng/DaoCaoDui_IOS/master/logo.png",
                          },
                        @{@"title":@"Jerry",
                          @"detail":@"DaoCaoDui_IOS",
                          @"iconUrl":@"https://raw.githubusercontent.com/niyongsheng/DaoCaoDui_IOS/master/logo.png",
                          },
                        @{@"title":@"Lucy",
                          @"detail":@"DaoCaoDui_IOS",
                          @"iconUrl":@"https://raw.githubusercontent.com/niyongsheng/DaoCaoDui_IOS/master/logo.png",
                          },
                        @{@"title":@"John",
                          @"detail":@"DaoCaoDui_IOS",
                          @"iconUrl":@"https://raw.githubusercontent.com/niyongsheng/DaoCaoDui_IOS/master/logo.png"
                          }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        success(@{@"data":result});
    });
}

@end
