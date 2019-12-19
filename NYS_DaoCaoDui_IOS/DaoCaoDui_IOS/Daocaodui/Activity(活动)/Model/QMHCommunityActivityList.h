//
//  QMHCommunityActivityList.h
//  安居公社
//
//  Created by 倪刚 on 2018/5/4.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMHCommunityActivityList : NSObject
// 社区活动ID
@property (nonatomic, copy) NSString *ID;
// 群ID
@property (nonatomic, copy) NSString *groupId;
// 活动标题
@property (nonatomic, copy) NSString *title;
// 活动内容
@property (nonatomic, copy) NSString *content;
// 人数
@property (nonatomic, copy) NSString *memberNum;
// 社区id
@property (nonatomic, copy) NSString *comNo;
// 社区名
@property (nonatomic, copy) NSString *comName;
// 创建人
@property (nonatomic, copy) NSString *creator;
// 活动图片地址
@property (nonatomic, copy) NSString *imgAddress;
// 活动创建时间
@property (nonatomic, copy) NSString *gmtCreate;
// 活动修改时间
@property (nonatomic, copy) NSString *gmtModify;
// 有效时间
@property (nonatomic, copy) NSString *validity;
// 是否有效
@property (nonatomic, copy) NSString *status;
// 是否置顶
@property (nonatomic, copy) NSString *isTop;
// 是否是群成员
@property (nonatomic, copy) NSString *inGroup;

//+ (instancetype)communityActivityListWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;
@end
