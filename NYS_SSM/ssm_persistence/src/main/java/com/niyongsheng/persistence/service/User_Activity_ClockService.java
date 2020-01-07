package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.User_Activity_Clock;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface User_Activity_ClockService extends IService<User_Activity_Clock> {

    Boolean isClockedToday(String account, Integer activityId);
}
