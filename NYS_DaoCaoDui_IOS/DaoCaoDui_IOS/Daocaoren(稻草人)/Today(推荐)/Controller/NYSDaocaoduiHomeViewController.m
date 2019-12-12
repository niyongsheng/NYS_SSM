//
//  NYSDaocaoduiHomeViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/11.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSDaocaoduiHomeViewController.h"
#import <WMZBannerView.h>
#import "NYSBannerCollectionViewCell.h"
#import <TXScrollLabelView.h>
#import <MSNumberScrollAnimatedView.h>
#import "NYSTodayItemView.h"
#import "NYSScrollNumberView.h"

#import "NYSBannerModel.h"
#import "NYSPublicnotice.h"

#define HomeBannerHeight 160

@interface NYSDaocaoduiHomeViewController () <UIScrollViewDelegate, TXScrollLabelViewDelegate>
@property (nonatomic, strong) UIScrollView *homeView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WMZBannerView *bannerView;
@property (nonatomic, strong) TXScrollLabelView *scrollLabelView;
@property (nonatomic, strong) NYSTodayItemView *itemsView;
@property (nonatomic, strong) NYSScrollNumberView *scrollNumberView;

@property (nonatomic, strong) NSArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *publicnoticeArray;
@end

@implementation NYSDaocaoduiHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    self.homeView.delegate = self;
    self.scrollLabelView.delegate = self;
    
    [self.homeView.mj_header beginRefreshing];
    [self.scrollLabelView beginScrolling];
}

- (void)initUI {
    
    _homeView = ({
        UIScrollView *homeView = [[UIScrollView alloc] init];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        homeView.mj_header = header;
        homeView.alwaysBounceVertical = YES;
        homeView.bounces = YES;
        [homeView flashScrollIndicators];
        homeView.directionalLockEnabled = YES;
        homeView.showsVerticalScrollIndicator = YES;
        [self.view addSubview:homeView];
        [homeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(NScreenWidth, NScreenHeight));
        }];
        homeView;
    });
    
    _dateLabel = ({
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.text = [self getWeekDay];
        dateLabel.textColor = UIColorFromHex(666666);
        dateLabel.font = [UIFont systemFontOfSize:14];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        [self.homeView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
        }];
        dateLabel;
    });
    
    _titleLabel = ({
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"Today";
        titleLabel.font = [UIFont boldSystemFontOfSize:30];
        titleLabel.textColor = UIColorFromHex(333333);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.homeView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dateLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_dateLabel.mas_left);
        }];
        titleLabel;
    });
    
    _bannerView = ({
        WMZBannerParam *param = BannerParam()
        // 自定义视图必传
        .wMyCellClassNameSet(@"NYSBannerCollectionViewCell")
        .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView ,NSArray*dataArr) {
            // 自定义视图
            NYSBannerCollectionViewCell *cell = (NYSBannerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NYSBannerCollectionViewCell class]) forIndexPath:indexPath];
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:[(NYSBannerModel *)model bannerUrl]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            cell.leftText.text = [(NYSBannerModel *)model title];
            // 毛玻璃效果必须实现
            [bgImageView sd_setImageWithURL:[NSURL URLWithString:[(NYSBannerModel *)model bannerUrl]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            return cell;
        })
        .wFrameSet(CGRectMake(0, 0, BannerWitdh, RealValue(HomeBannerHeight)))
        .wItemSizeSet(CGSizeMake(BannerWitdh*0.9, RealValue(HomeBannerHeight)))
        .wAlphaSet(1)
        .wEffectSet(NO)
        .wLineSpacingSet(7)
        .wScaleSet(YES)
        .wHideBannerControlSet(YES)
        .wActiveDistanceSet(600)
        .wScaleFactorSet(0.3)
        .wContentOffsetXSet(0.5)
        .wSelectIndexSet(1)
        .wRepeatSet(YES)
        .wAutoScrollSecondSet(4.5f)
        .wAutoScrollSet(YES)
        .wPositionSet(BannerCellPositionCenter)
        .wBannerControlPositionSet(BannerControlLeft)
        .wBannerControlSelectColorSet([UIColor whiteColor])
        .wBannerControlColorSet(NNavBgColor)
        .wDataSet(self.bannerArray)
        .wEventCenterClickSet(^(id anyID, NSInteger index,BOOL isCenter,UICollectionViewCell *cell) {
            NLog(@"判断居中点击\n anyID:%@ \n index:%ld \n isCenter:%d \n cell:%@",anyID,index,isCenter,cell);
        })
        .wEventScrollEndSet( ^(id anyID, NSInteger index, BOOL isCenter,UICollectionViewCell *cell) {
             NLog(@"轮播图滚动\n anyID:%@ \n index:%ld \n isCenter:%d \n cell:%@", anyID, index, isCenter, cell);
        })
        // 让第一个和最后一个居中 设置为size.width的一半
        .wSectionInsetSet(UIEdgeInsetsMake(0,BannerWitdh*0.4, 0, BannerWitdh*0.4))
        ;
        
        WMZBannerView *homeBanner = [[WMZBannerView alloc] initConfigureWithModel:param withView:self.homeView];
        [homeBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(NScreenWidth, RealValue(HomeBannerHeight)));
        }];
        homeBanner;
    });
    
    _scrollLabelView = ({
        TXScrollLabelView *scrollLabelView = [[TXScrollLabelView alloc] initWithTextArray:self.publicnoticeArray type:TXScrollLabelViewTypeUpDown velocity:3 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
        scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 7 , 0, 7);
        scrollLabelView.scrollSpace = 1;
        scrollLabelView.font = [UIFont systemFontOfSize:15];
        scrollLabelView.textAlignment = NSTextAlignmentCenter;
        scrollLabelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
        scrollLabelView.layer.cornerRadius = 7;
        CALayer *layer = [scrollLabelView layer];
        layer.borderColor = UIColorfFollowHex(0x8CCC0C).CGColor;
        layer.borderWidth = 2.0f;
        [self.homeView addSubview:scrollLabelView];
        [scrollLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bannerView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(NScreenWidth*0.9, 80));
        }];
        scrollLabelView;
    });
    
    _itemsView = ({
        NYSTodayItemView *itemsView = [[[NSBundle mainBundle] loadNibNamed:@"NYSTodayItemView" owner:self options:nil] objectAtIndex:0];
        itemsView.fromController = self;
        [self.homeView addSubview:itemsView];
        [itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_scrollLabelView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(NScreenWidth*0.9, 100));
        }];
        itemsView;
    });
    
    _scrollNumberView = ({
        NYSScrollNumberView *scrollNumberView = [[[NSBundle mainBundle] loadNibNamed:@"NYSScrollNumberView" owner:self options:nil] objectAtIndex:0];
        scrollNumberView.customScrollAnimationView.font = [UIFont fontWithName:@"Menlo-Bold" size:26]; // @"Menlo" @"Courier" @"HelveticaNeue-Bold"
        scrollNumberView.customScrollAnimationView.textColor = UIColorfFollowHex(0x8CCC0C);
        scrollNumberView.customScrollAnimationView.minLength = 4;
        [self.homeView addSubview:scrollNumberView];
        [scrollNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_itemsView.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(NScreenWidth*0.9, 80));
        }];
        scrollNumberView;
    });
}

