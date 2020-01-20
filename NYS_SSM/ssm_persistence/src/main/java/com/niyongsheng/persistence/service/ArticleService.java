package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Article;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface ArticleService extends IService<Article> {

    List<Article> selectByFellowshipMultiTable(Integer fellowship, String account);

    List<Article> selectMyArticleList(Integer fellowship, String account);
}
