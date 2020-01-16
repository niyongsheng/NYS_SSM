package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.User_Music_CollectionDao;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.User_Music_Collection;
import com.niyongsheng.persistence.service.User_Music_CollectionService;
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
public class User_Music_CollectionServiceImpl extends ServiceImpl<User_Music_CollectionDao, User_Music_Collection> implements User_Music_CollectionService {

    @Autowired
    private User_Music_CollectionDao user_music_collectionDao;

    @Override
    public Boolean isCollection(String account, Integer musicID) {
        return user_music_collectionDao.isCollection(account, musicID);
    }

    @Override
    public void cancelCollection(String account, Integer musicID) {
        user_music_collectionDao.cancelCollection(account, musicID);
    }

    @Override
    public List<Music> slectArticlesByCollectionAccount(String account) {
        return user_music_collectionDao.selectArticlesByCollectionAccount(account);
    }
}
