//
//  NYSRankingListViewController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRootViewController.h"
#import "NYSActivityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSRankingListViewController : NYSRootViewController
@property(strong, nonatomic) NYSActivityModel *activityDatasource;
@property(assign, nonatomic) BOOL isClocked;
@end

NS_ASSUME_NONNULL_END
