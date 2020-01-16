package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.User_Pray_CollectionDao;
import com.niyongsheng.persistence.domain.Pray;
import com.niyongsheng.persistence.domain.User_Pray_Collection;
import com.niyongsheng.persistence.service.User_Pray_CollectionService;
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
@Service
public class User_Pray_CollectionServiceImpl extends ServiceImpl<User_Pray_CollectionDao, User_Pray_Collection> implements User_Pray_CollectionService {

    @Autowired
    private User_Pray_CollectionDao user_pray_collectionDao;

    @Override
    public Boolean isCollection(String account, Integer prayID) {
        return user_pray_collectionDao.isCollection(account, prayID);
    }

    @Override
    public void cancelCollection(String account, Integer prayID) {
        user_pray_collectionDao.cancelCollection(account, prayID);
    }

    @Override
    public List<Pray> slectArticlesByCollectionAccount(String account) {
        return user_pray_collectionDao.selectPrayersByCollectionAccount(account);
    }
}
