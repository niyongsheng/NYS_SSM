package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.MusicMenu;
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
public interface MusicMenuDao extends BaseMapper<MusicMenu> {

    List<MusicMenu> selectAllByFellowship(Integer fellowship);

    MusicMenu selectMusicListById(Integer id);
}
