package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.common.utils.JacksonUtils;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.redisdao.RedisDao;
import com.niyongsheng.persistence.service.UserRedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service("userRedisService")
public class UserRedisServiceImpl implements UserRedisService {

    private static final String USER = "user_";

    @Autowired
    RedisDao redisDao;

    @Override
    public User getUserById(String id) {
        String userJson = redisDao.get(USER + id);
        User user = new User();
        if (!StringUtils.isEmpty(userJson)) {
            user = JacksonUtils.jsonToPojo(userJson, User.class);
        }
        return user;
    }

    @Override
    public void insertUser(User user) {
        String key = USER + user.getId();

        redisDao.set(key, JacksonUtils.objectToJson(user));
    }

    @Override
    public void insertUser(User user, long milliseconds) {
        String key = USER + user.getId();
        Boolean exists = redisDao.exists(key);
        if (exists) {
            redisDao.pexpire(key, milliseconds);
        } else {
            redisDao.set(key, JacksonUtils.objectToJson(user));
            redisDao.pexpire(key, milliseconds);
        }
    }

    @Override
    public Long del(User user) {
        String key = USER + user.getId();
        return redisDao.del(key);
    }
}
