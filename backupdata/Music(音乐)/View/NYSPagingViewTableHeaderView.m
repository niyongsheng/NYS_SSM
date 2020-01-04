//
//  NYSPagingViewTableHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPagingViewTableHeaderView.h"
#import "YNRippleAnimatView.h"

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

        _introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 50, NScreenWidth - 20, 50)];
        _introductionLabel.numberOfLines = 0;
        _introductionLabel.font = [UIFont systemFontOfSize:18.f];
        _introductionLabel.textAlignment = NSTextAlignmentCenter;
        _introductionLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];
        [self addSubview:_introductionLabel];
        
        CGFloat maxRadius = [UIScreen mainScreen].bounds.size.width * 0.4;
        _rippleView = [[YNRippleAnimatView alloc] initMinRadius:20 maxRadius:maxRadius];
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
    [_rippleView startAnimation];
}
         
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}

- (void)clockClicked:(UIView *)sender {
    
}

@end
