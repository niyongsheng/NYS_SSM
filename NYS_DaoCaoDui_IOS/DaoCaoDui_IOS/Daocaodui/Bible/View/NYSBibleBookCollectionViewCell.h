//
//  NYSBibleBookCollectionViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSBibleBookCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) NSString *titleString;
@property (nonatomic, weak) NSString *subtitleString;
@property (nonatomic, weak) UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END
