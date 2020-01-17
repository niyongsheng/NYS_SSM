package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.MusicMenuDao;
import com.niyongsheng.persistence.domain.MusicMenu;
import com.niyongsheng.persistence.service.MusicMenuService;
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
@Service("musicSongMenuService")
public class MusicMenuServiceImpl extends ServiceImpl<MusicMenuDao, MusicMenu> implements MusicMenuService {

    @Autowired
    private MusicMenuDao musicMenuDao;

    @Override
    public List<MusicMenu> selectAllByFellowship(Integer fellowship) {
        return musicMenuDao.selectAllByFellowship(fellowship);
    }

    @Override
    public MusicMenu selectMusicListById(Integer id, String account) {
        return musicMenuDao.selectMusicListById(id, account);
    }
}
