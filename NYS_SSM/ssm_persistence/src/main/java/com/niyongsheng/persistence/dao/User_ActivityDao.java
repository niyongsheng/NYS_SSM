package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.User_Activity;
import org.springframework.stereotype.Repository;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface User_ActivityDao extends BaseMapper<User_Activity> {

   Boolean selectIsInGroupByUserAccount(String account);
}
