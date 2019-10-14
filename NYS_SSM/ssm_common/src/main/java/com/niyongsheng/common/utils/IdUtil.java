package com.niyongsheng.common.utils;

import org.apache.commons.codec.digest.DigestUtils;

import java.util.UUID;

/**
 * @author niyongsheng.com
 * @version $
 * @des 用于生产各种各样的ID
 * @updateAuthor $
 * @updateDes
 */
public class IdUtil {

    private static String middle = "";

    static {
        middle = MathUtils.makeUpNewData(Math.abs(NetworkUtils.getHostIP().hashCode()) + "", 4) +    //4位IP地址hash
                MathUtils.makeUpNewData(NetworkUtils.getPid(), 4);                                    //4位PID进程hash
    }

    /**
     * 以毫微秒做基础计数, 返回唯一有序增长ID
     * <pre>System.nanoTime()</pre>
     * <pre>
     * 	线程数量: 	100
     * 	执行次数: 	1000
     * 	平均耗时: 	222 ms
     * 	数组长度: 	100000
     * 	Map Size: 	100000
     * </pre>
     *
     * @return ID长度32位
     */
    public static String getIncreaseIdByNanoTime() {
        return System.nanoTime() +                                                        //时间戳-14位
                middle +                                                                    //标志-8位
                MathUtils.makeUpNewData(Thread.currentThread().hashCode() + "", 3) +        //3位线程标志
                MathUtils.randomDigitNumber(7);                                            //随机7位数
    }

    /**
     * 以毫秒做基础计数, 返回唯一有序增长ID, 有几率出现线程并发
     * <pre>System.currentTimeMillis()</pre>
     * <pre>
     * 	线程数量: 	100
     * 	执行次数: 	1000
     * 	平均耗时: 	206 ms
     * 	数组长度: 	100000
     * 	Map Size: 	99992
     * </pre>
     *
     * @return ID长度32位
     */
    public static String getIncreaseIdByCurrentTimeMillis() {
        return System.currentTimeMillis() +                                                //时间戳-14位
                middle +                                                                    //标志-8位
                MathUtils.makeUpNewData(Thread.currentThread().hashCode() + "", 3) +        //3位线程标志
                MathUtils.randomDigitNumber(8);                                            //随机8位数
    }

    /**
     * 基于UUID+MD5产生唯一无序ID
     * <pre>
     * 	线程数量: 	100
     * 	执行次数: 	1000
     * 	平均耗时:		591 ms
     * 	数组长度: 	100000
     * 	Map Size: 	100000
     * </pre>
     *
     * @return ID长度32位
     */
    public static String getRandomIdByUUID() {
        return DigestUtils.md5Hex(UUID.randomUUID().toString());
    }

    /**
     * 以毫微秒做基础计数, 返回唯一有序增长ID
     * @return ID长度20位
     */
//        public static String getRandomIdByDateTime(){
//            return TimeUtils.getTime(TimeType.yyyyMMddHHmmssSSS)+MathUtils.randomDigitNumber(3);
//        }
}
