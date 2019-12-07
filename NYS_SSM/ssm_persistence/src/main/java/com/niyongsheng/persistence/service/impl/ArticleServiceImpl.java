package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.dao.ArticleDao;
import com.niyongsheng.persistence.dao.BaseDao;
import com.niyongsheng.persistence.domain.Article;
import com.niyongsheng.persistence.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service("articleService")
public class ArticleServiceImpl  extends BaseServiceImpl<Article> implements ArticleService {

    @Autowired
    ArticleDao articleDao;

    @Override
    protected BaseDao getDao() {
        return articleDao;
    }
}
