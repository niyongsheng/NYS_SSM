package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Activity_Clock;
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
}
