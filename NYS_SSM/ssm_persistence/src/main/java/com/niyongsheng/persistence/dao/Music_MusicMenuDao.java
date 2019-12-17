package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.Music_MusicMenu;
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
public interface Music_MusicMenuDao extends BaseMapper<Music_MusicMenu> {

    List<Music> getMusicsByMusicMenuId(Integer id);

    List<Music_MusicMenu> getMusicMenusByMusicId(Integer id);

}