- (void)headerRereshing {
    WS(weakSelf);
    [NYSRequest GetBannerList:GET parameters:@{@"fellowship" : @(NCurrentUser.fellowship)} success:^(id response) {
        [weakSelf.homeView.mj_header endRefreshing];
        self.bannerArray = [NYSBannerModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
        self.bannerView.data = self.bannerArray;
        [self.bannerView updateUI];
    } failure:^(NSError *error) {
        [weakSelf.homeView.mj_header endRefreshing];
    } isCache:NO];
    
    [NYSRequest GetPublicnoticeList:GET parameters:@{@"fellowship" : @(NCurrentUser.fellowship)} success:^(id response) {
        [weakSelf.homeView.mj_header endRefreshing];
        NSArray *tempArray = [NYSPublicnotice mj_objectArrayWithKeyValuesArray:response[@"data"]];
        [self.publicnoticeArray removeAllObjects];
        for (NYSPublicnotice *publicnotice in tempArray) {
            [self.publicnoticeArray addObject:publicnotice.publicnotice];
        }
        weakSelf.scrollLabelView.scrollTexts = self.publicnoticeArray;
        [weakSelf.scrollLabelView beginScrolling];
    } failure:^(NSError *error) {
        [weakSelf.homeView.mj_header endRefreshing];
    } isCache:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NYSTools animateTextChange:0.5f withLayer:weakSelf.dateLabel.layer];
        weakSelf.scrollNumberView.customScrollAnimationView.number = @(arc4random()%5000);
        [weakSelf.scrollNumberView.customScrollAnimationView startAnimation];
    });
}

- (NSArray *)bannerArray {
    if (!_bannerArray) {
        NYSBannerModel *banner1 = [[NYSBannerModel alloc] init];
        banner1.title = @"爱是我们相聚在一起";
        banner1.bannerUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576145821137&di=6487b986f41ee370b7e94a2c12bfc110&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201606%2F16%2F20160616093400_YrVBx.jpeg";
        _bannerArray = @[banner1];
    }
    return _bannerArray;
}

- (NSMutableArray *)publicnoticeArray {
    if (!_publicnoticeArray) {
        _publicnoticeArray = @[@"塑造生命，成就使命！", @"Jesus Christ Is Everything."].mutableCopy;
    }
    return _publicnoticeArray;
}

#pragma mark - 获取当前时间，日期
- (NSString*)getWeekDay {
    NSDate*date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:date];
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"礼拜天",@"礼拜一",@"礼拜二",@"礼拜三",@"礼拜四",@"礼拜五",@"礼拜六",nil];
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    NSString *weekTime = [weekdays objectAtIndex:theComponents.weekday];
    return [NSString stringWithFormat:@"%@  %@",dateTime,weekTime];
}

#pragma mark - TXScrollLabelView Delegate
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index {
    NLog(@"%@--%ld",text, index);
}

@end
