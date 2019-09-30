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
/** 账号 */
@property (nonatomic, copy) NSString *account;
/** 昵称 */
@property (nonatomic, copy) NSString *nickName;
/** 等级 */
@property (nonatomic, assign) NSInteger vipGrade;
/** 头像 */
@property (nonatomic, copy) NSString *imgAddress;
/** 手机 */
@property (nonatomic, copy) NSString *phone;
/** 性别 */
@property (nonatomic, assign) UserGender sex;
/** Token */
@property (nonatomic, copy) NSString *token;

@end

NS_ASSUME_NONNULL_END
