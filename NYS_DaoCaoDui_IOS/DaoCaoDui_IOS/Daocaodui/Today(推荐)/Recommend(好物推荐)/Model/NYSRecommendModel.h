//
//  NYSRecommendModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/7.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
NS_ASSUME_NONNULL_BEGIN

@interface NYSRecommendModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSObject * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSObject * gmtModify;
@property (nonatomic, strong) NSString * iconUrl;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * targetUrl;
@property (nonatomic, strong) UserInfo * user;
@end

NS_ASSUME_NONNULL_END
