package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Bible;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface BibleService extends IService<Bible> {
    /**
     * 模糊检索金文
     * @param bible
     * @return
     */
    List<Bible> selectBibleList(String bible);
}
