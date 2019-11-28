//
//  CMHeaderView.h
//  CreditMoney
//
//  Created by 倪永胜 on 2019/4/29.
//  Copyright © 2019 QM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NYSFAQHeaderView, CMFAQModel;

@protocol CMHeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClickedNameView:(NYSFAQHeaderView *)headerView;
@end

@interface NYSFAQHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) CMFAQModel *FAQ;

@property (nonatomic, weak) id<CMHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
