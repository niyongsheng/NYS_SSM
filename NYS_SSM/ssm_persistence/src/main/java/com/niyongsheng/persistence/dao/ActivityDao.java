package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Activity;
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
public interface ActivityDao extends BaseMapper<Activity> {

    /**
     * 查询活动列表（活动成员）
     * @param fellowship
     * @param isInGroupAccount
     * @return
     */
    List<Activity> selectByFellowshipMultiTable(@Param("fellowship") Integer fellowship, @Param("isInGroupAccount") String isInGroupAccount);

    /**
     * 查询打卡活动列表（已打卡/未打卡 活动成员）
     * @param activityType
     * @param fellowship
     * @param isInGroupAccount
     * @return
     */
    List<Activity> selectByTypeAndFellowshipMultiTable(@Param("activityType") int activityType, @Param("fellowship") Integer fellowship, @Param("isInGroupAccount") String isInGroupAccount);
}
