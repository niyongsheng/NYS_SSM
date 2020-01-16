package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.User_Music_Collection;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface User_Music_CollectionService extends IService<User_Music_Collection> {
    Boolean isCollection(String account, Integer musicID);

    void cancelCollection(String account, Integer musicID);

    List<Music> slectArticlesByCollectionAccount(String account);
}
