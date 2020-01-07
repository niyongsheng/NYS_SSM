package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.WeekBible;
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
public interface WeekBibleDao extends BaseMapper<WeekBible> {
    List<WeekBible> selectByFellowshipMultiTable(@Param("fellowship") Integer fellowship, @Param("account") String account);

    WeekBible selectWeekBibleByWeekOfYearAndFellowship(@Param("weekOfYear") int weekOfYear, @Param("fellowship") Integer fellowship);
}
