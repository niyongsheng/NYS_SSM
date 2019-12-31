package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Activity;
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
public interface ActivityDao extends BaseMapper<Activity> {

    List<Activity> selectByFellowshipMultiTable(@Param("fellowship") Integer fellowship, @Param("isInGroupAccount") String isInGroupAccount);
}
