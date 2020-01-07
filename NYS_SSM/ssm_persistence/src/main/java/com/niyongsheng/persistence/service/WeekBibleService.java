package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.WeekBible;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface WeekBibleService extends IService<WeekBible> {
    List<WeekBible> selectByFellowshipMultiTable(Integer fellowship, String account);

    WeekBible selectWeekBibleByWeekOfYearAndFellowship(int weekOfYear, Integer fellowship);
}
