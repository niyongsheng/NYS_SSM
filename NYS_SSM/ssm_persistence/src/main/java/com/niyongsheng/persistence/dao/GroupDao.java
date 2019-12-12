package com.niyongsheng.persistence.dao;

import com.niyongsheng.persistence.domain.Group;
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
public interface GroupDao extends BaseDao {

    Group selectByGroupId(String groupId);

    List<Group> selectAllByFellowshipMultiTable(Integer fellowship);
}
