package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Article;
import org.apache.ibatis.annotations.Param;
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
public interface ArticleDao extends BaseMapper<Article> {

    List<Article> selectByFellowshipMultiTable(@Param("fellowship") Integer fellowship, @Param("isCollectionAccount") String isCollectionAccount);

    List<Article> selectMyArticleList(@Param("fellowship") Integer fellowship, @Param("account") String account);
}
