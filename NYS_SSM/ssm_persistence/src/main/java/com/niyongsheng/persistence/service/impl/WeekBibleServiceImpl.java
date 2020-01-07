package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.WeekBibleDao;
import com.niyongsheng.persistence.domain.WeekBible;
import com.niyongsheng.persistence.service.WeekBibleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service
public class WeekBibleServiceImpl extends ServiceImpl<WeekBibleDao, WeekBible> implements WeekBibleService {

    @Autowired
    private WeekBibleDao weekBibleDao;

    @Override
    public List<WeekBible> selectByFellowshipMultiTable(Integer fellowship, String account) {
        return weekBibleDao.selectByFellowshipMultiTable(fellowship, account);
    }

    @Override
    public WeekBible selectWeekBibleByWeekOfYearAndFellowship(int weekOfYear, Integer fellowship) {
        return weekBibleDao.selectWeekBibleByWeekOfYearAndFellowship(weekOfYear, fellowship);
    }
}
