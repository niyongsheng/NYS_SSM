package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.domain.User_Activity;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface ActivityService extends IService<Activity> {
    List<Activity> selectByFellowshipMultiTable(Integer fellowship);

    void createGroupActivity(Activity activity, Group group, User_Activity user_activity);
}
