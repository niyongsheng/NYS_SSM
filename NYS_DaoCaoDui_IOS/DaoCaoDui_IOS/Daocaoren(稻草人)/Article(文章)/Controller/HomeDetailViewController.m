//
//  HomeDetailViewController.m
//  PushTransitionDemo
//
//  Created by sjimac01 on 2018/2/5.
//  Copyright © 2018年 sjimac01. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeCell.h"
#import "HomeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

//#import "Tabbar.h"
@interface HomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *bgImageView;     // 上个页面截图
@property (strong, nonatomic) UILabel *contentLabel;        // 内容
@property (strong, nonatomic) UIImageView *headerImageView; // 大图
@property (strong, nonatomic) UILabel *titleLabel;          // 主标题
@property (strong, nonatomic) UILabel *titleTwoLabel;       // 副标题
@end

@implementation HomeDetailViewController
{
    CGFloat cellHeight;
    CGFloat startPointX;
    CGFloat startPointY;
    CGFloat scale;
    BOOL isHorizontal;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [UIView animateWithDuration:0.2 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self buildSubviews];
}


#pragma mark - ==============================data============================


- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    scale = 1;
}

#pragma mark - ==============================UI============================

- (void)buildSubviews {
    // 背景图
    [self.view addSubview:self.bgImageView];
    self.bgImageView.image = self.bgImage;
    // 背景毛玻璃
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, NScreenWidth, NScreenHeight);
    [self.view addSubview:effectView];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self tableViewHeaderView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.tableView addGestureRecognizer:pan];
    pan.delegate = self;

}

- (UIView *)tableViewHeaderView {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenWidth*1.3)];
    
    self.headerImageView.frame = CGRectMake(0, 0, NScreenWidth, NScreenWidth*1.3);
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageName]];
    [headerView addSubview:self.headerImageView];
    self.titleLabel.text =self.titles;
    self.titleTwoLabel.text = self.titleTwo;
    [headerView addSubview:self.titleLabel];
    [headerView addSubview:self.titleTwoLabel];
    return headerView;
}


#pragma mark - ==============================Delegate============================


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [self withString:self.contentLabel.text font:self.contentLabel.font ViewWidth:NScreenWidth-36];
    return 62+size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBHOMECELLID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WBHOMECELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    self.contentLabel.text = self.content;
    CGSize size = [self withString:self.contentLabel.text font:self.contentLabel.font ViewWidth:NScreenWidth-36];
    self.contentLabel.frame = CGRectMake(18,42, NScreenWidth-36, size.height);
    [cell.contentView addSubview:self.contentLabel];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        
        CGRect rectQ = self.headerImageView.frame;
        rectQ.origin.y = scrollView.contentOffset.y;
        self.headerImageView.frame = rectQ;
        
        CGRect rectT = _titleLabel.frame;
        rectT.origin.y = scrollView.contentOffset.y+30;
        _titleLabel.frame = rectT;
        
        CGRect rectC = _titleTwoLabel.frame;
        rectC.origin.y = scrollView.contentOffset.y + NScreenWidth*1.3-30;
        _titleTwoLabel.frame = rectC;
    }
}

#pragma mark - 下拉缩小，跳转

