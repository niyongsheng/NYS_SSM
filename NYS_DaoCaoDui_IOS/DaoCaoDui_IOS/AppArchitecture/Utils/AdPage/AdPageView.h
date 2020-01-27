//
//  AdPageView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//
//  APP启动广告页面
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock)(float duration, NSString *targetUrl);

@interface AdPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(TapBlock)tapBlock;

/** 显示广告页面方法 */
- (void)show;

/** 图片路径 */
@property (nonatomic, copy) NSString *filePath;

@end
