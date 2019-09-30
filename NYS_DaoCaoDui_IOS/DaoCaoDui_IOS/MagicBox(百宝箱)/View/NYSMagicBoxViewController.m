//
//  NYSMagicBoxViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMagicBoxViewController.h"
#import "NYSMagicBoxPresenter.h"
#import "NYSMagicBoxViewProtocol.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NYSEmitterViewController.h"

@interface NYSMagicBoxViewController () <UITableViewDelegate, UITableViewDataSource, NYSMagicBoxViewProtocol>

@property (nonatomic, strong) UITableView *magicBoxTableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) NSArray<NYSMagicBoxModel *> *magicBoxUIData;

@property (nonatomic, strong) NYSMagicBoxPresenter *presenter;

@end

@implementation NYSMagicBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"百宝箱";
    
    self.magicBoxTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.magicBoxTableView];
    [self.view addSubview:self.indicatorView];

    [self.presenter fetchData];
}

#pragma mark - UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NYSMagicBoxModel *model = self.magicBoxUIData[indexPath.row];
    cell.textLabel.text = model.title;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [cell layoutSubviews];
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.magicBoxUIData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning 以下代码通过JSPatch热更新推送实现
//    [SVProgressHUD show];
//    [MBProgressHUD showTopTipMessage:@"已执行JSPatch热更新" isWindow:YES];
//    [SVProgressHUD dismissWithDelay:0.5 completion:^{
//        [self.navigationController pushViewController:[[NYSEmitterViewController alloc] initWithEmitterAnimationType:indexPath.row] animated:YES];
//    }];
}

#pragma mark - NYSMagicBoxViewProtocol
- (void)magicBoxViewDataSource:(NSArray<NYSMagicBoxModel *> *)data {
    self.magicBoxUIData = data;
    [self.magicBoxTableView reloadData];
}

- (void)showIndicator {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideIndicator {
    [self.indicatorView stopAnimating];
}

- (void)showEmptyView {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:@"show empty view" preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertView animated:YES completion:^{
        
    }];
}

- (UITableView *)magicBoxTableView {
    if (_magicBoxTableView == nil) {
        _magicBoxTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _magicBoxTableView.dataSource = self;
        _magicBoxTableView.delegate = self;
    }
    return _magicBoxTableView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (NYSMagicBoxPresenter *)presenter {
    if (_presenter == nil) {
        _presenter = [[NYSMagicBoxPresenter alloc] initWithView:self];
    }
    return _presenter;
}
@end
