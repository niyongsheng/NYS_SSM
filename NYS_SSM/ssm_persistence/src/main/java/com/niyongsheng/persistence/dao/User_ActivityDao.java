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
    * 查询用户是否在活动成员列表中
    * @param activityID 活动id
    * @param account 用户account
    * @return
    */
   Boolean selectIsInActivityByAccountAndActivityID(@Param("activityID") Integer activityID, @Param("account") String account);

   /**
    * 查询活动成员数
    * @param activityID 活动id
    * @return
    */
   Integer selectActivityMembersNumByActivityID(Integer activityID);

   /**
    * 查询活动的成员列表
    * @param activityID 活动id
    * @return
    */
   List<User> selectUsersByActivityID(Integer activityID);

   /**
    * 查询用户加入的活动列表
    * @param account 用户account
    * @return
    */
   List<Activity> selectActivitiesByAccount(String account);

   /**
    * 删除多条 活动的用户关系记录
    * @param activityID 活动id
    */
   void deleteRecordsByActivityID(Integer activityID);

   /**
    * 删除一条 活动的用户关系记录
    * @param account 用户account
    * @param activityId 活动id
    */
   void deleteOneByAccountAndActivityID(@Param("account") String account, @Param("activityId") Integer activityId);

}
