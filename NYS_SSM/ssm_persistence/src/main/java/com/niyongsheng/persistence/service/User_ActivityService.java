package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Activity;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface User_ActivityService extends IService<User_Activity> {

    /**
     * 退出活动
     * @param account
     * @param activityId
     */
    void deleteOneByAccountAndActivityID(String account, Integer activityId);

    /**
     * 是否为活动成员
     * @param account
     * @param activityId
     * @return
     */
    Boolean isActivityMember(String account, Integer activityId);

    /**
     * 查询活动的成员列表
     * @param activityID 活动id
     * @return
     */
    List<User> selectUsersByActivityID(Integer activityID);
}
