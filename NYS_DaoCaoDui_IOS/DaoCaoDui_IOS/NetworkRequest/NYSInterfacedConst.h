//
//  NYSInterfacedConst.h
//  NYSUtils
//
//  CMeated by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DevelopSever 1
#define TestSever    0
#define ProductSever 0

/** 接口前缀-服务器*/
UIKIT_EXTERN NSString *const CR_ApiPrefix;

#pragma mark - 详细接口地址
/** 登录*/
UIKIT_EXTERN NSString *const CR_Login;
/** 退出*/
UIKIT_EXTERN NSString *const CR_Logout;
/** 验证码*/
UIKIT_EXTERN NSString *const CR_SendOneTimeCode;
/** 注册*/
UIKIT_EXTERN NSString *const CR_Regist;
/** 忘记密码*/
UIKIT_EXTERN NSString *const CR_Reset;
/** 修改个人信息*/
UIKIT_EXTERN NSString *const CR_UpdateUserInfo;
/** 签到*/
UIKIT_EXTERN NSString *const CR_DoSign;
/** 积分记录*/
UIKIT_EXTERN NSString *const CR_ScoreRecord;
/** 个人信息提供者*/
UIKIT_EXTERN NSString *const CR_ProviderUserInfo;
/** 群信息提供者*/
UIKIT_EXTERN NSString *const CR_ProviderTeamInfo;
/** 单文件上传*/
UIKIT_EXTERN NSString *const CR_UploadFile;
/** 多图上传*/
UIKIT_EXTERN NSString *const CR_UploadiImages;
/** 获取轮播图*/
UIKIT_EXTERN NSString *const CR_GetBanners;
/** 获取公告*/
UIKIT_EXTERN NSString *const CR_GetPublicnotices;
/** 获取文章列表*/
UIKIT_EXTERN NSString *const CR_GetArticleList;
/** 获取活动列表*/
UIKIT_EXTERN NSString *const CR_GetActivityList;
/** 获取打卡活动列表*/
UIKIT_EXTERN NSString *const CR_GetClockActivityList;
/** 获取代祷列表*/
UIKIT_EXTERN NSString *const CR_GetPrayList;
/** 获取歌单列表*/
UIKIT_EXTERN NSString *const CR_GetMusicMenuList;
/** 获取歌单（含歌曲列表）*/
UIKIT_EXTERN NSString *const CR_GetMusicMenu;
/** 发布分享*/
UIKIT_EXTERN NSString *const CR_PublishArtcle;
/** 发布代祷*/
UIKIT_EXTERN NSString *const CR_PublishPray;
/** 发布音频*/
UIKIT_EXTERN NSString *const CR_PublishMusic;
/** 发布活动*/
UIKIT_EXTERN NSString *const CR_PublishActivity;
/** 结束活动*/
UIKIT_EXTERN NSString *const CR_DismissActivity;
/** 加入活动*/
UIKIT_EXTERN NSString *const CR_JoinActivity;
/** 退出活动*/
UIKIT_EXTERN NSString *const CR_QuitActivity;
/** 群列表*/
UIKIT_EXTERN NSString *const CR_GroupList;
/** 用户列表*/
UIKIT_EXTERN NSString *const CR_UserList;
/** 打卡*/
UIKIT_EXTERN NSString *const CR_PunchClock;
/** 提醒打卡*/
UIKIT_EXTERN NSString *const CR_AlertClock;
/** 本周经文*/
UIKIT_EXTERN NSString *const CR_WeekBible;
/** 好物推荐*/
UIKIT_EXTERN NSString *const CR_Recommend;
/** 收藏/取消收藏文章*/
UIKIT_EXTERN NSString *const CR_CollectionArticle;
/** 收藏/取消收藏代祷*/
UIKIT_EXTERN NSString *const CR_CollectionPray;
/** 收藏/取消收藏音乐*/
UIKIT_EXTERN NSString *const CR_CollectionMusic;
/** 收藏文章列表*/
UIKIT_EXTERN NSString *const CR_CollectionArticleList;
/** 收藏代祷列表*/
UIKIT_EXTERN NSString *const CR_CollectionPrayList;
/** 收藏音乐列表*/
UIKIT_EXTERN NSString *const CR_CollectionMusicList;





/** QQ登录*/
UIKIT_EXTERN NSString *const CR_QQLogoin;
/** 微信登录*/
UIKIT_EXTERN NSString *const CR_WCLogoin;
/** 付费验证*/
UIKIT_EXTERN NSString *const CR_VipValidate;
/** 更新提醒*/
UIKIT_EXTERN NSString *const CR_UpdateTip;
/** 绑定QQ*/
UIKIT_EXTERN NSString *const CR_BindQQ;
/** 绑定微信*/
UIKIT_EXTERN NSString *const CR_BindWeChat;
/** VIP详情*/
UIKIT_EXTERN NSString *const CR_VIPDetails;
