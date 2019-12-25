//
//  NYSInputTableViewCell.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/24.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSInputTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *content;

@end

NS_ASSUME_NONNULL_END
