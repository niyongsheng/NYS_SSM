//
//  NYSGroupCollectionCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/26.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSGroupModel;

NS_ASSUME_NONNULL_BEGIN

@interface NYSGroupCollectionCell : UICollectionViewCell

@property (nonatomic, weak) NYSGroupModel *groupModel;
@property (strong, nonatomic) UIViewController  *fromViewController;

@end

NS_ASSUME_NONNULL_END
