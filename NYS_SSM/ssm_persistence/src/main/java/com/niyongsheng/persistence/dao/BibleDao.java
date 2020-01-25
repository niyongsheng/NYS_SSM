package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Bible;
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
public interface BibleDao extends BaseMapper<Bible> {
    /**
     * 模糊检索经文
     * @param bible
     * @return
     */
    List<Bible> selectBibleList(String bible);
}
