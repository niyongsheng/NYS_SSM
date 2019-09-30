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

/** 时间戳格式化yyyy-MM-dd HH:mm:ss */
+ (NSString *)timeFormatWithInterval:(NSTimeInterval)interval;

/** 时间戳格式化yyyy年MM月dd日 HH时mm分 */
+ (NSString *)dateFormatWithInterval:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
