//
//  QMHMemberView.h
//  安居公社
//
//  Created by 倪永胜 on 2019/10/29.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMHMemberModel;

NS_ASSUME_NONNULL_BEGIN

@interface QMHMemberView : UIView

@property (nonatomic, weak) QMHMemberModel *memberModel;
@property (nonatomic, assign) NSInteger iconTag;

- (void)buttonForSendData:(id)target action:(SEL)action;
+ (instancetype)memberView;
@end

NS_ASSUME_NONNULL_END
