package com.niyongsheng.manager.lpr;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class CrcUtil {

    private static final char[] HEX_CHAR = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

    /**
     * 将一个有符号的byte转换成一个int数据对象
     *
     * @param byteNum 有符号的字节对象
     * @return int数据类型
     */
    public static int oneByte2Int(byte byteNum) {
        // 针对正数的int
        return byteNum > 0 ? byteNum : 256 + byteNum;
    }

    /**
     * 将字节数组转换成short数据，高位在前，低位在后
     *
     * @param bytes 字节数组
     * @param index 起始位置
     * @return short值
     */
    public static short getShort(byte[] bytes, int index) {
        return (short) ((0xff00 & (bytes[index] << 8)) | (0x00ff & bytes[index + 1]));
    }

    /**
     * 将字节数组转换成十六进制的字符串形式
     *
     * @param bytes 原始的字节数组
     * @return 字符串信息
     */
    public static String bytes2HexString(byte[] bytes) {
        char[] buf = new char[bytes.length * 2];
        int index = 0;
        for (byte b : bytes) { // 利用位运算进行转换，可以看作方法一的变种
            buf[index++] = HEX_CHAR[b >>> 4 & 0xf];
            buf[index++] = HEX_CHAR[b & 0xf];
        }

        return new String(buf);
    }

    /*
     * 16进制字符串转byte数组
     */
    public static byte[] hex2Bytes(String str) {
        if (str == null || str.trim().equals("")) {
            return new byte[0];
        }

        byte[] bytes = new byte[str.length() / 2];
        for (int i = 0; i < str.length() / 2; i++) {
            String subStr = str.substring(i * 2, i * 2 + 2);
            bytes[i] = (byte) Integer.parseInt(subStr, 16);
        }

        return bytes;
    }

    /*
     * CRC16校验码
     */
    public static String getCRC16(byte[] bytes) {
        int CRC = 0x0000ffff;
        int POLYNOMIAL = 0x0000a001;

        int i, j;
        for (i = 0; i < bytes.length; i++) {
            CRC ^= ((int) bytes[i] & 0x000000ff);
            for (j = 0; j < 8; j++) {
                if ((CRC & 0x00000001) != 0) {
                    CRC >>= 1;
                    CRC ^= POLYNOMIAL;
                } else {
                    CRC >>= 1;
                }
            }
        }
        // 高低位互换
        CRC = ((CRC & 0x0000FF00) >> 8) | ((CRC & 0x000000FF) << 8);
        return Integer.toHexString(CRC);
    }
}
