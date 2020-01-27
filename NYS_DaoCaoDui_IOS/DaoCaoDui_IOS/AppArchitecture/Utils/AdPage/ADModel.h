//
//  ADModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/26.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * advertisementUrl;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic, strong) NSString * targetUrl;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
