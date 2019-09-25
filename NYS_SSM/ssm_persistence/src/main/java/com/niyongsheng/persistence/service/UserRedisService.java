package com.niyongsheng.persistence.service;

import com.niyongsheng.persistence.domain.User;

/**
 * @author niyongsheng.com
 * @version $
 * @des redis操作User
 * @updateAuthor $
 * @updateDes
 */
public interface UserRedisService {

    /**
     * 通过id查询用户
     * @param id
     * @return
     */
    public User getUserById(String id);

    /**
     * 添加用户
     * @param user
     */
    public void insertUser(User user);
}
