//
//  NYSMusicTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/17.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSMusicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSMusicTableViewCell : UITableViewCell
@property (weak, nonatomic) NYSMusicModel *musicModel;
@property (strong, nonatomic) UIViewController *fromViewController;
@end

NS_ASSUME_NONNULL_END
