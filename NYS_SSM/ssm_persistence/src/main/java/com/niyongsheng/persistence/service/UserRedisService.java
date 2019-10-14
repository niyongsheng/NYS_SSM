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
    User getUserById(String id);

    /**
     * 缓存用户
     * @param user
     */
    void insertUser(User user);

    /**
     * 缓存用户，并设置过期时间（毫秒）
     * 如果key存在，直接设置过期时间
     * 如果key不存在，先缓存再设置过期时间
     * @param user
     * @param milliseconds
     */
    void insertUser(User user, long milliseconds);

    /**
     * 删除一个Key,如果删除的key不存在，则直接忽略。
     *
     * @param user
     * @return 被删除的keys的数量
     */
    Long del(User user);
}
