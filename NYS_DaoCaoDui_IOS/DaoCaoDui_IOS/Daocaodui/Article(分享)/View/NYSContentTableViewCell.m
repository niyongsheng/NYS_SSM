//
//  NYSContentTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/24.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSContentTableViewCell.h"

@interface NYSContentTableViewCell () <UITextViewDelegate>
@property (strong, nonatomic) UILabel *placeHolderLabel;
@end
@implementation NYSContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.requiredLabel.hidden = YES;
    
    // 手动为textview添加placeholder
    [_contentTextView addSubview:self.placeHolderLabel];
    [_contentTextView setValue:self.placeHolderLabel forKey:@"_placeholderLabel"];
    
    _contentTextView.scrollEnabled = NO;
    _contentTextView.delegate = self;
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textAlignment = NSTextAlignmentRight;
        _placeHolderLabel.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4f];
        _placeHolderLabel.font = _contentTextView.font;
        [_placeHolderLabel sizeToFit];
    }
    return _placeHolderLabel;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    self.placeHolderLabel.text = placeholderStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    CGRect bounds = _contentTextView.bounds;
    // 计算textView的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    _contentTextView.bounds = bounds;
    
    // tableview重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView updateFocusIfNeeded];
    [tableView updateConstraintsIfNeeded];
}

/// 获取cell所属的tableview
- (UITableView *)tableView {
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
