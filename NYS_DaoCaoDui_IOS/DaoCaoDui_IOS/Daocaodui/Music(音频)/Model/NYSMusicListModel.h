//
//  NYSMusicListModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/18.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYSMusicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSMusicListModel : NSObject
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSObject * fel;
@property (nonatomic, assign) NSInteger fellowship;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) NSArray<NYSMusicModel *> * musicList;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSObject * user;
@end

NS_ASSUME_NONNULL_END
