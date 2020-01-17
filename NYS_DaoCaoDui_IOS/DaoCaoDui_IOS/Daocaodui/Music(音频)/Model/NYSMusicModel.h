//
//  NYSMusicModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/18.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;
NS_ASSUME_NONNULL_BEGIN

@interface NYSMusicModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * anAuthor;
@property (nonatomic, strong) NSString * expireTime;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) NSString * lyric;
@property (nonatomic, assign) NSInteger musicType;
@property (nonatomic, strong) NSString * musicUrl;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * singer;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) BOOL isCollection;
@property (nonatomic, strong) NSString * wordAuthor;
@property (nonatomic, strong) UserInfo * user;
@end

NS_ASSUME_NONNULL_END
