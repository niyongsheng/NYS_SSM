package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.PlateDao;
import com.niyongsheng.persistence.domain.Plate;
import com.niyongsheng.persistence.service.PlateService;
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
public class PlateServiceImpl extends ServiceImpl<PlateDao, Plate> implements PlateService {

    @Autowired
    private PlateDao plateDao;

    @Override
    public Plate selectOneByPlate(String plate) {
        return plateDao.selectOneByPlate(plate);
    }

    @Override
    public List<Plate> selectAllByFellowship(Integer fellowship) {
        return plateDao.selectAllByFellowship(fellowship);
    }
}
