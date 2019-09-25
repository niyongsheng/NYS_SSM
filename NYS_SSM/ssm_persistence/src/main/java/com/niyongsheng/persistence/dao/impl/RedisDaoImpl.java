package com.niyongsheng.persistence.dao.impl;

import com.niyongsheng.persistence.dao.RedisDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import redis.clients.jedis.JedisPool;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository("jedisPool")
public class RedisDaoImpl implements RedisDao {

    @Autowired
    private JedisPool jedisPool;

    @Override
    public String get(String key) {
        return jedisPool.getResource().get(key);
    }

    @Override
    public String set(String key, String value) {
        return jedisPool.getResource().set(key,value);
    }

    @Override
    public String hget(String hkey, String key) {
        return jedisPool.getResource().hget(hkey, key);
    }

    @Override
    public long hset(String hkey, String key, String value) {
        return jedisPool.getResource().hset(hkey, key,value);
    }
}
