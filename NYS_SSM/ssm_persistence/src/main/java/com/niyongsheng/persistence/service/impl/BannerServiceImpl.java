package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.BannerDao;
import com.niyongsheng.persistence.domain.Banner;
import com.niyongsheng.persistence.service.BannerService;
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
@Service("bannerService")
public class BannerServiceImpl extends ServiceImpl<BannerDao, Banner> implements BannerService {

    @Autowired
    private BannerDao bannerDao;

    @Override
    public List<Banner> selectAllMultiTable() {
        return bannerDao.selectAllMultiTable();
    }

    @Override
    public List<Banner> selectByFellowshipMultiTable(Integer fellowship) {
        return bannerDao.selectByFellowshipMultiTable(fellowship);
    }
}
