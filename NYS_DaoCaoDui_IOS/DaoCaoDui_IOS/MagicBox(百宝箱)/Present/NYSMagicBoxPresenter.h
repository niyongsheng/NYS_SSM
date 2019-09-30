//
//  NYSMagicBoxPresenter.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/15.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSRootPresenter.h"
#import "NYSMagicBoxViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSMagicBoxPresenter<E> : NYSRootPresenter<E>

/**
 这个是对外的入口，通过这个入口，实现多个对内部的操作，外部只要调用这个接口就可以了
 */
- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
