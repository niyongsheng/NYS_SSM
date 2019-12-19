//
//  CRGroupCardViewController.h
//  28ChatRoom
//
//  Created by 倪永胜 on 2018/12/17.
//  Copyright © 2018 qingmai. All rights reserved.
//
#import <XLForm.h>
#import "XLFormViewController.h"

@interface QMHGroupCardViewController : XLFormViewController
@property (nonatomic, weak) NSString *aID;
@property (nonatomic, weak) NSString *groupId;
@property (nonatomic, assign) BOOL inGroup;
@end
