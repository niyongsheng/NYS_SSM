package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.Music_MusicMenu;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface Music_MusicMenuService extends IService<Music_MusicMenu> {
    List<Music> getMusicsByMusicMenuId(Integer id, String isCollectionAccount);
}
