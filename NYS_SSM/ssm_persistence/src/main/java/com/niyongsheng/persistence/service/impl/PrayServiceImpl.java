package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.PrayDao;
import com.niyongsheng.persistence.domain.Pray;
import com.niyongsheng.persistence.service.PrayService;
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
@Service("prayService")
public class PrayServiceImpl extends ServiceImpl<PrayDao, Pray> implements PrayService {

    @Autowired
    private PrayDao prayDao;

    @Override
    public List<Pray> selectAllMultiTable() {
        return prayDao.selectAllMultiTable();
    }

    @Override
    public List<Pray> selectAllByFellowshipMultiTable(Integer fellowship, String account) {
        return prayDao.selectAllByFellowshipMultiTable(fellowship, account);
    }

    @Override
    public List<Pray> selectMyPrayList(Integer fellowship, String account) {
        return prayDao.selectMyPrayList(fellowship, account);
    }
}
