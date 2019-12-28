package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.ActivityDao;
import com.niyongsheng.persistence.dao.GroupDao;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.domain.Group;
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

    @Override
    public List<Activity> selectByFellowshipMultiTable(Integer fellowship) {
        return activityDao.selectByFellowshipMultiTable(fellowship);
    }

    @Override
    public void createGroupActivity(Activity activity, Group group) {
        groupDao.insert(group);
        activityDao.insert(activity);
    }
}
