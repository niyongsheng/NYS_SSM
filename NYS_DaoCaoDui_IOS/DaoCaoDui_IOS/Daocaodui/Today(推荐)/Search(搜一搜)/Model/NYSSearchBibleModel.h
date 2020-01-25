//
//  NYSSearchBibleModel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/25.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSSearchBibleModel : NSObject
@property (nonatomic, strong) NSString * bible;
@property (nonatomic, strong) NSString * book;
@property (nonatomic, strong) NSString * chapter;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModify;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * verse;
@property (nonatomic, strong) NSString * version;
@end

NS_ASSUME_NONNULL_END
