package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.MusicDao;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.service.MusicService;
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
@Service
public class MusicServiceImpl extends ServiceImpl<MusicDao, Music> implements MusicService {

    @Autowired
    private MusicDao musicDao;

    @Override
    public List<Music> selectByFellowshipMultiTable(Integer fellowship, String account) {
        return musicDao.selectByFellowshipMultiTable(fellowship, account);
    }

    @Override
    public List<Music> selectMyMusicList(Integer fellowship, String account) {
        return musicDao.selectMyMusicList(fellowship, account);
    }
}
