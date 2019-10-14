package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.redisdao.RedisDao;
import com.niyongsheng.persistence.service.KeyValueRedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service("keyValueRedisService")
public class KeyValueRedisServiceImpl implements KeyValueRedisService {

    @Autowired
    RedisDao redisDao;

    @Override
    public Boolean exists(String key) {
        return redisDao.exists(key);
    }

    @Override
    public Long ttl(String key) {
        return redisDao.ttl(key);
    }

    @Override
    public String get(String key) {
        return redisDao.get(key);
    }

    @Override
    public Long set(String key, String value, long milliseconds) {
        redisDao.set(key, value);
        return redisDao.pexpire(key, milliseconds);
    }
}
