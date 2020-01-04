package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.domain.User_Activity;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface ActivityService extends IService<Activity> {
    /**
     * 连表查群组成员数、是否为群成员
     * @param fellowship 团契
     * @param isInGroupAccount 判断是否为群成员账号
     * @return
     */
    List<Activity> selectByFellowshipMultiTable(Integer fellowship, String isInGroupAccount);

    /**
     * 创建活动群组
     * @param activity 活动
     * @param group 群组
     * @param user_activity 活动-群组 关系对照
     */
    void createGroupActivity(Activity activity, Group group, User_Activity user_activity);

    /**
     * 创建活动
     * @param activity 活动
     * @param user_activity 活动-群组 关系对照
     */
    void createActivity(Activity activity, User_Activity user_activity);

    /**
     * 结束活动
     * @param activity
     */
    void dismissGroupActivity(Activity activity);

    /**
     * 查询打卡活动列表
     * @param activityType
     * @param fel
     * @param account
     * @return
     */
    List<Activity> selectByTypeAndFellowshipMultiTable(int activityType, Integer fel, String account);
}
