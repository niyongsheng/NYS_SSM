//
//  NYSNickNameLbel.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/30.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 昵称Label 包含 昵称 性别 年龄 等级
 */
@interface NYSNickNameLbel : UIView


- (void)setNickName:(NSString *)nickName sex:(UserGender)sex age:(NSInteger)age level:(NSInteger)level;

@end
