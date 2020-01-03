//
//  HomeViewController.m
//  TabBarControllerCustomDemo
//
//  Created by sjimac01 on 2018/1/24.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"
#import "NYSArticleModel.h"
#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>

// offsetY > -64 的时候导航栏开始偏移
#define NAVBAR_TRANSLATION_POINT 0

@interface HomeViewController ()<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *articleArray;
@end

@implementation HomeViewController
{
    NSIndexPath *selectIndexPath;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 设置navigaitonControllerDelegate
    self.navigationController.delegate = self;
    // 隐藏状态栏
//    [UIView animateWithDuration:1.5f animations:^{
//        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self setNavigationBarTransformProgress:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self headerRereshing];
    [self.tableView scrollToBottomAnimated:YES];
}
#pragma mark - ==============================Click============================
- (void)userButtonClick {
    
}

#pragma mark - 截屏
- (UIImage *)imageFromView {
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark - ==============================Data============================
- (void)headerRereshing {
    WS(weakSelf);
    [NYSRequest GetArticleList:GET parameters:@{@"fellowship" : @(NCurrentUser.fellowship)} success:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.articleArray = [NYSArticleModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    } isCache:NO];
}

#pragma mark - ==============================Delegate============================
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (NScreenWidth-40)*1.3+25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOMECELLID"];
    if (cell == nil) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HOMECELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldGroupAccessibilityChildren = YES;
    }
    NYSArticleModel *article = self.articleArray[indexPath.row];
    cell.titleLabel.text = [article title];
    cell.contentLabel.text = [article subtitle];
    [cell.bgimageView sd_setImageWithURL:[NSURL URLWithString:article.icon] placeholderImage:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
    cell.transform = CGAffineTransformMakeScale(1, 1);
    
    return cell;
    
}
// TODO: 即将进入高亮状态
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath  {
    selectIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 animations:^{
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }];
    
    return YES;
}
// TODO: 结束高亮状态
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%u",cell.selected);
    
    if ([selectIndexPath isEqual:indexPath]) {
        [UIView animateWithDuration:0.2 animations:^{
            cell.transform = CGAffineTransformMakeScale(1, 1);
            return;
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NYSArticleModel *article = self.articleArray[indexPath.row];
    
    
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    HomeDetailViewController *detail = [[HomeDetailViewController alloc]init];
    detail.selectIndexPath = indexPath;
    detail.bgImage = [self imageFromView];
    detail.titles = [article title];
    detail.titleTwo = [article subtitle];
    detail.content = [article content];
    detail.imageName = [article icon];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > NAVBAR_TRANSLATION_POINT)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNavigationBarTransformProgress:1];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self setNavigationBarTransformProgress:0];
            }];
        }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress {
    _tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    
//    [self.navigationController.navigationBar wr_setTranslationY:(-NGetNavBarHight * progress)];
//    // 有系统的返回按钮，所以 hasSystemBackIndicator = YES
//    [self.navigationController.navigationBar wr_setBarButtonItemsAlpha:(1 - progress) hasSystemBackIndicator:YES];
}

#pragma mark - UIViewControllerAnimatedTransitioning
// MARK: 设置代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self;
}

// MARK: 设置动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    HomeCell *cell = (HomeCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = UIView.new;
    if([toVC.className isEqualToString:@"HomeDetailViewController"]) {
        toView = [toVC valueForKeyPath:@"headerImageView"];
    }
    UIView *fromView = cell.bgView;
    UIView *containerView = [transitionContext containerView];
    UIView *snapShotView = [[UIImageView alloc] initWithImage:cell.bgimageView.image];
    snapShotView.contentMode = UIViewContentModeScaleAspectFill;
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];

    fromView.hidden = YES;

    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toView.hidden = YES;

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, NScreenWidth-30, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    titleLabel.text = cell.titleLabel.text;

    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (NScreenWidth-40)*1.3-30, NScreenWidth-44, 15)];
    contentLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.alpha = 0.5;
    contentLabel.text =cell.contentLabel.text;
    [snapShotView addSubview:titleLabel];
    [snapShotView addSubview:contentLabel];
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0f;
        UITabBar *tabBar = (UITabBar *)self.tabBarController.tabBar;
        if (isIphonex) {
            tabBar.frame = CGRectMake(0, NScreenHeight, NScreenWidth, 83);
        } else {
            tabBar.frame = CGRectMake(0, NScreenHeight, NScreenWidth, 49);
        }
        snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
        titleLabel.frame = CGRectMake(22, 30, NScreenWidth-30, 30);
        contentLabel.frame = CGRectMake(22, NScreenWidth*1.3-30, NScreenWidth*1.3-44, 15);

    } completion:^(BOOL finished) {

        toView.hidden = NO;
        fromView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self.tableView reloadData];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

#pragma mark - ==============================实例化============================
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
    }
    return _tableView;
}

@end
