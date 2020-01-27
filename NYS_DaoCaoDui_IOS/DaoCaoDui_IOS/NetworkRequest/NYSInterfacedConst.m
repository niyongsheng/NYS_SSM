//
//  NYSInterfacedConst.m
//  NYSUtils
//
//  CMeated by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSInterfacedConst.h"

#if DevelopSever
/** 接口前缀-开发服务器*/
NSString *const CR_ApiPrefix = @"http://192.168.31.182:8080/api";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const CR_ApiPrefix = @"http://192.168.1.106:8080/api";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const CR_ApiPrefix = @"http://www.daocaodui.top/api";
#endif

/** 登录*/
NSString *const CR_Login = @"/user/login";
/** Apple登录*/
NSString *const CR_LoginByApple = @"/user/loginWithApple";
/** 退出*/
NSString *const CR_Logout = @"/user/logout";
/** 验证码*/
NSString *const CR_SendOneTimeCode = @"/user/getOnceCode";
/** 注册*/
NSString *const CR_Regist = @"/user/phoneRegister";
/** 忘记密码*/
NSString *const CR_Reset = @"/user/resetUserPassword";
/** 修改个人信息*/
NSString *const CR_UpdateUserInfo = @"/user/updateInfoForUser";
/** 签到*/
NSString *const CR_DoSign = @"/scorelog/signToday";
/** 积分记录*/
NSString *const CR_ScoreRecord = @"/scorelog/selectScorelogList";
/** 个人信息提供者*/
NSString *const CR_ProviderUserInfo = @"/user/providerInfoForUser";
/** 群信息提供者*/
NSString *const CR_ProviderTeamInfo = @"/group/providerInfoForGroup";
/** 群组成员信息提供者*/
NSString *const CR_ProviderTeamMembersInfo = @"/group/selectGroupMemberListById";
/** 单文件上传*/
NSString *const CR_UploadFile = @"/file/uploadFile";
/** 多图上传*/
NSString *const CR_UploadiImages = @"/file/uploadFiles";
/** 获取轮播图*/
NSString *const CR_GetBanners = @"/banner/selectBannerList";
/** 获取公告*/
NSString *const CR_GetPublicnotices = @"/publicnotice/selectPublicnoticeList";
/** 获取文章列表*/
NSString *const CR_GetArticleList = @"/article/selectArticleList";
/** 获取活动列表*/
NSString *const CR_GetActivityList = @"/activity/selectActivityList";
/** 获取打卡活动列表*/
NSString *const CR_GetClockActivityList = @"/activity/selectClockActivityList";
/** 获取代祷列表*/
NSString *const CR_GetPrayList = @"/pray/selectPrayList";
/** 获取歌单列表*/
NSString *const CR_GetMusicMenuList = @"/musicSongMenu/selectMusicMenuList";
/** 获取歌单（含歌曲列表）*/
NSString *const CR_GetMusicMenu = @"/musicSongMenu/selectMusicListById";
/** 发布分享*/
NSString *const CR_PublishArtcle = @"/article/publishArticle";
/** 发布代祷*/
NSString *const CR_PublishPray = @"/pray/publishPray";
/** 发布音频*/
NSString *const CR_PublishMusic = @"/music/publishMusic";
/** 发布活动*/
NSString *const CR_PublishActivity = @"/activity/publishActivity";
/** 结束活动*/
NSString *const CR_DismissActivity = @"/activity/dismissActivity";
/** 加入活动*/
NSString *const CR_JoinActivity = @"/activity/joinActivity";
/** 退出活动*/
NSString *const CR_QuitActivity = @"/activity/quitActivity";
/** 群列表*/
NSString *const CR_GroupList = @"/group/findAllGroups";
/** 用户列表*/
NSString *const CR_UserList = @"/user/findAllUsers";
/** 打卡*/
NSString *const CR_PunchClock = @"/activity/punchClockActivity";
/** 提醒打卡*/
NSString *const CR_AlertClock = @"/activity/alertClockActivity";
/** 本周经文*/
NSString *const CR_WeekBible = @"/bible/selectWeekBible";
/** 好物推荐*/
NSString *const CR_Recommend = @"/recommend/selectRecommendList";
/** 收藏/取消收藏文章*/
NSString *const CR_CollectionArticle = @"/article/collectionInOrOut";
/** 收藏/取消收藏代祷*/
NSString *const CR_CollectionPray = @"/pray/collectionInOrOut";
/** 收藏/取消收藏音乐*/
NSString *const CR_CollectionMusic = @"/music/collectionInOrOut";
/** 收藏文章列表*/
NSString *const CR_CollectionArticleList = @"/article/selectCollectionArticleList";
/** 收藏代祷列表*/
NSString *const CR_CollectionPrayList = @"/pray/selectCollectionPrayList";
/** 收藏音乐列表*/
NSString *const CR_CollectionMusicList = @"/music/selectCollectionMusicList";
/** 发布的文章列表*/
NSString *const CR_PublishArticleList = @"/article/selectMyArticleList";
/** 发布的代祷列表*/
NSString *const CR_PublishPrayList = @"/pray/selectMyPrayList";
/** 发布的音乐列表*/
NSString *const CR_PublishMusicList = @"/music/selectMyMusicList";
/** 删除文章*/
NSString *const CR_DeleteArticle = @"/article/deleteArticleById";
/** 删除代祷*/
NSString *const CR_DeletePray = @"/pray/deletePrayById";
/** 删除音乐*/
NSString *const CR_DeleteMusic = @"/music/deleteMusicById";
/** 获取团契列表*/
NSString *const CR_FellowshipList = @"/fellowship/selectFellowshipList";
/** QQ登录*/
NSString *const CR_QQLogoin = @"/user/qqRegister";
/** 微信登录*/
NSString *const CR_WCLogoin = @"/user/wxRegister";
/** 刷新用户信息*/
NSString *const CR_RefreshUserInfo = @"/user/refreshUserInfo";
/** 举报*/
NSString *const CR_UserReport = @"/report/userReport";
/** 检索圣经*/
NSString *const CR_BibleSearchList = @"/bible/selectBibleList";
/** 获取广告列表*/
NSString *const CR_GetAdvertisementList = @"/advertisement/selectAdvertisementList";








/** 付费验证*/
NSString *const CR_VipValidate = @"";
/** 更新提醒*/
NSString *const CR_UpdateTip = @"";
/** VIP详情*/
NSString *const CR_VIPDetails = @"";
