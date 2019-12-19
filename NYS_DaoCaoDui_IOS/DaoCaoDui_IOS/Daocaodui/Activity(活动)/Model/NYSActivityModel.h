//
//  NYSActivityModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSActivityModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * fellowshipName;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) BOOL status;
@end

NS_ASSUME_NONNULL_END
