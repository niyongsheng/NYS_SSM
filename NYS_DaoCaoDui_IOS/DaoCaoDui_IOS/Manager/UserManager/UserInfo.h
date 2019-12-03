//
//  UserInfo.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/31.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,UserGender){
    UserGenderUnKnow = 0,
    UserGenderMale, // 男
    UserGenderFemale // 女
};

@interface UserInfo : NSObject
/// id
@property (nonatomic, assign) NSInteger ID;
/// 账户
@property (nonatomic, strong) NSString * account;
/// 地址
@property (nonatomic, strong) NSString * address;
/// 邮箱
@property (nonatomic, strong) NSString * email;
/// 团契代号
@property (nonatomic, assign) NSInteger fellowship;
/// 性别
@property (nonatomic, strong) NSString * gender;
/// 等级
@property (nonatomic, assign) NSInteger grade;
/// 头像url
@property (nonatomic, strong) NSString * icon;
/// Token
@property (nonatomic, strong) NSString * token;
/// IMToken
@property (nonatomic, strong) NSString * imToken;
/// 简介
@property (nonatomic, strong) NSString * introduction;
/// 昵称
@property (nonatomic, strong) NSString * nickname;
/// 密码
@property (nonatomic, strong) NSString * password;
/// 手机号
@property (nonatomic, strong) NSString * phone;
/// 身份
@property (nonatomic, assign) NSInteger profession;
/// 积分
@property (nonatomic, assign) NSInteger score;
/// 状态
@property (nonatomic, assign) BOOL status;
/// 姓名
@property (nonatomic, strong) NSString * truename;
/// QQ_Openid
@property (nonatomic, strong) NSString * qqOpenid;
/// 微信_Openid
@property (nonatomic, strong) NSString * wcOpenid;
/// 生日
@property (nonatomic, strong) NSString *birthday;
/// 创建时间
@property (nonatomic, assign) NSInteger gmtCreate;
/// 修改时间
@property (nonatomic, assign) NSInteger gmtModify;

@end

NS_ASSUME_NONNULL_END
