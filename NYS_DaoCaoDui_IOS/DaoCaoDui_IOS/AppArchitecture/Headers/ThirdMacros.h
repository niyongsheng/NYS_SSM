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
#define APPID @"1438587731"
// App Store详情页
#define AppStoreURL [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APPID]
// APP 官网
//#define AppWebSiteURL @"http://www.daocaodui.top"
#define AppWebSiteURL @"https://github.com/niyongsheng/NYS_SSM"
// App APIs
#define AppAPIsURL [NSString stringWithFormat:@"%@:8080/api/swagger-ui.html", AppWebSiteURL]
// 隐私政策地址
#define APPUserProtoclURL [NSString stringWithFormat:@"%@/protocl", AppWebSiteURL]

// 友盟+
#define UMengKey @"5da7bb714ca357079900067c"

// JSPatch
#define JSPatchKey @"3582a1fb789ad2ce"
#define RSAPublicKey @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCxGb4JS0jbYCZjFQbH5O+jMV67\nfHV601XxH1DZw6Zw4TswLWKgYwkAX7Sz2yWTx3mrgF6yIyslGN01fr5NQlLBjQ1Y\nZL24WtOba6Q2PDrLTFCQuxR55nF/79bAo9gom/+W6Kc6LlL6/lyMZEOOZcO2VO2m\noZeMTGkRQ02qWCi0UQIDAQAB\n-----END PUBLIC KEY-----"

// 微信
#define AppKey_Wechat     @""
#define Secret_Wechat     @""

// 腾讯QQ
#define AppKey_TencentQQ  @"1110076569"
#define Secret_TencentQQ  @"tAixo5nNiK9hum4k"

// 支付宝支付
#define AlipayAPPID       @""

// 极光推送
#define JPUSH_APPKEY      @"7049e8a4eee98723b86a4e6b"
#define JPUSH_CHANNEl     @"App Store"
#define JPUSH_IsProd      YES

// 融云IM
#define RCAPPKEY          @"bmdehs6pbg3ps"

#endif /* ThirdMacros_h */
