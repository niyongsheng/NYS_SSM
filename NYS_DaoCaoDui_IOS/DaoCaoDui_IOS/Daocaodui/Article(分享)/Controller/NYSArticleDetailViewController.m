//
//  NYSArticleDetailViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/15.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSArticleDetailViewController.h"
#import "NYSArticleHeaderView.h"
#import "NYSArticleFooterView.h"
#import "NYSArticleContentTableViewCell.h"

#define FontSize 19.f
#define HeaderHeight 400
@interface NYSArticleDetailViewController () <UITableViewDelegate, UITableViewDataSource> {
    NYSArticleHeaderView *_headerView;
    NYSArticleFooterView *_footerView;
}
@property (strong, nonatomic) UIButton *collectionBtn;
@end

@implementation NYSArticleDetailViewController

- (UIButton *)collectionBtn {
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(NScreenWidth - 55, 500, 50, 50)];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"collection_unselect"] forState:UIControlStateNormal];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"collection_selected"] forState:UIControlStateSelected];
        [_collectionBtn addTarget:self action:@selector(collectionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *gobackRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBtnClicked:)];
    [self.view addGestureRecognizer:gobackRecognizer];
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSArticleHeaderView" owner:self options:nil] objectAtIndex:0];
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, HeaderHeight);
    _headerView.articleModel = self.articleModel;
    self.tableView.tableHeaderView = _headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(-NStatusBarHeight, 0, NStatusBarHeight, 0);
    
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSArticleFooterView" owner:self options:nil] objectAtIndex:0];
    _footerView.frame = CGRectMake(0, 0, NScreenWidth, 100);
    _footerView.fromViewController = self;
    _footerView.articleModel = self.articleModel;
    self.tableView.tableFooterView = _footerView;
    
    self.tableView.height = NScreenHeight;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 500.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.collectionBtn];
}

#pragma mark —- tableview delegate —-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NYSArticleContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NYSArticleContentTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NYSArticleContentTableViewCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentString = self.articleModel.content;
    return cell;
}

#pragma mark - Dismiss Controller
- (void)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark —- ScrollViewDelegate 下拉放大header —-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat totalOffsetY = scrollView.contentInset.top + offset;
    if (totalOffsetY < 0) {
        [UIView animateWithDuration:.3f animations:^{
            self.collectionBtn.frame = CGRectMake(NScreenWidth - 10, 500, 50, 50);
        }];
    } else {
        [UIView animateWithDuration:.3f animations:^{
            self.collectionBtn.frame = CGRectMake(NScreenWidth - 55, 500, 50, 50);
        }];
    }
}

- (void)collectionBtnClicked:(UIButton *)sender {
    self.collectionBtn.selected = !self.collectionBtn.selected;
}

@end
