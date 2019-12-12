//
//  QMHACCollectionViewCell.h
//  安居公社
//
//  Created by 倪永胜 on 2019/10/23.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMHCommunityActivityList;

NS_ASSUME_NONNULL_BEGIN

@interface QMHACCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) QMHCommunityActivityList *collectionModel;

@property (strong, nonatomic) UIViewController  *fromViewController;

@end

NS_ASSUME_NONNULL_END
