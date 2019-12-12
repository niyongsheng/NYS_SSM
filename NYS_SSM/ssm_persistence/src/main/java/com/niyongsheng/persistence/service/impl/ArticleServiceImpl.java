package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.ArticleDao;
import com.niyongsheng.persistence.domain.Article;
import com.niyongsheng.persistence.service.ArticleService;
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
@Service("articleService")
public class ArticleServiceImpl extends ServiceImpl<ArticleDao, Article> implements ArticleService {

    @Autowired
    ArticleDao articleDao;

    @Override
    public List<Article> selectByFellowshipMultiTable(Integer fellowship) {
        return articleDao.selectByFellowshipMultiTable(fellowship);
    }
}
