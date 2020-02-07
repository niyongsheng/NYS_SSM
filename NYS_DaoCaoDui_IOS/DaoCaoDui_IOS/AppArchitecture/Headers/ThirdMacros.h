//
//  ThirdMacros.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/3.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

// App Store ID
#define APPID @"1495581916"
// App Store详情页
#define AppStoreURL [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APPID]
// APP 官网
#define AppWebSiteURL @"http://www.daocaodui.top"
// 开源地址
#define GitHubURL @"https://github.com/niyongsheng/NYS_SSM"
// App APIs
#define AppAPIsURL [NSString stringWithFormat:@"%@/api/swagger-ui.html", AppWebSiteURL]
// App Download
#define AppDownloadURL [NSString stringWithFormat:@"%@/web/app/download", AppWebSiteURL]
// App UserProtocol
#define APPUserProtoclURL [NSString stringWithFormat:@"%@/web/user/userProtocol", AppWebSiteURL]

// 友盟+
#define UMengKey          @"5da7bb714ca357079900067c"

// 微信
//#define AppKey_Wechat     @"wxb9604af97b923ffc"
//#define Secret_Wechat     @"9ecfdb6c24bd12f07254c90a46a4ab40"
// 微信（公司）
#define AppKey_Wechat     @"wx76748e36443ee8a2"
#define Secret_Wechat     @""

// 腾讯QQ
#define AppKey_TencentQQ  @"1110076569"
#define Secret_TencentQQ  @"tAixo5nNiK9hum4k"

// 新浪微博
#define AppKey_Sina       @"832766989"
#define Secret_Sina       @"307941eb9b42108238ac2f79991a8b9a"
#define RedirectURL_Sina  @"https://sns.whalecloud.com/sina2/callback"

// 支付宝支付
#define AlipayAPPID       @""

// 极光推送
#define JPUSH_APPKEY      @"7049e8a4eee98723b86a4e6b"
#define JPUSH_CHANNEl     @"App Store"
#define JPUSH_IsProd      YES

// 融云IM
#define RCAPPKEY          @"pkfcgjstpzlt8" // 生产环境
//#define RCAPPKEY          @"bmdehs6pbg3ps" // 开发环境

#endif /* ThirdMacros_h */
