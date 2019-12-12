//
//  QMHMemberCollectionViewCell.h
//  安居公社
//
//  Created by 倪永胜 on 2019/10/30.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMHMemberModel;

NS_ASSUME_NONNULL_BEGIN

@interface QMHMemberCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) QMHMemberModel *collectionModel;

@property (strong, nonatomic) UIViewController  *fromViewController;
@end

NS_ASSUME_NONNULL_END
