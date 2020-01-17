package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.Music_MusicMenuDao;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.Music_MusicMenu;
import com.niyongsheng.persistence.service.Music_MusicMenuService;
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
@Service("music_MusicMenuServiceImpl")
public class Music_MusicMenuServiceImpl extends ServiceImpl<Music_MusicMenuDao, Music_MusicMenu> implements Music_MusicMenuService {

    @Autowired
    private Music_MusicMenuDao music_musicMenuDao;

    @Override
    public List<Music> getMusicsByMusicMenuId(Integer id, String isCollectionAccount) {
        return music_musicMenuDao.getMusicsByMusicMenuId(id, isCollectionAccount);
    }
}
