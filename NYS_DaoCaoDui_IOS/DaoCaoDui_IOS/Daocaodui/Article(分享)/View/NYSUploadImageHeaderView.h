//
//  NYSUploadImageHeaderView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/24.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSUploadImageHeaderView : UIView
@property (weak, nonatomic) UIImage *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *uploadTitle;

- (void)uploadBtnForSendData:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
