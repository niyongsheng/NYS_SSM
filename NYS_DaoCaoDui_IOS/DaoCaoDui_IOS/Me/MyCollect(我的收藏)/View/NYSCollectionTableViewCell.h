//
//  NYSCollectionTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/17.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSArticleModel.h"
#import "NYSPrayModel.h"
#import "NYSMusicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSCollectionTableViewCell : UITableViewCell
@property (strong, nonatomic) NYSArticleModel *collectionArticleModel;
@property (strong, nonatomic) NYSPrayModel *collectionPrayModel;
@property (strong, nonatomic) NYSMusicModel *collectionMusicModel;

@property (strong, nonatomic) UIViewController *fromController;
@end

NS_ASSUME_NONNULL_END
