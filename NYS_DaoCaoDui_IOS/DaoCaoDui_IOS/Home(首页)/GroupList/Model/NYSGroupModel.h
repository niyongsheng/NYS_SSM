//
//  NYSGroupModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/26.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYSGroupModel : NSObject
@property (nonatomic, strong) NSString * creator;
@property (nonatomic, strong) NSString * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * fellowshipName;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, strong) NSString * groupIcon;
@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString * groupName;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isBan;
@property (nonatomic, assign) BOOL isVerify;
@property (nonatomic, assign) NSInteger memberCount;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) BOOL isTop;

@end

