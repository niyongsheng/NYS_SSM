//
//  NYSMyPublishTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSArticleModel.h"
#import "NYSPrayModel.h"
#import "NYSMusicModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NYSMyPublishTableViewCellDelegate <NSObject>
 @optional
 - (void)deleteItemButton:(NSInteger)index;
 @end
@interface NYSMyPublishTableViewCell : UITableViewCell
@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) NYSArticleModel *collectionArticleModel;
@property (weak, nonatomic) NYSPrayModel *collectionPrayModel;
@property (weak, nonatomic) NYSMusicModel *collectionMusicModel;

@property (weak, nonatomic) id<NYSMyPublishTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
