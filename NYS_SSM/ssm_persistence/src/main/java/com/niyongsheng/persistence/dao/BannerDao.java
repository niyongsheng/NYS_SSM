package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Banner;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface BannerDao extends BaseMapper<Banner> {
    /* 多表联查所有 */
    List<Banner> selectAllMultiTable();
}
