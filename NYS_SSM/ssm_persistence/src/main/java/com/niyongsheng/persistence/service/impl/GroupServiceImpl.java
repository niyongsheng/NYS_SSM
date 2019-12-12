package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.dao.BaseDao;
import com.niyongsheng.persistence.dao.GroupDao;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.service.GroupService;
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
@Service("groupService")
public class GroupServiceImpl extends BaseServiceImpl<Group> implements GroupService {

    @Autowired
    GroupDao groupDao;

    @Override
    protected BaseDao getDao() {
        return groupDao;
    }

    @Override
    public Group selectByGroupId(String groupId) {
        return groupDao.selectByGroupId(groupId);
    }

    @Override
    public List<Group> selectAllByFellowshipMultiTable(Integer fellowship) {
        return groupDao.selectAllByFellowshipMultiTable(fellowship);
    }
}
