package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Music_Collection;
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
public interface User_Music_CollectionDao extends BaseMapper<User_Music_Collection> {
    /**
     * 查询音乐的收藏用户列表
     * @param musicID 音乐id
     * @return
     */
    List<User> selectCollectionUsersByMusicID(Integer musicID);

    /**
     * 查询用户收藏的音乐列表
     * @param account 用户account
     * @return
     */
    List<Music> selectArticlesByCollectionAccount(String account);
}
