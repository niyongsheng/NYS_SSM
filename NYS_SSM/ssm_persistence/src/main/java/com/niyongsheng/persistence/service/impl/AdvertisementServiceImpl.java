package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.AdvertisementDao;
import com.niyongsheng.persistence.domain.Advertisement;
import com.niyongsheng.persistence.service.AdvertisementService;
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
public class AdvertisementServiceImpl extends ServiceImpl<AdvertisementDao, Advertisement> implements AdvertisementService {

    @Autowired
    private AdvertisementDao advertisementDao;

    @Override
    public List<Advertisement> selectAdvertisementList(Integer fellowship, Integer type) {
        return advertisementDao.selectAdvertisementList(fellowship, type);
    }
}
