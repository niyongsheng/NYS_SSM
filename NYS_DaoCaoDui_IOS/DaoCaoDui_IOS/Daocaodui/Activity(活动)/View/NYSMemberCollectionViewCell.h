//
//  NYSMemberCollectionViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/2.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfo;

NS_ASSUME_NONNULL_BEGIN

@interface NYSMemberCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) UserInfo *memberModel;
@end

NS_ASSUME_NONNULL_END
