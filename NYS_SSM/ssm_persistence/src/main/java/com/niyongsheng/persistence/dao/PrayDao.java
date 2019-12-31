package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Pray;
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
public interface PrayDao extends BaseMapper<Pray> {
    /**
     * 不区分团契
     * @return
     */
    List<Pray> selectAllMultiTable();

    List<Pray> selectAllByFellowshipMultiTable(Integer fellowship);
}
