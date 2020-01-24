package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.ScorelogDao;
import com.niyongsheng.persistence.domain.Scorelog;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.ScorelogService;
import com.niyongsheng.persistence.service.UserService;
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

    @Autowired
    private UserService userService;

    @Override
    public List<Scorelog> selectUserScorelogByFellowshipMultiTable(Integer fellowship, String account) {
        return scorelogDao.selectUserScorelogByFellowshipMultiTable(fellowship, account);
    }

    @Override
    public Boolean isSignedToday(int type, String account, Integer fellowship) {
        return scorelogDao.isSignedToday(type, account, fellowship);
    }

    @Override
    public void sign(Scorelog scorelog) {
        scorelogDao.insert(scorelog);
        Double sumScore = scorelogDao.selectTotalScore(scorelog.getAccount(), scorelog.getFellowship());
        User updateUser = new User();
        // 用户积分等级
        if (sumScore >= 0 && sumScore < 100) {
            updateUser.setGrade(0);
        } else if (sumScore >= 100 && sumScore < 200) {
            updateUser.setGrade(1);
        } else if (sumScore >= 200 && sumScore < 300) {
            updateUser.setGrade(3);
        } else if (sumScore >= 300 && sumScore < 400) {
            updateUser.setGrade(3);
        } else if (sumScore >= 400 && sumScore < 500) {
            updateUser.setGrade(4);
        } else if (sumScore >= 500 && sumScore < 600) {
            updateUser.setGrade(5);
        } else if (sumScore >= 600 && sumScore < 700) {
            updateUser.setGrade(6);
        } else {
            updateUser.setGrade(7);
        }
        updateUser.setAccount(scorelog.getAccount());
        updateUser.setScore(sumScore);
        userService.updateUser(updateUser);
    }
}
