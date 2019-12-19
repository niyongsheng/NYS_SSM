//
//  QMHCommunityActivityDetail.h
//  安居公社
//
//  Created by 倪刚 on 2018/5/23.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMHCommunityActivityDetail : NSObject
// 社区活动ID
@property (nonatomic, assign) NSInteger ID;
// 群组Id
@property (nonatomic, copy) NSString *groupId;
// 活动标题
@property (nonatomic, copy) NSString *title;
// 活动内容
@property (nonatomic, copy) NSString *content;
// 成员数
@property (nonatomic, copy) NSString *memberNum;
// 社区id
@property (nonatomic, copy) NSString *comNo;
// 社区名
@property (nonatomic, copy) NSString *comName;
// 创建人账号
@property (nonatomic, copy) NSString *creator;
// 创建人昵称
@property (nonatomic, copy) NSString *nickName;
// 活动图片地址
@property (nonatomic, copy) NSString *imgAddress;
// 活动创建时间
@property (nonatomic, copy) NSString *gmtCreate;
// 活动修改时间
@property (nonatomic, copy) NSString *gmtModify;
// 是否置顶
@property (nonatomic, assign) NSInteger isTop;
// 是否有效（1：有效；0：无效）
@property (nonatomic, assign) NSInteger status;
// 是否已报名状态（0：已报名；1：未报名）
//@property (nonatomic, copy) NSString *joinStatus;

@end
