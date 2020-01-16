package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Pray;
import com.niyongsheng.persistence.domain.User_Pray_Collection;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface User_Pray_CollectionService extends IService<User_Pray_Collection> {
    Boolean isCollection(String account, Integer prayID);

    void cancelCollection(String account, Integer prayID);

    List<Pray> slectArticlesByCollectionAccount(String account);
}
