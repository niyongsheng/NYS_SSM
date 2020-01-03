package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.User_ActivityDao;
import com.niyongsheng.persistence.domain.User_Activity;
import com.niyongsheng.persistence.service.User_ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service
public class User_ActivityServiceImpl extends ServiceImpl<User_ActivityDao, User_Activity> implements User_ActivityService {

    @Autowired
    private User_ActivityDao user_activityDao;

    @Override
    public void deleteOneByAccountAndActivityID(String account, Integer activityId) {
        user_activityDao.deleteOneByAccountAndActivityID(account, activityId);
    }
}
