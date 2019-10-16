//
//  UserInfo.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/31.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
   // 映射可以设定多个映射字段
//  return @{@"ID":@[@"id",@"uid",@"ID"]};
}
@end
