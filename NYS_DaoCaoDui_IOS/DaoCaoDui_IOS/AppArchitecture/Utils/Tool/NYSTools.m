//
//  NYSTools.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSTools.h"

@implementation NYSTools
/**
 滚动动画
 
 @param duration 滚动显示
 @param layer 作用图层
 */
+ (void)animateTextChange:(CFTimeInterval)duration withLayer:(CALayer *)layer {
    CATransition *trans = [[CATransition alloc] init];
    trans.type = kCATransitionMoveIn;
    trans.subtype = kCATransitionFromTop;
    trans.duration = duration;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [layer addAnimation:trans forKey:kCATransitionPush];
}

/**
 弹性缩放动画
 
 @param button 作用按钮
 */
+ (void)zoomToShow:(UIButton *)button {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .5f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 2.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.5)]];
    
    animation.values = values;
    [button.layer addAnimation:animation forKey:nil];
}

/**
 左右晃动动画
 
 @param button 作用按钮
 */
+ (void)swayToShow:(UIButton *)button {
    //创建动画
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI),@(0 /180.0 * M_PI)];//度数转弧度
    keyAnimaion.removedOnCompletion = YES;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.37;
    keyAnimaion.repeatCount = 0;
    [button.layer addAnimation:keyAnimaion forKey:nil];
}

/**
 按钮左右抖动动画（错误提醒）
 
 @param button 作用按钮
 */
+ (void)shakToShow:(UIButton *)button {
    CGFloat t = 4.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    button.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        button.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                button.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

/**
 左右抖动动画（错误提醒）
 
 @param layer 左右图层
 */
+ (void)shakeAnimationWithLayer:(CALayer *)layer {
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
 判断是否为有效手机号码
 
 @param phone 手机号
 @return 是否有效
 */
+ (BOOL)isValidPhone:(NSString *)phone {
    if (phone.length != 11) {
        return NO;
    } else {
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phoneTest evaluateWithObject:phone];
    }
}

/** 时间戳格式化yyyy-MM-dd HH:mm:ss */
+ (NSString *)timeFormatWithInterval:(NSTimeInterval)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate: date];
}

/** 时间戳格式化yyyy年MM月dd日 HH时mm分 */
+ (NSString *)dateFormatWithInterval:(NSTimeInterval)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    return [formatter stringFromDate: date];
}

@end
