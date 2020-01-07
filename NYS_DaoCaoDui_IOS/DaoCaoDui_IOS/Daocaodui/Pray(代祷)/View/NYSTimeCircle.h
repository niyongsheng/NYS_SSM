//
//  NYSTimeCircle.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYSTimeCircle : UIView

/** ----中心颜色----  */
@property (strong, nonatomic)UIColor *centerColor;

/** ----圆环背景色--- */
@property (strong, nonatomic)UIColor *arcBackColor;

/** ----完成时圆环色---- */
@property (strong, nonatomic)UIColor *arcFinishColor;

/** ----未完成圆环色---- */
@property (strong, nonatomic)UIColor *arcUnfinishColor;

/** ----圆环最初的颜色---- */
@property (strong, nonatomic)UIColor *baseColor;

/** ----开始刷新---- */
@property (nonatomic,assign)BOOL isStartDisplay;

/** ----百分比数值（0-1）---- */
@property (assign, nonatomic)float percent;

/** ----秒数----- */
@property (assign, nonatomic)NSTimeInterval second;

/** ----总秒数----- */
@property (assign, nonatomic)NSTimeInterval totalSecond;

/** ----圆环宽度---- */
@property (assign, nonatomic)float width;


@end
