package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.BibleDao;
import com.niyongsheng.persistence.domain.Bible;
import com.niyongsheng.persistence.service.BibleService;
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
public class BibleServiceImpl extends ServiceImpl<BibleDao, Bible> implements BibleService {

    @Autowired
    private BibleDao bibleDao;

    @Override
    public List<Bible> selectBibleList(String bible) {
        return bibleDao.selectBibleList(bible);
    }
}
