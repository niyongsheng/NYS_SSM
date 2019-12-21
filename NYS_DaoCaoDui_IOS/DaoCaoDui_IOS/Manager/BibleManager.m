//
//  BibleManager.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/21.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "BibleManager.h"

@implementation BibleManager

SINGLETON_FOR_CLASS(BibleManager);

- (ONOXMLDocument *)currentbible {
    if (!_currentbible) {
        NSError *error = nil;
        NSString *XMLFilePath = [[NSBundle mainBundle] pathForResource:self.currentBibleVersion ofType:@"xml"];
        NSData *data = [NSData dataWithContentsOfFile:XMLFilePath];
        _currentbible = [ONOXMLDocument XMLDocumentWithData:data error:&error];
        if (error) {
            NLog(@"[Error] %@", error);
            return nil;
        }
    }
    return _currentbible;
}

- (NSString *)currentBibleVersion {
    if (!_currentBibleVersion) {
        _currentBibleVersion = [[NSString alloc] init];
        _currentBibleVersion = [NUserDefaults boolForKey:SettingKey_IsEnBible] ? @"en_kjv" : @"zh_cuv";
    }
    return _currentBibleVersion;
}

/// 刷新当前圣经
- (void)refreshCurrentBible {
    self.currentbible = nil;
    self.currentBibleVersion = nil;
    [self currentbible];
    // 发送圣经版本变更的通知
    [NNotificationCenter postNotificationName:NNotificationBibleVersionChange object:self.currentBibleVersion];
}

/// 加载已下载的圣经列表
/// @param path 本地资源路径
- (NSArray *)loadCurrentDownloadBibleListWithPath:(NSString *)path {
    // TODO
    return nil;
}

@end
