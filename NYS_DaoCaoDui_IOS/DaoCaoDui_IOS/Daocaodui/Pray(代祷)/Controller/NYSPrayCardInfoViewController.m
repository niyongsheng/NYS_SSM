//
//  NYSPrayCardInfoViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/7.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSPrayCardInfoViewController.h"
#import "NYSTimeCircle.h"
#import "NYSEmitterUtil.h"

#define TotalSeconds 60
@interface NYSPrayCardInfoViewController ()
@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (strong, nonatomic) UIImageView *bgimageView;
@property (strong, nonatomic) NYSTimeCircle *timeCircle;
@property (strong, nonatomic) UIButton *startPrayBtn;
@property (strong, nonatomic) UITextView *prayContentText;

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger second;
@end

@implementation NYSPrayCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听屏幕点击事件
    UITapGestureRecognizer *gobackRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBtnClicked:)];
    [self.view addGestureRecognizer:gobackRecognizer];
    
    [self.view addSubview:self.bgimageView];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.timeCircle];
    [self.contentScrollView addSubview:self.startPrayBtn];
    [self.contentScrollView addSubview:self.prayContentText];
}

#pragma mark - lazy load
- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.contentSize = CGSizeMake(0, NScreenHeight + 50);
    }
    return _contentScrollView;
}

- (UIImageView *)bgimageView {
    if (!_bgimageView) {
        _bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
        _bgimageView.contentMode = UIViewContentModeScaleToFill;
        _bgimageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.prayModel.icon]]];
        // Blur effect
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, _bgimageView.frame.size.width, _bgimageView.frame.size.height);
        [_bgimageView addSubview:effectView];
    }
    return _bgimageView;
}

- (NYSTimeCircle *)timeCircle {
    if (!_timeCircle) {
        _timeCircle = [[NYSTimeCircle alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 100, 200, 200)];
        _timeCircle.arcUnfinishColor = [UIColor colorWithRed:250/255.0 green:195/255.0 blue:174/255.0 alpha:1];
        _timeCircle.arcFinishColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
        _timeCircle.arcBackColor = [UIColor clearColor];
        _timeCircle.baseColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2];
        _timeCircle.width = 20.0f;
        _timeCircle.totalSecond = TotalSeconds;
        _timeCircle.isStartDisplay = YES;
    }
    return _timeCircle;
}

- (UIButton *)startPrayBtn {
    if (!_startPrayBtn) {
        _startPrayBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 70, self.view.center.y - 10, 140, 40)];
        [_startPrayBtn setTitle:@"代祷1分钟" forState:UIControlStateNormal];
        [_startPrayBtn addTarget:self action:@selector(startPrayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _startPrayBtn.layer.cornerRadius = 20.0f;
        _startPrayBtn.layer.masksToBounds = YES;
        CALayer *layer = [_startPrayBtn layer];
        layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4].CGColor;
        layer.borderWidth = 2.0f;
    }
    return _startPrayBtn;
}

- (UITextView *)prayContentText {
    if (!_prayContentText) {
        _prayContentText = [[UITextView alloc] initWithFrame:CGRectMake(15, self.startPrayBtn.bottom + 30, NScreenWidth - 30, RealValue(200))];
        _prayContentText.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _prayContentText.backgroundColor = [UIColor clearColor];
        _prayContentText.userInteractionEnabled = NO;
        _prayContentText.font = [UIFont systemFontOfSize:18.0f];
        _prayContentText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _prayContentText.layer.cornerRadius = 5.0f;
        _prayContentText.layer.masksToBounds = YES;
        CALayer *layer = [_prayContentText layer];
        layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4].CGColor;
        layer.borderWidth = 1.0f;
        _prayContentText.text = self.prayModel.content;
    }
    return _prayContentText;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAnimation) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)timerAnimation {
    self.second --;
    self.timeCircle.second = self.second;
    
    if (self.second < 0) {
        [self.timer invalidate];
    } else if (self.second <= 0) {
        [NYSEmitterUtil showEmitterType:EmitterAnimationSnow onView:self.view durationTime:MAXFLOAT];
    }
}

- (void)startPrayBtnClicked:(UIButton *)sender {
    [UIView animateWithDuration:0.4f animations:^{
        sender.transform = CGAffineTransformMakeScale(2, 1.5);
        sender.transform = CGAffineTransformIdentity;
    }];

    // 倒计时长装入并启动定时器
    self.second = TotalSeconds;
    [self timer];
}

#pragma mark - Dismiss Controller
- (void)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
