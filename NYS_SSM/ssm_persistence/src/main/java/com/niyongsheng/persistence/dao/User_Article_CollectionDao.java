package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Article;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Article_Collection;
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
public interface User_Article_CollectionDao extends BaseMapper<User_Article_Collection> {
    /**
     * 查询文章的收藏用户列表
     * @param articleID 文章id
     * @return
     */
    List<User> selectCollectionUsersByArticleID(Integer articleID);

    /**
     * 查询用户收藏的文章列表
     * @param account 用户account
     * @return
     */
    List<Article> selectArticlesByCollectionAccount(String account);
}
