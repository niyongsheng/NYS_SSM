//
//  AdPageView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AdPageView.h"
#import "ADModel.h"

static NSString *const adImageNameKey = @"AdImageNameKey";
static NSString *const adTargetUrlKey = @"AdTargetUrlKey";
static NSString *const adDurationTimeKey = @"AdDurationTimeKey";

@interface AdPageView()
/// 广告图
@property (nonatomic, strong) UIImageView *adView;
/// 跳过按钮
@property (nonatomic, strong) UIButton *countBtn;
/// 定时器
@property (nonatomic, strong) NSTimer *countTimer;
/// 展示时长
@property (nonatomic, assign) float showtime;

@property (nonatomic, assign) int count;

@property (nonatomic, copy) TapBlock tapBlock;

@end

@implementation AdPageView

- (NSTimer *)countTimer {
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(TapBlock)tapBlock {
    
    if (self = [super initWithFrame:frame]) {
        // 1.广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adViewOnTap)];
        [_adView addGestureRecognizer:tap];
        
        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(NScreenWidth - btnW - 24, NStatusBarHeight + 15, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _showtime = [NUserDefaults floatForKey:adDurationTimeKey];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%ld", (NSInteger)_showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
        
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
        NSString *filePath = [self getFilePathWithImageName:[NUserDefaults valueForKey:adImageNameKey]];
        
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (isExist) { // 图片存在
            [self setFilePath:filePath];
            self.tapBlock = tapBlock;
            [self show];
        }
        
        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
        [self getAdvertisingImage];
    }
    
    return self;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}

/// 广告点击后block回调
- (void)adViewOnTap {
    
    [self dismiss];
    
    NSString *targetUrl = [NUserDefaults valueForKey:adTargetUrlKey];
    if (self.tapBlock) {
        self.tapBlock(_showtime, targetUrl);
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoad" object:nil userInfo:nil];
}

- (void)countDown {
    _count --;
    
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", _count] forState:UIControlStateNormal];
    if (_count <= 0) {
        
        [self dismiss];
    }
}

- (void)show {
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    if (_showtime <= 0) {
        return;
    }
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

// 定时器倒计时
- (void)startTimer {
    _count = _showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown {
    __block int timeout = _showtime + 1; // 倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)dismiss {
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  获取广告数据
 */
- (void)getAdvertisingImage {
    
    [NYSRequest GetAdvertisementListWithResMethod:GET
                                       parameters:@{@"fellowship" : NCurrentUser ? @(NCurrentUser.fellowship) : @"1",
                                                    @"type" : @"1"}
                                          success:^(id response) {
        NSArray <ADModel *> *datasourceArray = [ADModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        NSInteger index = arc4random() % datasourceArray.count;
        NSString *imageUrl = [datasourceArray[index] advertisementUrl];
        NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
        NSString *imageName = stringArr.lastObject;
        NSString *targetUrl = [datasourceArray[index] targetUrl];
        float durationTime = [datasourceArray[index] duration];
        
        // 拼接沙盒路径
        NSString *filePath = [self getFilePathWithImageName:imageName];
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (!isExist || !(durationTime == [NUserDefaults floatForKey:adDurationTimeKey]) || ![targetUrl isEqualToString:[NUserDefaults valueForKey:adTargetUrlKey]]) {
            // 如果该图片不存在且跳转地址、展示时间更新，则删除老图片，下载新图片
            [self downloadAdImageWithUrl:imageUrl imageName:imageName targetUrl:targetUrl durationTime:durationTime];
        }
    } failure:^(NSError *error) {
        
    } isCache:YES];
}

/**
 *  下载广告图片数据
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName targetUrl:(NSString *)targetUrl durationTime:(float)durationTime {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName];
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            NLog(@"广告页保存成功");
            [self deleteOldImage];
            // 缓存广告图名称+跳转地址+展示时间
            [NUserDefaults setValue:imageName forKey:adImageNameKey];
            [NUserDefaults setValue:targetUrl forKey:adTargetUrlKey];
            [NUserDefaults setFloat:durationTime forKey:adDurationTimeKey];
            [NUserDefaults synchronize];
        } else {
            NLog(@"广告页保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage {
    
    NSString *imageName = [NUserDefaults valueForKey:adImageNameKey];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

@end
