package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.PlatelogDao;
import com.niyongsheng.persistence.domain.Platelog;
import com.niyongsheng.persistence.service.PlatelogService;
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
public class PlatelogServiceImpl extends ServiceImpl<PlatelogDao, Platelog> implements PlatelogService {

    @Autowired
    private PlatelogDao platelogDao;

    @Override
    public List<Platelog> selectAllByFellowship(Integer fellowship) {
        return platelogDao.selectAllByFellowship(fellowship);
    }
}
