package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Music;
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
public interface MusicDao extends BaseMapper<Music> {

    List<Music> selectByFellowshipMultiTable(@Param("fellowship") Integer fellowship, @Param("isCollectionAccount") String isCollectionAccount);
}
