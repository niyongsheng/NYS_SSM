package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Activity;
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
public interface User_ActivityDao extends BaseMapper<User_Activity> {
   /**
    * 查询用户是否在群组中
    * @param activityID 群id
    * @param account 用户account
    * @return
    */
   Boolean selectIsInGroupByAccountAndActivityID(@Param("activityID") Integer activityID, @Param("account") String account);

   /**
    * 查询群成员数
    * @param activityID 群id
    * @return
    */
   Integer selectGroupMembersNumByActivityID(Integer activityID);

   /**
    * 查询群组的成员列表
    * @param activityID 群id
    * @return
    */
   List<User> selectUsersByActivityID(Integer activityID);

   /**
    * 查询用户加入的群组列表
    * @param account 用户account
    * @return
    */
   List<Activity> selectActivitiesByAccount(String account);
}
