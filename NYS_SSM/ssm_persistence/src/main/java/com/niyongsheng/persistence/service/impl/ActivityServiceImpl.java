package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.ActivityDao;
import com.niyongsheng.persistence.dao.GroupDao;
import com.niyongsheng.persistence.dao.User_ActivityDao;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.domain.User_Activity;
import com.niyongsheng.persistence.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service("activityService")
public class ActivityServiceImpl extends ServiceImpl<ActivityDao, Activity> implements ActivityService {

    @Autowired
    private ActivityDao activityDao;

    @Autowired
    private GroupDao groupDao;

    @Autowired
    private User_ActivityDao user_activityDao;

    @Override
    public List<Activity> selectByFellowshipMultiTable(Integer fellowship) {
        return activityDao.selectByFellowshipMultiTable(fellowship);
    }

    @Override
    public void createGroupActivity(Activity activity, Group group, User_Activity user_activity) {
        // 1.创建群组
        groupDao.insert(group);
        // 2.创建活动
        activityDao.insert(activity);
        // 3.添加群成员（群主）
        user_activityDao.insert(user_activity);
    }
}
