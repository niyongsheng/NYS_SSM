//
//  NYSClockListView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSClockListView : UIView  <JXPagerViewListViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property(assign, nonatomic) BOOL isClocked;
@property (strong, nonatomic) UIViewController *fromController;
@end

NS_ASSUME_NONNULL_END
