//
//  NYSScorelogModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/6.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSScorelogModel : NSObject

@property (nonatomic, strong) NSString * account;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, assign) NSInteger idField;
//@property (nonatomic, strong) NSObject * inout;
@property (nonatomic, strong) NSString * orderId;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
