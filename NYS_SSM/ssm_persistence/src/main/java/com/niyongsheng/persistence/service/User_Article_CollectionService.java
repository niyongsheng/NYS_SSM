package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Article;
import com.niyongsheng.persistence.domain.User_Article_Collection;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface User_Article_CollectionService extends IService<User_Article_Collection> {
    Boolean isCollection(String account, Integer articleID);

    void cancelCollection(String account, Integer articleID);

    List<Article> selectArticlesByCollectionAccount(String account);
}
