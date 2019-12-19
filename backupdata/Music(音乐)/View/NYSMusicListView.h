//
//  NYSMusicListView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSMusicListView : UIView <JXPagerViewListViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *> *dataSource;

@end

NS_ASSUME_NONNULL_END
