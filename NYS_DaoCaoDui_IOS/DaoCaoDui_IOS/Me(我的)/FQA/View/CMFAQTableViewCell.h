//
//  CMFAQTableViewCell.h
//  CreditMoney
//
//  Created by 倪永胜 on 2019/4/29.
//  Copyright © 2019 QM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMFAQModel;

NS_ASSUME_NONNULL_BEGIN

@interface CMFAQTableViewCell : UITableViewCell
@property (nonatomic, weak) CMFAQModel *FAQ;
@end

NS_ASSUME_NONNULL_END
