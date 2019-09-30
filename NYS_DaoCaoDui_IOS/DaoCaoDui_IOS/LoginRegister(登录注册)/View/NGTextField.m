//
//  NGTextField.m
//  安居公社
//
//  Created by 倪刚 on 2018/4/19.
//  Copyright © 2018年 NiYongsheng. All rights reserved.
//

#import "NGTextField.h"
//#import <NYSTK/NSString+NTK.h>

static NSString *textFieldChangeKey = @"textFieldChangeKey";

@interface NGTextField () <UITextFieldDelegate>

@end


@implementation NGTextField

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.textField = [[NYSTextField alloc] initWithFrame:self.bounds];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.clearButtonMode = UITextFieldViewModeAlways;
        self.textField.clearsOnBeginEditing = YES;
        self.textField.delegate = self;
        self.textField.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.textField];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierKeyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifierKeyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        
    }
    return self;
}


#pragma mark - 私有方法

- (void)hx_shakeAnimation {
    
    CALayer* layer = [self layer];
    CGPoint position = [layer position];
    CGPoint y = CGPointMake(position.x - 3.0f, position.y);
    CGPoint x = CGPointMake(position.x + 3.0f, position.y);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08f];
    [animation setRepeatCount:3];
    [layer addAnimation:animation forKey:nil];
}


/**
 键盘上工具条
 */
- (UIToolbar*) generateToolbar:(NSString *)toolbarTitle {
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:toolbarTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    item1.tintColor = [UIColor grayColor];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonDidPressed:)];
    item2.tintColor = [UIColor colorWithRed:0.31 green:0.56 blue:1.50 alpha:1.00];
    [toolbar setItems:[NSArray arrayWithObjects:item1, itemSpace, item2, nil]];
    
    return toolbar;
}

- (void) doneButtonDidPressed:(id)sender {
    [self endEditing:YES];
}


/**
 复制、粘贴、选择、全选
 */
