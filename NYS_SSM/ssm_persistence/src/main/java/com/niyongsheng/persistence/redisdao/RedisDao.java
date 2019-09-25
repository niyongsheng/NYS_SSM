package com.niyongsheng.persistence.redisdao;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */

public interface RedisDao {

    String get(String key);

    String set(String key, String value);

    String hget(String hkey, String key);

    long hset(String hkey, String key, String value);
}
