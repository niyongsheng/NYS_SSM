//
//  NYSMagicBoxPresenter.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/15.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMagicBoxPresenter.h"
#import "NYSMagicBoxService.h"

@interface NYSMagicBoxPresenter()

@property (nonatomic, strong) NYSMagicBoxService *magicBoxSerVice;

@end

@implementation NYSMagicBoxPresenter

- (void)fetchData {
    self.magicBoxSerVice = [[NYSMagicBoxService alloc] init];
    [self getMagicBoxDatas];
}

- (void)getMagicBoxDatas {
    [_attachView showIndicator];
    [self.magicBoxSerVice getMagicBoxInfosSuccess:^(NSDictionary *dic) {
        [_attachView hideIndicator];
        NSArray *userArr = [dic valueForKey:@"data"];
        
        if ([self processOriginDataToUIFriendlyData:userArr].count == 0) {
            [_attachView showEmptyView];
        }
        
        [_attachView magicBoxViewDataSource:[self processOriginDataToUIFriendlyData:userArr]];
        
    } andFail:^(NSDictionary *dic) {
        
    }];
}

/**
 如果数据比较复杂，或者UI渲染的数据只是其中很少一部分，将原数据处理，输出成UI渲染的数据。（题外话：这里其实还可以使用协议，提供不同的数据格式输出。）
 
 @param originData 原始数据
 @return 将原始数据转换为UI需要数据
 */
- (NSArray<NYSMagicBoxModel *> *)processOriginDataToUIFriendlyData:(NSArray *)originData {
    return [NYSMagicBoxModel mj_objectArrayWithKeyValuesArray:originData];
}

@end
