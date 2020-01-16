package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.User_Article_CollectionDao;
import com.niyongsheng.persistence.domain.Article;
import com.niyongsheng.persistence.domain.User_Article_Collection;
import com.niyongsheng.persistence.service.User_Article_CollectionService;
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
public class User_Article_CollectionServiceImpl extends ServiceImpl<User_Article_CollectionDao, User_Article_Collection> implements User_Article_CollectionService {

    @Autowired
    private User_Article_CollectionDao user_article_collectionDao;

    @Override
    public Boolean isCollection(String account, Integer articleID) {
        return user_article_collectionDao.isCollection(account, articleID);
    }

    @Override
    public void cancelCollection(String account, Integer articleID) {
        user_article_collectionDao.cancelCollection(account, articleID);
    }

    @Override
    public List<Article> selectArticlesByCollectionAccount(String account) {
        return user_article_collectionDao.selectArticlesByCollectionAccount(account);
    }
}
