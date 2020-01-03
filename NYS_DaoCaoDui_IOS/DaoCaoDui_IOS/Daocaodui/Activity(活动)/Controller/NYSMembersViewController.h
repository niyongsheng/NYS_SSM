//
//  NYSMembersViewController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/2.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSMembersViewController : NYSRootViewController
@property (nonatomic, strong) NSArray<UserInfo *> * memberListArray;
@end

NS_ASSUME_NONNULL_END
