//
//  NYSRankingListTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/3.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSActivityModel;

NS_ASSUME_NONNULL_BEGIN

@interface NYSRankingTableViewCell : UITableViewCell
@property (weak, nonatomic) NYSActivityModel *activityModel;
@end

NS_ASSUME_NONNULL_END
