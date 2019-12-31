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
    /**
     * 连表查群组成员数、是否为群成员
     * @param fellowship 团契
     * @param isInGroupAccount 判断是否为群成员账号
     * @return
     */
    List<Activity> selectByFellowshipMultiTable(Integer fellowship, String isInGroupAccount);

    void createGroupActivity(Activity activity, Group group, User_Activity user_activity);
}
