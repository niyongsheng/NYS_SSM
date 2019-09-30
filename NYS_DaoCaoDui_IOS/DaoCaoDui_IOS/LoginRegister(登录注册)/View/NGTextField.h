//
//  NGTextField.h
//  安居公社
//
//  Created by 倪刚 on 2018/4/19.
//  Copyright © 2018年 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSTextField.h"

typedef void(^ClickRightButtonBlock)(NSString *value);
typedef void(^ClickLeftButtonBlock)(NSString *value);

@interface NGTextField : UIView
@property(strong, nonatomic) NYSTextField *textField;
/**
 customKeyboardType键盘类型
 1:number 2:phone 3:namePhone 4:Email null:defalut
 */
@property(assign, nonatomic)NSInteger customKeyboardType;
/**
 customKeyboardType键盘类型
 1:username 2:password 3:timecode
 */
@property(assign, nonatomic)NSInteger contentType;
/**
 toolbarTitle键盘工具栏提示
 */
@property(weak, nonatomic)NSString *toolbarTitle;
/**
 placeHolderColor密码以小圆点显示
 */
@property(assign, nonatomic)BOOL isSecureTextEntry;
/**
 placeHolderColor颜色
 */
@property(strong, nonatomic)UIColor *placeHolderColor;

/**
 限制输入字符的长度 默认是最大值
 */
@property(assign, nonatomic)NSInteger limitNumber;

/**
 placeholder提示字符
 */
@property(strong, nonatomic)NSString *placeholder;

/**
 允许输入的字符串类型  默认是空值   为空的时候表示可以输入任意类型
 */
@property(strong, nonatomic)NSString *inputStringType;

/**
 自定义textField右边视图
 */
@property(strong, nonatomic)UIView *customRightView;

/**
 自定义textField左边视图
 */
@property(strong, nonatomic)UIView *customLeftView;

/**
 点击右边按钮的回调
 */
@property(copy, nonatomic)ClickRightButtonBlock clickRightButtonBlock;
/**
 长安右边按钮的回调
 */
//@property(copy, nonatomic)ClickRightButtonBlock LongPressRightButtonBlock;

/**
 点击右边按钮的回调
 */
@property(copy, nonatomic)ClickLeftButtonBlock clickLeftButtonBlock;
@end

