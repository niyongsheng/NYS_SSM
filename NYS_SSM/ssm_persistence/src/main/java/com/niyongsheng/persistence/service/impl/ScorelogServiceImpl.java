package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.ScorelogDao;
import com.niyongsheng.persistence.domain.Scorelog;
import com.niyongsheng.persistence.service.ScorelogService;
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
public class ScorelogServiceImpl extends ServiceImpl<ScorelogDao, Scorelog> implements ScorelogService {

    @Autowired
    private ScorelogDao scorelogDao;

    @Override
    public List<Scorelog> selectUserScorelogByFellowshipMultiTable(Integer fellowship, String account) {
        return scorelogDao.selectUserScorelogByFellowshipMultiTable(fellowship, account);
    }

    @Override
    public Boolean isSignedToday(int type, String account, Integer fellowship) {
        return scorelogDao.isSignedToday(type, account, fellowship);
    }
}
