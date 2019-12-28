//
//  NYSAlert.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/26.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSAlert : UIView

#pragma mark - 纯文本toast提示
/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message;

#pragma mark - 图文toast提示
/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName;

#pragma mark - 提交成功提示弹框
/** 带按钮回调的成功提示弹框 */
+ (void)showSuccessAlertWithTitle:(NSString *)title message:(NSString *)message okButtonClickedBlock:(void(^)(void))okButtonClickedBlock;

#pragma mark - 提交失败提示弹框
/** 带按钮回调的失败提示弹框 */
+ (void)showFailAlertWithTitle:(NSString *)title message:(NSString *)message okButtonClickedBlock:(void(^)(void))okButtonClickedBlock;


/*------------------------ TODO -----------------------------*/
#pragma mark - 带block回调的弹窗
/** 带block回调的弹窗 */
+ (void)showAlertWithButtonClickedBlock:(void(^)(void))buttonClickedBlock;


#pragma mark - 带网络图片与block回调的弹窗
/** 带网络图片与block回调的弹窗 */
+ (void)showAlertWithImageURL:(NSString *)imageURL ButtonClickedBlock:(void(^)(void))buttonClickedBlock;


#pragma mark - 炫彩弹窗
/**
 兑换成功后展示的弹窗
 
 @param couponName 优惠券名称
 @param validityTime 有效期
 @param checkButtonClickedBlock “查看优惠券”按钮点击后的回调
 */
+ (void)showConversionSucceedAlertWithCouponName:(NSString *)couponName validityTime:(NSString *)validityTime checkCouponButtonClickedBlock:(void(^)(void))checkButtonClickedBlock;

@end

NS_ASSUME_NONNULL_END
