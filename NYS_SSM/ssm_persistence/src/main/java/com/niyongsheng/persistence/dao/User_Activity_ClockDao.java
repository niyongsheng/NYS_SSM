package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Activity_Clock;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface User_Activity_ClockDao extends BaseMapper<User_Activity_Clock> {
    /**
     * 查询今天已打卡用户列表
     * @param activityID
     * @return
     */
    List<User> selectTodayClockedUsersByActivityID(Integer activityID);

    /**
     * 查询今天未打卡用户列表
     * @param activityID
     * @return
     */
    List<User> selectTodayUnclockUsersByActivityID(Integer activityID);

    /**
     * 查询用户今天是否已经打过卡
     * @param account
     * @param activityId
     * @return
     */
    Boolean isClockedToday(@Param("account") String account, @Param("activityId") Integer activityId);
}
