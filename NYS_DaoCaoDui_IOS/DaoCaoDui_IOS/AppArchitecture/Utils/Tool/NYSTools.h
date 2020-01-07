//
//  NYSTools.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSTools : NSObject
/**
 滚动动画
 
 @param duration 滚动显示
 @param layer 作用图层
 */
+ (void)animateTextChange:(CFTimeInterval)duration withLayer:(CALayer *)layer;

/**
 弹性缩放动画
 
 @param button 作用按钮
 */
+ (void)zoomToShow:(UIButton *)button;

/**
 左右晃动动画
 
 @param button 作用按钮
 */
+ (void)swayToShow:(UIButton *)button;

/**
 左右抖动动画（错误提醒）
 
 @param button 作用按钮
 */
+ (void)shakToShow:(UIButton *)button;

/**
 左右抖动动画（错误提醒）
 
 @param layer 左右图层
 */
+ (void)shakeAnimationWithLayer:(CALayer *)layer;

/**
 判断是否为有效手机号码
 
 @param phone 手机号
 @return 是否有效
 */
+ (BOOL)isValidPhone:(NSString *)phone;

/// 将某个时间转化成 时间戳
/// @param formatTime 时间z字符串
/// @param format 格式（@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/// 将某个时间戳转化成 时间
/// @param timestamp 时间戳
/// @param format 格式（@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/**
 时间戳转换成XX分钟之前
 @param timestamp 时间戳
 */
+ (NSString *)timeBeforeInfoWithTimestamp:(NSInteger)timestamp;

/// 计算年纪
/// @param birthdayStr 生日字符串（1991-01-01）
+ (NSInteger)getAgeWithBirthdayString:(NSString *)birthdayStr;

@end

NS_ASSUME_NONNULL_END
