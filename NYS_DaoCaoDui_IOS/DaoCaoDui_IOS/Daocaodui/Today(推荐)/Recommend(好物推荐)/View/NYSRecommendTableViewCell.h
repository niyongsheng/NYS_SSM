//
//  NYSRecommendTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/7.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSRecommendModel;

NS_ASSUME_NONNULL_BEGIN

@interface NYSRecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) NYSRecommendModel *recommendModel;
@end

NS_ASSUME_NONNULL_END
