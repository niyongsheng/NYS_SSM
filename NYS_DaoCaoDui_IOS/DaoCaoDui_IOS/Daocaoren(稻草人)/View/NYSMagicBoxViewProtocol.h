//
//  NYSMagicBoxViewProtocol.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/15.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMagicBoxModel.h"

@protocol NYSMagicBoxViewProtocol <NSObject>

- (void)magicBoxViewDataSource:(NSArray<NYSMagicBoxModel *> *)data;

- (void)showIndicator;

- (void)hideIndicator;

- (void)showEmptyView;

@end
