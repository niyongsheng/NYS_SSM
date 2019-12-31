package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Pray;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Pray_Collection;
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
public interface User_Pray_CollectionDao extends BaseMapper<User_Pray_Collection> {
    /**
     * 查询代祷的收藏用户列表
     * @param prayID 代祷id
     * @return
     */
    List<User> selectCollectionUsersByPrayID(Integer prayID);

    /**
     * 查询用户收藏的代祷列表
     * @param account 用户account
     * @return
     */
    List<Pray> selectPrayersByCollectionAccount(String account);
}
