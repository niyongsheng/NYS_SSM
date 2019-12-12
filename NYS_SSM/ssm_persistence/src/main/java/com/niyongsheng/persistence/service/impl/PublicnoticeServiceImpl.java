package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.PublicnoticeDao;
import com.niyongsheng.persistence.domain.Banner;
import com.niyongsheng.persistence.domain.Publicnotice;
import com.niyongsheng.persistence.service.PublicnoticeService;
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
@Service("publicnoticeService")
public class PublicnoticeServiceImpl extends ServiceImpl<PublicnoticeDao, Publicnotice> implements PublicnoticeService {

    @Autowired
    private PublicnoticeDao publicnoticeDao;

    @Override
    public List<Publicnotice> selectByFellowshipMultiTable(Integer fellowship) {
        return publicnoticeDao.selectByFellowshipMultiTable(fellowship);
    }
}
