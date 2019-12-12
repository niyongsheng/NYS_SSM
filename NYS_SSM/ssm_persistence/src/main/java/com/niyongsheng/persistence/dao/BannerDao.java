package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Banner;
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
public interface BannerDao extends BaseMapper<Banner> {
    /* 多表联查所有 */
    List<Banner> selectAllMultiTable();

    List<Banner> selectByFellowshipMultiTable(Integer fellowship);
}
