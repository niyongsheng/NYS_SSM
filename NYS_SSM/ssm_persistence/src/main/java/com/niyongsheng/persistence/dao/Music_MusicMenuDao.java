package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.MusicMenu;
import com.niyongsheng.persistence.domain.Music_MusicMenu;
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
public interface Music_MusicMenuDao extends BaseMapper<Music_MusicMenu> {
    /**
     * 根据一个歌单ID,查询这个歌单下的所有歌曲列表
     * @param musicMenuID 歌单id
     * @return
     */
    List<Music> getMusicsByMusicMenuId(@Param("musicMenuID") Integer musicMenuID, @Param("account") String account);

    /**
     * 根据一个歌曲ID，查询这个歌曲所在的歌单列表
     * @param musicID 歌曲id
     * @return
     */
    List<MusicMenu> getMusicMenusByMusicId(Integer musicID);

}
