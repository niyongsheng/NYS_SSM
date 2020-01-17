//
//  NYSPrayModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
NS_ASSUME_NONNULL_BEGIN

@interface NYSPrayModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSObject * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * fellowshipName;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSObject * gmtModify;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) NSInteger prayType;
@property (nonatomic, strong) NSObject * prayUrl;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) BOOL isCollection;
@property (nonatomic, strong) UserInfo * user;
@property (nonatomic, strong) NSArray<UserInfo *> * collectionUserList;
@end

NS_ASSUME_NONNULL_END
