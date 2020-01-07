package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Scorelog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface ScorelogDao extends BaseMapper<Scorelog> {
    /**
     * 查询用户的交易记录
     * @param fellowship 团契编号
     * @param account 账号
     * @return
     */
    List<Scorelog> selectUserScorelogByFellowshipMultiTable(@Param("fellowship") Integer fellowship, @Param("account") String account);

    /**
     * 查询该交易类型今天是否已存在
     * @param type
     * @param account
     * @param fellowship
     * @return
     */
    Boolean isSignedToday(@Param("type") int type, @Param("account") String account, @Param("fellowship") Integer fellowship);
}
