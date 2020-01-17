//
//  NYSMusicModel.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/18.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMusicModel.h"

@implementation NYSMusicModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"user" : @"UserInfo"
    };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField" : @"id"};
}
@end
