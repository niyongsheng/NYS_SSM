package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.RecommendDao;
import com.niyongsheng.persistence.domain.Recommend;
import com.niyongsheng.persistence.service.RecommendService;
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
public class RecommendServiceImpl extends ServiceImpl<RecommendDao, Recommend> implements RecommendService {

    @Autowired
    private RecommendDao recommendDao;

    @Override
    public List<Recommend> selectRecommendByFellowshipMultiTable(Integer fellowship, String account) {
        return recommendDao.selectRecommendByFellowshipMultiTable(fellowship, account);
    }
}
