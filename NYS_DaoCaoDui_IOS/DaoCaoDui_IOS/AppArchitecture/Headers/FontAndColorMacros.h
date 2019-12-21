//
//  FontAndColorMacros.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -- 设置区 --
#define SettingKey_IsEnableNotification     @"SettingKey_IsEnableNotification"
#define SettingKey_BibleFontSize            @"SettingKey_BibleFontSize"
#define SettingKey_IsEnBible                @"SettingKey_IsEnBible"

#define Settingdefault_IsEnableNotification 1
#define Settingdefault_BibleFontSize 19.0f
#define Settingdefault_BibleVersion @"zh_cuv"

#pragma mark -- 间距区 --
// 默认间距
#define NNormalSpace 12.0f
#define SegmentViewHeight 44.0f
#define CellHeight 55.0f

#pragma mark -- 颜色区 --
// 主题色 导航栏颜色
#define NNavBgColor     [UIColor colorWithHexString:@"FB2044"] // 红(深)
#define NNavBgColorShallow     [UIColor colorWithHexString:@"F63D53"] // 红(浅)

#define NBgColorLightGray     [UIColor colorWithHexString:@"EAEAEA"] // 浅灰
#define NBgColorDrakGray     [UIColor colorWithHexString:@"F0F0F0"]
#define NBgSilverColor  RGBColor(145, 152, 159)
#define NBgSilverColor1  RGBColor(189, 192, 186)
#define NNavFontColor [UIColor colorWithHexString:@"ffffff"] // 灰色

// WKWebView 进度条颜色
#define NWKProgressColor [UIColor colorWithHexString:@"F42A2C"]

// 默认页面背景色
#define NViewBgColor [UIColor whiteColor]
// 分割线颜色
#define NLineColor  [UIColor colorWithHexString:@"ededed"]
// 次级字色
#define NFontColor1 [UIColor colorWithHexString:@"1f1f1f"]
// 再次级字色
#define NFontColor2 [UIColor colorWithHexString:@"5c5c5c"]
// 分栏指示器文字灰色
#define NFontGrayColorSegment RGBColor(161, 160, 160);


#pragma mark -- 字体区 --

#define NFontSize12 [UIFont systemFontOfSize:12.0f]

#endif /* FontAndColorMacros_h */
