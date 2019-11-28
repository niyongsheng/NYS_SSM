//
//  CMHeaderView.m
//  CreditMoney
//
//  Created by 倪永胜 on 2019/4/29.
//  Copyright © 2019 QM. All rights reserved.
//

#import "NYSFAQHeaderView.h"
#import "CMFAQModel.h"

@interface NYSFAQHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation NYSFAQHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    // 1.创建头部控件
    static NSString *ID = @"header";
    NYSFAQHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[NYSFAQHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = nil;
        [_titleLabel setTextColor:[UIColor grayColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.f]];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        _arrowImageView = [[UIImageView alloc] init];
        [_arrowImageView setImage:IMAGE_NAMED(@"down_arrow")];
        [self.contentView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

/**
 当一个控件的frame发生改变时就会调用此方法
 
 一般在这里布局内部子控件（设置子控件的frame）
 */
//- (void)layoutSubviews {
//#warning 一定调用super的方法
//    [super  layoutSubviews];
//
//}

- (void)setFAQ:(CMFAQModel *)FAQ {
    _FAQ = FAQ;
    _titleLabel.text = FAQ.title;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.FAQ.expanded = !self.FAQ.expanded;

    if ([self.delegate respondsToSelector:@selector(headerViewDidClickedNameView:)]) {
        [self.delegate headerViewDidClickedNameView:self];
    }
}

/**
 当一个控件被添加到负空间中时调用
 */
- (void)didMoveToSuperview {
    // 改变箭头的状态
    if (self.FAQ.expanded) {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
