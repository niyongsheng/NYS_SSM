//
//  NYSSearchBibleListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/25.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSSearchBibleListViewController.h"
#import "NYSSearchBibleModel.h"

@interface NYSSearchBibleListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourcesArray;

@end

@implementation NYSSearchBibleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"搜索结果"];
    [self initUI];
    [self headerRereshing];
}

#pragma mark -- initUI --
- (void)initUI {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight, 0);
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)headerRereshing {
    WS(weakSelf);
    [NYSRequest BibleSearchListWithResMethod:GET
                                  parameters:@{@"bible" : self.bible}
                                     success:^(id response) {
        weakSelf.dataSourcesArray = [NYSSearchBibleModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [weakSelf.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeFall tableView:self.tableView];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourcesArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *bibleText = [self.dataSourcesArray[indexPath.row] bible];
    CGFloat bibleFontSize = [NUserDefaults floatForKey:SettingKey_BibleFontSize];
    UIFont *bibleFont = bibleFontSize ? [UIFont systemFontOfSize:bibleFontSize] : [UIFont systemFontOfSize:Settingdefault_BibleFontSize];
    return [bibleText heightForFont:bibleFont width:NScreenWidth - 30] + 10;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSString *bibleText = [self.dataSourcesArray[indexPath.row] bible];
    CGFloat bibleFontSize = [NUserDefaults floatForKey:SettingKey_BibleFontSize];
    cell.textLabel.font = bibleFontSize ? [UIFont systemFontOfSize:bibleFontSize] : [UIFont systemFontOfSize:Settingdefault_BibleFontSize];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = bibleText;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
