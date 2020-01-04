//
//  NYSFellowshipStoryViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSFellowshipStoryViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface NYSFellowshipStoryViewController ()
@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) UILabel *introductionLabel;
@end

@implementation NYSFellowshipStoryViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我们的故事"];
    
    [self.player play];
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    
    _contentScrollView = ({
        UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
        contentScrollView.bounces = YES;
        [contentScrollView flashScrollIndicators];
        contentScrollView.directionalLockEnabled = YES;
        contentScrollView.contentSize = CGSizeMake(0, NScreenHeight + 50);
        [self.view addSubview:contentScrollView];
        contentScrollView;
    });
    
    _introductionLabel = ({
        UILabel *introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, NScreenWidth - 40, NScreenHeight)];
        introductionLabel.numberOfLines = 0;
        introductionLabel.textAlignment = NSTextAlignmentCenter;
        introductionLabel.font = [UIFont fontWithName:@"HYZhuZiMeiXinTiW" size:25.f];
        introductionLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        [introductionLabel setText:@"十九世纪早期，米尔斯在麻省威廉的威廉士学院燃起了宣教的热潮，米尔斯及几个学生在1806年被风雨所困，在干草堆中即兴举行祈祷会，这便是著名的干草堆祈祷会，产生了一群委身的年轻人，组成干草堆小组。他们开始定期祷告、思考和计划宣教。\n\n我们也希望可以像这群年轻人一样委身于耶稣基督，做圣洁的器皿，成为时代的祝福，又因为团契成立之初门前有稻草，故取名——稻草堆。"];
        [self.contentScrollView addSubview:introductionLabel];
        introductionLabel;
    });
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
//        layer.frame = self.view.bounds;
        layer.frame = CGRectMake(0, RealValue(-300), NScreenWidth, NScreenHeight + RealValue(500));
        [self.view.layer insertSublayer:layer atIndex:0];
        // 4 播放到头循环播放
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _player;
}

#pragma mark - 视频播放结束 触发
- (void)playToEnd {
    // 重头再来
    [self.player seekToTime:kCMTimeZero];
}

@end
