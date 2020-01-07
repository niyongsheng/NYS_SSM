package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.User_Activity_ClockDao;
import com.niyongsheng.persistence.domain.User_Activity_Clock;
import com.niyongsheng.persistence.service.User_Activity_ClockService;
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
public class User_Activity_ClockServiceImpl extends ServiceImpl<User_Activity_ClockDao, User_Activity_Clock> implements User_Activity_ClockService {

    @Autowired
    private User_Activity_ClockDao user_activity_clockDao;

    @Override
    public Boolean isClockedToday(String account, Integer activityId) {
        return user_activity_clockDao.isClockedToday(account, activityId);
    }
}
