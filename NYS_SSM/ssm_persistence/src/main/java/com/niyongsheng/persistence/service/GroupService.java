package com.niyongsheng.persistence.service;

import com.niyongsheng.persistence.domain.Group;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface GroupService extends BaseService<Group> {

    Group selectByGroupId(String groupId);
}
