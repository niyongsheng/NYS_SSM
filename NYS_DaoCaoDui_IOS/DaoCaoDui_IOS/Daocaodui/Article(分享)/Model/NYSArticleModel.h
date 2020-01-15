//
//  NYSArticleModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/12.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
NS_ASSUME_NONNULL_BEGIN

@interface NYSArticleModel : NSObject
@property (nonatomic, strong) NSString * account;
/// 文章类型 ：1普通 2转载
@property (nonatomic, assign) NSInteger articleType;
@property (nonatomic, strong) NSString * articleUrl;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSObject * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * fellowshipName;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UserInfo * user;
@property (nonatomic, strong) NSArray<UserInfo *> * collectionUserList;
@end

NS_ASSUME_NONNULL_END