- (void)pan:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {   // 手势开始
            CGPoint currentPoint =[pan locationInView:self.tableView];
            startPointY = currentPoint.y;
            startPointX = currentPoint.x;
            // 确定是否可以横划，判断起始点位置
            if (startPointX>30) {
                isHorizontal = NO;
            } else {
                isHorizontal = YES;
            }
        } break;
        case UIGestureRecognizerStateChanged: { // 手势状态改变
            CGPoint currentPoint =[pan locationInView:self.tableView];
            // 如果可以横划，判断是横划还是竖划
            if (isHorizontal) {
                if ((currentPoint.x-startPointX)>(currentPoint.y-startPointY)) {
                    scale = (NScreenWidth-(currentPoint.x-startPointX))/NScreenWidth;
                } else {
                    scale = (NScreenWidth-(currentPoint.y-startPointY))/NScreenHeight;
                }
            } else {
                scale = (NScreenHeight-(currentPoint.y-startPointY))/NScreenHeight;
            }
            if (scale > 1.0f) {
                scale = 1.0f;
            } else if (scale <=0.8f) {
                scale = 0.8f;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
            if (self.tableView.contentOffset.y<=0) {
                // 缩放
                self.tableView.transform = CGAffineTransformMakeScale(scale, scale);
                // 圆角
                self.tableView.layer.cornerRadius = 15 * (1-scale)*5*1.08;
            }
            
            if (scale < 0.99) {
                [self.tableView setScrollEnabled:NO];
            } else {
                [self.tableView setScrollEnabled:YES];
            }
        } break;
        case UIGestureRecognizerStateEnded:  { // 手势结束
            NSLog(@"手势结束");
            scale = 1;
            self.tableView.scrollEnabled = YES;
            if (scale>0.8) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.tableView.layer.cornerRadius = 0;
                    self.tableView.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }
            
        }  break;
        default:
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}


#pragma mark - 重写pop动画

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    HomeViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    HomeDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [fromVC valueForKeyPath:@"headerImageView"];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    HomeCell *cell = (HomeCell *)[toVC.tableView cellForRowAtIndexPath:self.selectIndexPath];
    UIView *originView = cell.bgimageView;
    
    UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    snapShotView.layer.masksToBounds = YES;
    snapShotView.layer.cornerRadius = 15;
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    
    fromView.hidden = YES;
    originView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.text = self.titles;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.text =self.titleTwo;
    contentLabel.alpha = 0.5;
    titleLabel.frame = CGRectMake(22, 20, NScreenWidth-30, 30);
    contentLabel.frame = CGRectMake(22, NScreenWidth*1.3-30, NScreenWidth*1.3-44, 15);
    [snapShotView addSubview:titleLabel];
    [snapShotView addSubview:contentLabel];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [containerView layoutIfNeeded];
        fromVC.view.alpha = 0.0f;
        snapShotView.layer.cornerRadius = 15;
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width,NScreenWidth*1.3*0.8);
        self.tableView.layer.cornerRadius = 15;
        snapShotView.frame = [containerView convertRect:originView.frame fromView:originView.superview];
        titleLabel.frame = CGRectMake(15, 20, NScreenWidth-30, 30);
        contentLabel.frame = CGRectMake(15, (NScreenWidth-40)*1.3-30, NScreenWidth-44, 15);
        UITabBar *tabBar = (UITabBar *)self.tabBarController.tabBar;
        if (isIphonex) {
            tabBar.frame = CGRectMake(0, NScreenHeight-83, NScreenWidth, 83);
        } else {
            tabBar.frame = CGRectMake(0, NScreenHeight-49, NScreenWidth, 49);
        }
        
    } completion:^(BOOL finished) {
        fromView.hidden = YES;
        [snapShotView removeFromSuperview];
        originView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


#pragma mark - ==============================实例化============================


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 30, NScreenWidth-30, 30)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:25];
    }
    return _titleLabel;
}

- (UILabel *)titleTwoLabel {
    if (_titleTwoLabel == nil) {
        _titleTwoLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, NScreenWidth*1.3-30, NScreenWidth*1.3-44, 15)];
        _titleTwoLabel.font = [UIFont systemFontOfSize:15];
        _titleTwoLabel.textColor = [UIColor whiteColor];
        _titleTwoLabel.alpha = 0.5;
        _titleTwoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleTwoLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.textColor = UIColorFromHex(0x7f7f82);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIImageView *)headerImageView {
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImageView;
}

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}


- (CGSize)withString:(NSString *)string font:(UIFont *)font ViewWidth:(float)Width {
    CGSize LabelSize;
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0)
    {
        LabelSize=[string boundingRectWithSize:CGSizeMake(Width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    else
    {
        //ios7 以下版本
        LabelSize=[string sizeWithFont:font constrainedToSize:CGSizeMake(Width, MAXFLOAT)];
    }
    
    return LabelSize;
}

@end
