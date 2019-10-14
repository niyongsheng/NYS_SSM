package com.niyongsheng.persistence.redisdao;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */

public interface RedisDao {

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
     * 为key设置一个特定的过期时间，单位为毫秒。过期时间一到，redis将会从缓存中删除掉该key。
     * 即使是有过期时间的key，redis也会在持久化时将其写到硬盘中，并把相对过期时间改为绝对的Unix过期时间。
     * 在一个有设置过期时间的key上重复设置过期时间将会覆盖原先设置的过期时间。
     *
     * @param key
     * @param milliseconds
     * @return 返回1表示成功设置过期时间，返回0表示key不存在。
     */
    Long pexpire(String key, long milliseconds);

    /**
     * expireAt设置的时间不是能存活多久，而是固定的UNIX时间（从1970年开始算起），单位为毫秒。
     *
     * @param key
     * @param millisecondsTimestamp
     * @return
     */
    Long pexpireAt(String key, long millisecondsTimestamp);

    /**
     * 从缓存中根据key取得其String类型的值，如果key不存在则返回null，如果key存在但value不是string类型的，
     * 则返回一个error。这个方法只能从缓存中取得value为string类型的值。
     *
     * @param key
     * @return
     */
    String get(String key);

    /**
     * 存储数据到缓存中，若key已存在则覆盖 value的长度不能超过1073741824 bytes (1 GB)
     *
     * @param key
     * @param value
     * @return
     */
    String set(String key, String value);

    /**
     * 如果该key对应的值是一个Hash表，则返回对应字段的值。 如果不存在该字段，或者key不存在，则返回一个"nil"值。
     *
     * @param key
     * @param field
     * @return
     */
    String hget(String key, String field);

    /**
     * 设置hash表里field字段的值为value。如果key不存在，则创建一个新的hash表
     *
     * @param key
     * @param field
     * @param value
     * @return 如果该字段已经存在，那么将会更新该字段的值，返回0.如果字段不存在，则新创建一个并且返回1.
     */
    long hset(String key, String field, String value);

    /**
     * 删除一个Key,如果删除的key不存在，则直接忽略。
     *
     * @param key
     * @return 被删除的keys的数量
     */
    Long del(String key);
}
