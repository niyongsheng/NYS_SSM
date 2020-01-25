//
//  NYSFellowshipStoryViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSFellowshipStoryViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <WMZBanner/WMZBannerView.h>
#import "NYSUserBannerCollectionViewCell.h"
#import "UserInfo.h"

@interface NYSFellowshipStoryViewController ()
@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) UILabel *introductionLabel;

@property (nonatomic, strong) WMZBannerView *userBannerView;
@property (nonatomic, strong) WMZBannerParam *userBannerParam;
@property (nonatomic, strong) NSArray *bannerArray;
@end

@implementation NYSFellowshipStoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.player play];
    [self getNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我们的故事"];
    
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    
    _contentScrollView = ({
        UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
        contentScrollView.bounces = YES;
        [contentScrollView flashScrollIndicators];
        contentScrollView.directionalLockEnabled = YES;
        contentScrollView.contentSize = CGSizeMake(0, NScreenHeight + RealValue(150));
        [self.view addSubview:contentScrollView];
        contentScrollView;
    });
    
    _introductionLabel = ({
        NSString *content = @"十九世纪早期，米尔斯在麻省威廉的威廉士学院燃起了宣教的热潮，米尔斯及几个学生在1806年被风雨所困，在干草堆中即兴举行祈祷会，这便是著名的干草堆祈祷会，产生了一群委身的年轻人，组成干草堆小组。他们开始定期祷告、思考和计划宣教。\n\n我们也希望可以像这群年轻人一样委身于耶稣基督，做圣洁的器皿，成为时代的祝福，又因为团契成立之初门前有稻草，故取名——稻草堆。";
        UIFont *font = [UIFont fontWithName:@"HYZhuZiMeiXinTiW" size:25.f];
        UILabel *introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, NScreenWidth - 40, [content heightForFont:font width:NScreenWidth - 40])];
        introductionLabel.numberOfLines = 0;
        introductionLabel.textAlignment = NSTextAlignmentCenter;
        introductionLabel.font = font;
        introductionLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        [introductionLabel setText:content];
        [self.contentScrollView addSubview:introductionLabel];
        introductionLabel;
    });
    
    
    self.userBannerParam = BannerParam()
    // 自定义pageControl的位置
    .wCustomControlSet(^(UIPageControl *pageControl) {
        
    })
    // 自定义视图必传
    .wMyCellClassNameSet(@"NYSUserBannerCollectionViewCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
        // 自定义视图
        NYSUserBannerCollectionViewCell *cell = (NYSUserBannerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NYSUserBannerCollectionViewCell class]) forIndexPath:indexPath];
        // 设置数据
        UserInfo *userModel = (UserInfo *)model;
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:[(UserInfo *)model icon]] placeholderImage:[UIImage imageNamed:@"bg_compose_artwork_198x94_"]];
        cell.titleText.text = userModel.introduction ? [NSString stringWithFormat:@"%@:%@", userModel.nickname, userModel.introduction] : userModel.nickname;
        
        return cell;
    })
    .wEventClickSet(^(id anyID, NSInteger index) {
        NLog(@"点击 %@ %ld", anyID, index);
    })
    .wEventCenterClickSet(^(id anyID, NSInteger index,BOOL isCenter,UICollectionViewCell *cell) {
        NLog(@"判断居中点击");
    })
    // 图片对应的key值
    .wDataParamIconNameSet(@"icon")
    // 轮播图Frame
    .wFrameSet(CGRectMake(0, CGRectGetMaxY(_introductionLabel.bounds) + 50, BannerWitdh, RealValue(200)))
    // 图片铺满
    .wImageFillSet(YES)
    // item间距
    .wLineSpacingSet(10)
    // 开启缩放
    .wScaleSet(YES)
    // 毛玻璃效果
    .wEffectSet(NO)
    // 毛玻璃背景的高度系数
    .wEffectHeightSet(1)
    // 缩放垂直间距
    .wActiveDistanceSet(400)
    // 缩放系数
    .wScaleFactorSet(0.5)
    // item的size
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.5, BannerHeight/3))
    // 滑动固定偏移距离 itemSize.width*倍数
    .wContentOffsetXSet(0.5)
    // 默认滑动到第index个
    .wSelectIndexSet(1)
    // 循环滚动
    .wRepeatSet(YES)
    // 自动滚动时间
    .wAutoScrollSecondSet(2)
    // 自动滚动
    .wAutoScrollSet(YES)
    // 卡片叠加模式
    .wCardOverLapSet(NO)
    // cell的位置
    .wPositionSet(BannerCellPositionCenter)
    // 分页按钮的选中的颜色
    .wBannerControlSelectColorSet([UIColor whiteColor])
    // 分页按钮的未选中的颜色
    .wBannerControlColorSet([UIColor cyanColor])
    // 分页按钮的未选中的图片
    .wBannerControlImageSet(@"slideCirclePoint")
    // 分页按钮的选中的图片
    .wBannerControlSelectImageSet(@"slidePoint")
    // 分页按钮的未选中图片的size
    .wBannerControlImageSizeSet(CGSizeMake(10, 10))
    // 分页按钮选中的图片的size
    .wBannerControlSelectImageSizeSet(CGSizeMake(15, 10))
    // 分页按钮的圆角
    .wBannerControlImageRadiusSet(5)
    // 自定义圆点间距
    .wBannerControlSelectMarginSet(3)
    // 隐藏分页按钮
    .wHideBannerControlSet(YES)
    // 能否拖动
    .wCanFingerSlidingSet(YES)
    // 整体缩小
    .wScreenScaleSet(1)
    // 左右半透明 中间不透明
    .wAlphaSet(0.5)
    // 开启跑马灯效果
    .wMarqueeSet(NO)
    // 跑马灯速度
    .wMarqueeRateSet(5)
    // 开启纵向
    .wVerticalSet(NO)
    // 分页按钮的位置
    .wBannerControlPositionSet(BannerControlCenter)
    // 左右偏移 让第一个和最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,BannerWitdh*0.25, 0, BannerWitdh*0.25))
    // 数据源
    .wDataSet(self.bannerArray)
    ;
    _userBannerView = ({
        WMZBannerView *userBannerView = [[WMZBannerView alloc] initConfigureWithModel:_userBannerParam withView:_contentScrollView];
        userBannerView;
    });
}

#pragma mark - 加载数据
- (void)getNewData {
    WS(weakSelf);
    [NYSRequest GetUserListWithResMethod:GET
                              parameters:@{@"isPageBreak" : @(0), @"fellowship" : @(NCurrentUser.fellowship)}
                                 success:^(id response) {
        weakSelf.bannerArray = [UserInfo mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [weakSelf.userBannerParam setWData:weakSelf.bannerArray];
        [weakSelf.userBannerView updateUI];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

#pragma mark - laze load AVPlayer
- (AVPlayer *)player {
    if (!_player) {
        // 1 创建一个播放item
        NSString *path = [[NSBundle mainBundle] pathForResource:@"meteor.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:url];
        // 2 播放的设置
        _player = [AVPlayer playerWithPlayerItem:playItem];
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone; // 永不暂停
        // 3 将图层嵌入到0层
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.contentMode = UIViewContentModeScaleToFill;
        layer.frame = CGRectMake(0, RealValue(-300), NScreenWidth, NScreenHeight + RealValue(500));
        [self.view.layer insertSublayer:layer atIndex:0];
        // 4 播放到头循环播放
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _player;
}

#pragma mark - 视频播放结束 触发
- (void)playToEnd {
    // 重复播放
    [self.player seekToTime:kCMTimeZero];
}

@end
