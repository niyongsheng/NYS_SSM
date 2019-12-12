//
//  NYSBannerModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/12.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSBannerModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * bannerUrl;
@property (nonatomic, strong) NSString * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * fellowshipName;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * targetUrl;
@property (nonatomic, strong) NSString * title;
@end

NS_ASSUME_NONNULL_END
