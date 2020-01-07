//
//  NYSPagingViewTableHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPagingViewTableHeaderView.h"
#import "YNRippleAnimatView.h"
#import "NYSAlert.h"

@interface NYSPagingViewTableHeaderView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect imageViewFrame;
@property (nonatomic, strong) UILabel *introductionLabel;
@property (nonatomic, strong) UIButton *clockBtn;
@property (nonatomic, strong) YNRippleAnimatView *rippleView;
@end

@implementation NYSPagingViewTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        // 下拉放大
        self.imageViewFrame = self.imageView.frame;

        _introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 90, NScreenWidth - 20, 80)];
        _introductionLabel.numberOfLines = 0;
        _introductionLabel.font = [UIFont systemFontOfSize:18.f];
        _introductionLabel.textAlignment = NSTextAlignmentCenter;
        _introductionLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];
        [self addSubview:_introductionLabel];
        
        CGFloat maxRadius = [UIScreen mainScreen].bounds.size.width * 0.4;
        _rippleView = [[YNRippleAnimatView alloc] initMinRadius:1 maxRadius:maxRadius];
        _rippleView.alpha = 0.85f;
        _rippleView.rippleCount = 5;
        _rippleView.rippleDuration = 4;
        _rippleView.image = [UIImage imageNamed:@"tabbar_compose_idea"];
        _rippleView.imageSize = CGSizeMake(80, 80);
        _rippleView.rippleColor = [UIColor clearColor];
        _rippleView.borderWidth = 3;
        _rippleView.borderColor = [UIColor lightGrayColor];
        _rippleView.frame = CGRectMake(self.centerX - 40, self.centerY - 40, 80, 80);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clockClicked:)];
        [_rippleView addGestureRecognizer:tapGesture];
        [self addSubview:_rippleView];
    }
    return self;
}

- (void)setDatasource:(NYSActivityModel *)datasource {
    _datasource = datasource;
    [_imageView setImageWithURL:[NSURL URLWithString:[datasource icon]] placeholder:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
    [_introductionLabel setText:[datasource introduction]];
    ![datasource isClockedToday] ? [_rippleView startAnimation] : nil;
}
         
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}

- (void)clockClicked:(UIView *)sender {
    if ([self.datasource isClockedToday]) {
        [SVProgressHUD showInfoWithStatus:@"今天已经打过卡了\n明天再来吧"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    
    WS(weakSelf);
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"今日打卡" message:@"来3:14 我们若将起初确实的信心坚持到底，就在基督里有分了。" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"打卡备注";
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"取消");
    }];
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [NYSRequest PunchClockActivityWithResMethod:GET
                              parameters:@{@"activityID" : @(self.datasource.ID),
                                           @"remark" : alertVc.textFields.firstObject.text}
                                 success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                [NYSAlert showSuccessAlertWithTitle:@"活动打卡" message:@"恭喜你，打卡成功^^" okButtonClickedBlock:^{
                    [weakSelf.fromController.navigationController popViewControllerAnimated:YES];
                    [NNotificationCenter postNotificationName:@"RefreshClockActivityListNotification" object:nil];
                }];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVc addAction:cancelBtn];
    [alertVc addAction:sureBtn];
    [self.fromController presentViewController:alertVc animated:YES completion:nil];
}

@end
