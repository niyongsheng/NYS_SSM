package com.niyongsheng.persistence.service;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface KeyValueRedisService {

    /**
     * 检查某个key是否在缓存中存在，如果存在返回true，否则返回false；需要注意的是，即使该key所对应的value是一个空字符串，
     * 也依然会返回true。
     *
     * @param key
     * @return
     */
    Boolean exists(String key);

    /**
     * 返回一个key还能活多久，单位为秒
     *
     * @param key
     * @return 如果该key本来并没有设置过期时间，则返回-1，如果该key不存在，则返回-2
     */
    Long ttl(String key);

    /**
     * 从缓存中根据key取得其String类型的值，如果key不存在则返回null，如果key存在但value不是string类型的，
     * 则返回一个error。这个方法只能从缓存中取得value为string类型的值。
     *
     * @param key
     * @return
     */
    String get(String key);

    /**
     * 据到缓存中，并设置过期时间（毫秒），若key已存在则覆盖 value的长度不能超过1073741824 bytes (1 GB)
     * @param key
     * @param value
     * @param milliseconds
     * @return
     */
    Long set(String key, String value, long milliseconds);

}
