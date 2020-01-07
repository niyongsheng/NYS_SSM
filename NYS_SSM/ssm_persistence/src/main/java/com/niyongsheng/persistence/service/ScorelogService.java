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
    List<Scorelog> selectUserScorelogByFellowshipMultiTable(Integer fellowship, String account);

    Boolean isSignedToday(int type, String account, Integer fellowship);
}