- (BOOL) canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(copy:) ||
        action == @selector(paste:) ||
        action == @selector(select:) ||
        action == @selector(selectAll:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    
    [self.textField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    self.textField.placeholder = placeholder;
}

/**
 初始化键盘类型
 */
- (void)setCustomKeyboardType:(NSInteger)customKeyboardType {
    _customKeyboardType = customKeyboardType;
    switch (customKeyboardType) {
        case 1:
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
            
        case 2:
            self.textField.keyboardType = UIKeyboardTypePhonePad;
            break;
            
        case 3:
            self.textField.keyboardType = UIKeyboardTypeNamePhonePad;
            break;
            
        case 4:
            self.textField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
            
        default:
            self.textField.keyboardType = UIKeyboardTypeDefault;
            break;
    }
}

- (void)setContentType:(NSInteger)contentType {
    _contentType = contentType;
    if (@available(iOS 11.0, *)) {
        switch (contentType) {
            case 1:
                self.textField.textContentType = UITextContentTypeUsername;
                break;
            
            case 2:
                self.textField.textContentType = UITextContentTypePassword;
                break;
                
            case 3:
                if (@available(iOS 12.0, *))
                    self.textField.textContentType = UITextContentTypeOneTimeCode;
                break;
                
            default:
                break;
        }
    }
}

- (void)setToolbarTitle:(NSString *)toolbarTitle {
    _toolbarTitle = toolbarTitle;
    self.textField.inputAccessoryView = [self generateToolbar:toolbarTitle];
}

/**
 初始化右边自定义view
 */
- (void) setCustomRightView:(UIView *)customRightView {
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    self.textField.clearButtonMode = UITextFieldViewModeNever;
    self.textField.rightView = customRightView;
    if ([customRightView isKindOfClass:[UIButton class]]) {
        UIButton *rightButton = (UIButton *)customRightView;
        [rightButton addTarget:self action:@selector(clickDownRightButton) forControlEvents:UIControlEventTouchDown];
        [rightButton addTarget:self action:@selector(clickCancelRightButton) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
}

- (void) clickRightButton {
    
    if (self.clickRightButtonBlock) {
        [self endEditing:YES];
        self.clickRightButtonBlock(self.textField.text);
    }
}

- (void)clickDownRightButton {
    self.textField.secureTextEntry = NO;
}

- (void)clickCancelRightButton {
    self.textField.secureTextEntry = YES;
}

/**
 初始化左边自定义view
 */
- (void) setCustomLeftView:(UIView *)customLeftView {
    
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.clearButtonMode = UITextFieldViewModeNever;
    self.textField.leftView = customLeftView;
    if ([customLeftView isKindOfClass:[UIButton class]]) {
        UIButton *rightButton = (UIButton *)customLeftView;
        [rightButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) clickLeftButton {
    
    if (self.clickLeftButtonBlock) {
        [self endEditing:YES];
        self.clickLeftButtonBlock(self.textField.text);
    }
}

/**
 是否以小圆点显示输入框内容
 */
- (void)setIsSecureTextEntry:(BOOL)isSecureTextEntry{
    if (isSecureTextEntry == YES) {
        self.textField.secureTextEntry = YES;
    } else {
        self.textField.secureTextEntry = NO;
    }
}
/*
 //控制placeHolder的位置，左右缩20
 - (CGRect) placeholderRectForBounds:(CGRect)bounds{
 
 CGSize size  = [[NSString string] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.textField.font, NSFontAttributeName, nil]];
 CGRect inset = CGRectMake(bounds.origin.x + 3,
 0.0f,
 bounds.size.width,
 size.height);//更好理解些
 return inset;
 }
 
 #pragma mark - 控制文本位置 (下面两个要配合使用)
 - (CGRect) editingRectForBounds:(CGRect)bounds{
 //控制文本位置 向下移动5个像素
 return CGRectInset(bounds, 3, 0);
 }
 //设置文字边距
 - (CGRect) textRectForBounds:(CGRect)bounds {
 
 return CGRectMake(bounds.origin.x + 3, bounds.origin.y, bounds.size.width, bounds.size.height);
 
 }
 */
#pragma mark - NSNotificationCenter
- (void) notifierKeyboardWillShow:(NSNotification*)notification {
    
    UIView* subView = nil;
    if ([NSStringFromClass(self.superview.class) isEqualToString:@"UITableViewCellContentView"] || [NSStringFromClass(self.superview.superview.superview.superview.class) isEqualToString:@"UITableViewCellContentView"]) {
        subView = self.superview.superview.superview;
        while (subView != nil) {
            if ([subView.superview isKindOfClass:[UITableView class]]) {
                subView = subView.superview;
                break;
            }
            subView = subView.superview;
        }
        UITableView* tableView = (UITableView*)subView;
        
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        NSDictionary *info                   = notification.userInfo;
        CGRect screenFrame                   = [tableView.superview convertRect:tableView.frame
                                                                         toView:[UIApplication sharedApplication].keyWindow];
        CGFloat tableViewBottomOnScreen      = screenFrame.origin.y + screenFrame.size.height;
        CGFloat tableViewGap                 = screenHeight - tableViewBottomOnScreen;
        CGSize keyboardSize                  = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        UIEdgeInsets contentInsets           = tableView.contentInset;
        contentInsets.bottom                 = keyboardSize.height - tableViewGap;
        
        
        CGFloat animationDuration            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
        NSUInteger animationCurve            = ((NSNumber *)[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]).intValue;
        
        
        
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:animationCurve
                         animations: ^{
                             tableView.contentInset          = contentInsets;
                             tableView.scrollIndicatorInsets = contentInsets;
                             
                         }
         
                         completion:nil];
        
    }
    
}

- (void) notifierKeyboardWillHide:(NSNotification*)notification {
    UIView* subView = nil;
    if ([NSStringFromClass(self.superview.class) isEqualToString:@"UITableViewCellContentView"] || [NSStringFromClass(self.superview.superview.superview.superview.class) isEqualToString:@"UITableViewCellContentView"]) {
        subView = self.superview.superview.superview;
        while (subView != nil) {
            if ([subView.superview isKindOfClass:[UITableView class]]) {
                subView = subView.superview;
                break;
            }
            subView = subView.superview;
        }
        UITableView* tableView = (UITableView*)subView;
        
        NSDictionary *info = notification.userInfo;
        
        CGFloat animationDuration = ((NSNumber *)[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
        NSUInteger animationCurve = ((NSNumber *)[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]).intValue;
        
        [UIView animateWithDuration:animationDuration
                              delay:0.25f
                            options:animationCurve
                         animations: ^{
                             tableView.contentInset          = UIEdgeInsetsZero;//contentInsets;
                             tableView.scrollIndicatorInsets = UIEdgeInsetsZero;//contentInsets;
                         }
         
                         completion:nil];
    }
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.limitNumber = (self.limitNumber == 0) ? MAXFLOAT : self.limitNumber;
    
    if (![self.inputStringType isNotBlank] && textField.text.length < self.limitNumber) {
        NSString *textString = [textField.text stringByAppendingString:string];
        if (textString.length <= self.limitNumber) {
            return YES;
        } else {
            textField.text = [textString substringToIndex:self.limitNumber];
            [self hx_shakeAnimation];
            return NO;
        }
    }
    if (![self.inputStringType isNotBlank]) {
        // 获取输入法
        NSString *lang = textField.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            // 这个range就是指输入的拼音还没有转换成中文时的range
            // 如果没有就表示已经转成中文了(存在就表示没有转换成中文)
            UITextRange *selectedRange = [textField markedTextRange];
            if (selectedRange || [string isEqualToString:@""]){
                if (textField.text.length > self.limitNumber && ![string isEqualToString:@""]) {
                    textField.text = [textField.text substringToIndex:self.limitNumber];
                    [self hx_shakeAnimation];
                    return NO;
                }else{
                    if (textField.text.length == self.limitNumber && ![string isEqualToString:@""]){
                        textField.text = [textField.text substringToIndex:self.limitNumber];
                    }
                    return YES;
                }
            }else{
                [self hx_shakeAnimation];
                return NO;
            }
        }else if (textField.text.length < self.limitNumber || [string length] == 0) {
            return YES;
        }else {
            [self hx_shakeAnimation];
            return NO;
        }
    } else {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:self.inputStringType] invertedSet];
        // 按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL canChange     = [string isEqualToString:filtered];
        
        if ((canChange && textField.text.length < self.limitNumber) || [string length] == 0) {
            return YES;
        }else {
            [self hx_shakeAnimation];
            return NO;
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self removeObserver:self forKeyPath:textFieldChangeKey];
}

@end

