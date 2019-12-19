//
//  NYSMeTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/1.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSMeModel;

NS_ASSUME_NONNULL_BEGIN

@interface NYSMeTableViewCell : UITableViewCell

@property(nonatomic, weak) NYSMeModel *cellData;

@end

NS_ASSUME_NONNULL_END
