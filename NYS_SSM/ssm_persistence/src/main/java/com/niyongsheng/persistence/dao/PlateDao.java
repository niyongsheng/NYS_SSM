package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Plate;
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
public interface PlateDao extends BaseMapper<Plate> {
    Plate selectOneByPlate(String plate);

    List<Plate> selectAllByFellowship(Integer fellowship);
}
