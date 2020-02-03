//
//  MBProgressHUD+NYS.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/28.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "MBProgressHUD+NYS.h"

const NSInteger hideTime = 2;

@implementation MBProgressHUD (NYS)

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[NAppDelegate getCurrentUIVC].view;
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    }else{
        [hud showAnimated:YES];
    }
    hud.minSize = CGSizeMake(100, 100);
    hud.label.text=message?message:@"加载中...";
    hud.label.font=[UIFont systemFontOfSize:15];
    hud.label.textColor= [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.9];
    hud.removeFromSuperViewOnHide = YES;
    [hud setContentColor:[UIColor whiteColor]];
    //    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:hideTime];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:hideTime];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(float)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)showTipMessageInView:(NSString*)message timer:(float)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:hideTime];
}
#pragma mark-------------------- show Activity----------------------------

+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(float)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(float)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

+ (void)showSuccessMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Success" message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Error" message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Info" message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Warn" message:Message];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false];
}
+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:hideTime];
}
+ (void)hideHUD
{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[NAppDelegate getCurrentUIVC].view animated:YES];
}

#pragma mark ——--— 顶部tip ——--—
+ (void)showTopTipMessage:(NSString *)msg {
    [self showTopTipMessage:msg isWindow:NO];
}
+ (void)showTopTipMessage:(NSString *)msg isWindow:(BOOL) isWindow{
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor colorWithRed:0.98 green:0.12 blue:0.26 alpha:0.8];
    label.backgroundColor = [UIColor colorWithRed:1.00 green:0.71 blue:0.17 alpha:0.8];
    label.width = NScreenWidth;
    label.textContainerInset = UIEdgeInsetsMake(padding+padding, padding, 0, padding);
    
    if (isWindow) {
        label.height = NTopHeight;
        label.bottom = 0;
        [NAppWindow addSubview:label];
        
        [UIView animateWithDuration:0.3 animations:^{
            label.top = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                label.bottom = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
        
    }else{
        label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
        label.bottom = (kiOS7Later ? 64 : 0);
        [[NAppDelegate getCurrentUIVC].view addSubview:label];
        
        [UIView animateWithDuration:0.3 animations:^{
            label.top = (kiOS7Later ? 64 : 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                label.bottom = (kiOS7Later ? 64 : 0);
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
        
    }
    
}

@end
