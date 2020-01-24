package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Scorelog;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface ScorelogService extends IService<Scorelog> {
    /**
     * 获取签到列表
     * @param fellowship
     * @param account
     * @return
     */
    List<Scorelog> selectUserScorelogByFellowshipMultiTable(Integer fellowship, String account);

    /**
     * 今天是否已签到查询
     * @param type
     * @param account
     * @param fellowship
     * @return
     */
    Boolean isSignedToday(int type, String account, Integer fellowship);

    /**
     * 签到（TR）
     * @param scorelog
     */
    void sign(Scorelog scorelog);
}
