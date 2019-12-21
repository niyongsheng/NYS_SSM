//
//  BibleManager.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/21.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NBibleManager [BibleManager sharedBibleManager]

@interface BibleManager : NSObject
/**
 圣经管理单例
 
 @return sharedBibleManager
 */
SINGLETON_FOR_HEADER(BibleManager)

/// 圣经
@property (nonatomic, strong) ONOXMLDocument *currentbible;

/// 当前圣经版本
@property (nonatomic, strong) NSString *currentBibleVersion;

/// 刷新当前圣经
- (void)refreshCurrentBible;

/// 加载已下载的圣经列表
/// @param path 本地资源路径
- (NSArray *)loadCurrentDownloadBibleListWithPath:(NSString *)path;

@end
