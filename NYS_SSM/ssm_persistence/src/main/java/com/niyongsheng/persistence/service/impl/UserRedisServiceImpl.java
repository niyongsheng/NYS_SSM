package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.common.utils.JacksonUtils;
import com.niyongsheng.persistence.dao.RedisDao;
import com.niyongsheng.persistence.dao.UserDao;
import com.niyongsheng.persistence.domain.User;
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

    @Autowired
    UserDao userDao;

    @Autowired
    RedisDao redisDao;


    @Override
    public void insertUser(User user) {
        String userJson = redisDao.get("user_" + user.getId());
        if(StringUtils.isEmpty(userJson)){
            redisDao.set("user_" + user.getId(), JacksonUtils.objectToJson(user));
        }
    }

    @Override
    public User getUserById(String id) {
        String userJson = redisDao.get("user_" + id);
        User user = null;
        if(StringUtils.isEmpty(userJson)){
            user = userDao.find(Integer.valueOf(id));
            // 不存在,设置
            if(user != null)
                redisDao.set("user_" + id, JacksonUtils.objectToJson(user));
        }else{
            user = JacksonUtils.jsonToPojo(userJson, User.class);
        }
        return user;
    }
}
