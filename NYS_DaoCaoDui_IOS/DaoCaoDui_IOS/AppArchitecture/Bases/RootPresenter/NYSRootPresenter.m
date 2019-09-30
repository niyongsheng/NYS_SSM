//
//  NYSRootPresenter.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/15.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSRootPresenter.h"

@implementation NYSRootPresenter

/**
 初始化函数
 */
- (instancetype)initWithView:(id)attachView {
    
    if (self = [super init]) {
        _attachView = attachView;
    }
    return self;
}

/**
 * 绑定视图
 * @param attachView 要绑定的视图
 */
- (void)attachView:(id)attachView {
    _attachView = attachView;
}

/**
 解绑视图
 */
- (void)detachAttachView {
    _attachView = nil;
}

@end
