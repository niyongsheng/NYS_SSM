//
//  NYSMeTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/1.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMeTableViewCell.h"
#import "NYSMeModel.h"

@interface NYSMeTableViewCell ()
@property (nonatomic, strong) UIImageView *titleIcon; // 标题图标
@property (nonatomic, strong) UILabel *titleLbl; // 标题
@property (nonatomic, strong) UILabel *detaileLbl; // 内容
@property (nonatomic, strong) UIImageView *subIcon; // 副图标
@end

@implementation NYSMeTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setCellData:(NYSMeModel *)cellData {
    _cellData = cellData;
    if (cellData) {
        if (cellData.titleIcon) {
            [self.titleIcon setImage:[UIImage imageNamed:cellData.titleIcon]];
            [_titleIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(NNormalSpace);
                make.centerY.mas_equalTo(self);
                make.width.height.mas_equalTo(17);
            }];
        } else {
            [self.titleIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.width.height.mas_equalTo(0);
            }];
        }
        
        if (cellData.titleText) {
            self.titleLbl.text = cellData.titleText;
        }
        
        if (cellData.detailText) {
            self.detaileLbl.text = cellData.detailText;
            [_detaileLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleLbl.mas_right).offset(10);
                make.centerY.mas_equalTo(self);
                make.right.mas_equalTo(self.subIcon.mas_left).offset(-10);
            }];
        } else {
            [_detaileLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleLbl.mas_right).offset(0);
                make.centerY.mas_equalTo(self);
                make.right.mas_equalTo(self.subIcon.mas_left).offset(0);
            }];
        }
        
        if (cellData.subIcon) {
            [self.subIcon setImage:ImageWithFile(cellData.subIcon)];
            [_subIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-NNormalSpace);
                make.size.mas_equalTo(CGSizeMake(10, 15));
                make.centerY.mas_equalTo(self);
            }];
        } else {
            [_subIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(NNormalSpace);
                make.width.height.mas_equalTo(0);
                make.centerY.mas_equalTo(self);
            }];
        }
    }
}

- (UIImageView *)titleIcon {
    if (!_titleIcon) {
        _titleIcon = [UIImageView new];
        [self addSubview:_titleIcon];
        [_titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NNormalSpace);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(0);
        }];
    }
    return _titleIcon;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = SYSTEMFONT(15);
        _titleLbl.textColor = [UIColor blackColor];
        [self addSubview:_titleLbl];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleIcon.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLbl;
}

- (UILabel *)detaileLbl {
    if (!_detaileLbl) {
        _detaileLbl = [UILabel new];
        _detaileLbl.font = SYSTEMFONT(12);
        _detaileLbl.textColor = [UIColor grayColor];
        _detaileLbl.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detaileLbl];
        
        [_detaileLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLbl.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.subIcon.mas_left).offset(-10);
        }];
    }
    return _detaileLbl;
}

- (UIImageView *)subIcon {
    if (!_subIcon) {
        _subIcon = [UIImageView new];
        [self addSubview:_subIcon];
        
        [_subIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NNormalSpace);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.centerY.mas_equalTo(self);
        }];
    }
    return _subIcon;
}


@end
