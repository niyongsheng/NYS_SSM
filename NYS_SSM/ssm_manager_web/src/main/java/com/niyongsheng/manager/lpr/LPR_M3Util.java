package com.niyongsheng.manager.lpr;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.niyongsheng.common.utils.HexUtil;
import org.apache.commons.codec.binary.Base64;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.ByteBuffer;
import java.util.Hashtable;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des OLM-M3 车牌识别语音屏显模块工具类
 * @updateAuthor $
 * @updateDes
 */
public class LPR_M3Util {

    /**
     * 控制设备开闸
     * 不播放语音
     */
    public static void open(HttpServletResponse response) throws IOException {
        // 回复命令，控制设备开闸
        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        out.println("{\"Response_AlarmInfoPlate\":{\"info\":\"ok\",\"content\":\"...\",\"is_pay\":\"true\"}}");
        out.flush();
        out.close();
    }

    /**
     * 生成单色位图二维码
     * @param QRMsg
     * @param size
     * @return
     * @throws Exception
     */
    public static byte[] createQRBitmap(String QRMsg, int size) throws Exception {
        Hashtable<EncodeHintType, Object> hints = new Hashtable<EncodeHintType, Object>();
        // 设置二维码排错率，可选L(7%)、M(15%)、Q(25%)、H(30%)，排错率越高可存储的信息越少，但对二维码清晰度的要求越小
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
        // LEVEL3(29X29)
        hints.put(EncodeHintType.QR_VERSION, 3);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 1);
        BitMatrix bitMatrix = new MultiFormatWriter().encode(QRMsg, BarcodeFormat.QR_CODE, size, size, hints);
        int width = bitMatrix.getWidth();
        int height = bitMatrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
            }
        }

        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        ImageIO.write(image, "bmp", outStream);
        return outStream.toByteArray();
    }

    /**
     * 二维码+文字信息+语音
     * @param duration
     * @param QRMsg
     * @param TextInfo
     * @param isPlay
     * @return
     */
    public static String getQRCodePay485Data(int duration, String QRMsg, String TextInfo, boolean isPlay) {
        byte[] bq = null;
        try {
            bq = createQRBitmap(QRMsg, 29);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String sq = HexUtil.BinaryToHexString(bq);

        byte[] bt = null;
        boolean isText = TextInfo.length() > 0;
        if (isText) {
            try {
                bt = TextInfo.getBytes("GB2312");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        String st = HexUtil.BinaryToHexString(bt);

        ByteBuffer buf1 = ByteBuffer.allocate(1024);
        // 包头标记
        buf1.put((byte) 0x00); // 显示屏地址
        buf1.put((byte) 200); // 固定参数
        buf1.put((byte) 0xFF); // 包序列
        buf1.put((byte) 0xFF); // 包序列
        // 二维码支付 指令
        buf1.put((byte) 0xE5);
        // 数据长度
        int len = bq.length + bt.length + 7;
        buf1.put((byte) (len & 0xff));
        buf1.put((byte) ((len >> 8) & 0xff));
        // SF: 显示标志，1 为显示，0 为不显示
        buf1.put((byte) 1);
        // EM: 进入模式，保留赋值为 0(无操作)
        buf1.put((byte) 0);
        // ETM:退出模式，保留赋值为 0(无操作)
        buf1.put((byte) 0);
        // ST:界面的显示时间，单位为秒，0 为一直显示
        buf1.put((byte) duration);
        // NI:下一个界面的索引号，目前保留取值为 0
        buf1.put((byte) 0);
        // FLAGS:标志域，最高位为 1 时，表示携带文本信息，否则可以不携带文本信息;最低位 为 1 时表示同时播报语音
        // 常用的组合是,0X80 不播报语音，0X81 显示及播报语音。
        buf1.put((byte) (0X80 | (isPlay ? 1 : 0)));
        // TL:文本信息长度
        if (isText) {
            buf1.put((byte) bt.length);
        } else {
            buf1.put((byte) 0);
        }
        // TEXT:文本信息字符数组
        buf1.put(bt);
        // MSG:二维码图片字符数组
        buf1.put(bq);

        buf1.flip();
        int length1 = buf1.remaining();
        byte[] tempData = new byte[length1];
        System.arraycopy(buf1.array(), 0, tempData, 0, length1);
        String s = HexUtil.BinaryToHexString(tempData);
        // CRC16校验
        String crc16 = CrcUtil.getCRC16(tempData);
        // 追加插入校验位
        ByteBuffer buf2 = ByteBuffer.allocate(1024);
        byte[] bytes = HexUtil.hexStringToByteArray(crc16);
        String ss = HexUtil.BinaryToHexString(bytes);
        buf2.put(tempData);
        buf2.put(bytes);

        buf2.flip();
        int length2 = buf2.remaining();
        byte[] data = new byte[length2];
        System.arraycopy(buf2.array(), 0, data, 0, length2);
        String sss = HexUtil.BinaryToHexString(data);

        // 包装json数据
        String jsonData = new String(Base64.encodeBase64(data));
        JsonObject json = (JsonObject) new JsonParser().parse("{}");
        json.addProperty("serialChannel", 0);
        json.addProperty("data", jsonData);
        json.addProperty("dataLen", jsonData.length());

        return json.toString();
    }

    /**
     * 显示二维码支付模板
     * WARNING:二维码在此设备无法显示完整，请使用绘图模式29*29
     * @param duration
     * @param times
     * @param money
     * @param qrCode
     * @param voice
     * @param isPlay
     * @return
     */
    public static String getPay485Data(int duration, Integer times, float money, String qrCode, String voice, boolean isPlay) {
        byte[] bq = null;
        byte[] bv = null;
        try {
            bq = qrCode.getBytes("GB2312");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        boolean isVoice = voice.length() > 0;
        if (isVoice) {
            try {
                bv = voice.getBytes("GB2312");
            } catch (UnsupportedEncodingException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        ByteBuffer buf1 = ByteBuffer.allocate(1024);
        // 包头标记
        buf1.put((byte) 0x00); // 显示屏地址
        buf1.put((byte) 0x64); // 固定参数
        buf1.put((byte) 0xFF); // 包序列
        buf1.put((byte) 0xFF); // 包序列
        // 扫码支付 指令
        buf1.put((byte) 0xE1);
        // 数据长度
        buf1.put((byte) ((bq.length + bv.length + 34) & 0xff));
        // SF: 显示标志，1 为显示，0 为不显示
        buf1.put((byte) 1);
        // EM: 进入模式，保留赋值为 0(无操作)
        buf1.put((byte) 0);
        // ETM:退出模式，保留赋值为 0(无操作)
        buf1.put((byte) 0);
        // ST:界面的显示时间，单位为秒，0 为一直显示
        buf1.put((byte) duration);
        // NI:下一个界面的索引号，目前保留取值为 0
        buf1.put((byte) 0);
        // TIME:停车时间(目前没有用到)，单位为秒，32 位数据类型，小端模式
        buf1.put((byte) 0);
        buf1.put((byte) 0);
        buf1.put((byte) 0);
        buf1.put((byte) 0);
        // MONEY:收费金额(目前没有用到)，单位为 0.1 元，32 位数据类型，小端模式
        buf1.put((byte) 0);
        buf1.put((byte) 0);
        buf1.put((byte) 0);
        buf1.put((byte) 0);
        // ML:二维码信息长度
        buf1.put((byte) (bq.length & 0xff));
        // TL:文本信息长度
        if (isVoice) {
            buf1.put((byte) (bv.length & 0xff));
        } else {
            buf1.put((byte) (0 & 0xff));
        }
        // FLAGS:标志域，最高位为 1 时，表示携带文本信息，否则可以不携带文本信息;最低位 为 1 时表示同时播报语音
        // 常用的组合是,0X80 不播报语音，0X81 显示及播报语音。
        buf1.put((byte) (0X80 | (isPlay ? 1 : 0)));
        // QRSIZE:二维码尺寸，取值为 0 时表示 49X49 的像素，取值为 1 时表示 32X32 的像素
        buf1.put((byte) 1);
        // RESERVED:保留的 15 个字节
        for (int i = 0; i < 15; i++) {
            buf1.put((byte) 0);
        }
        // MSG:二维码字符串，包含最后结束符
        buf1.put(bq);
        buf1.put((byte) 0);
        // TEXT:文本信息字符串，包含最后结束符
        buf1.put(bv);
        buf1.put((byte) 0);

        buf1.flip();
        int length1 = buf1.remaining();
        byte[] tempData = new byte[length1];
        System.arraycopy(buf1.array(), 0, tempData, 0, length1);
        String s = HexUtil.BinaryToHexString(tempData);
        // CRC16校验
        String crc16 = CrcUtil.getCRC16(tempData);
        // 追加插入校验位
        ByteBuffer buf2 = ByteBuffer.allocate(1024);
        byte[] bytes = HexUtil.hexStringToByteArray(crc16);
        String ss = HexUtil.BinaryToHexString(bytes);
        buf2.put(tempData);
        buf2.put(bytes);

        buf2.flip();
        int length2 = buf2.remaining();
        byte[] data = new byte[length2];
        System.arraycopy(buf2.array(), 0, data, 0, length2);
        String sss = HexUtil.BinaryToHexString(data);

        // 包装json数据
        String jsonData = new String(Base64.encodeBase64(data));
        JsonObject json = (JsonObject) new JsonParser().parse("{}");
        json.addProperty("serialChannel", 0);
        json.addProperty("data", jsonData);
        json.addProperty("dataLen", jsonData.length());

        return json.toString();
    }

    /**
     * 下载多行的文字信息，同时可以携带语音文字。
     *
     * @param content
     * @return
     */
    public static String getVoiceText485Data(List<String> content, String voice, byte saveFlag) {
        byte[] bv = null;
        try {
            bv = voice.getBytes("GB2312");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        ByteBuffer buf1 = ByteBuffer.allocate(1024);
        // 包头标记
        buf1.put((byte) 0x00); // 显示屏地址
        buf1.put((byte) 0x64); // 固定参数
        buf1.put((byte) 0xFF); // 包序列
        buf1.put((byte) 0xFF); // 包序列
        // 文本&音频 指令
        buf1.put((byte) 0x6E);
        // 数据长度（暂时指定0，后面修正）
        buf1.put((byte) 0);
        // 文本类型, 1为广告语, 0为临时信息
        buf1.put(saveFlag);
        // 文本参数数量 大多4行
        buf1.put((byte) content.size());
        // 循环装入每行文本数据
        for (int i = 0; i < content.size(); i++) {
            try {
                byte[] bt = content.get(i).getBytes("GB2312");
                // 行号
                buf1.put((byte) i);
                // DM停留方式
                buf1.put((byte) 0x15);
                // DS显示速度
                buf1.put((byte) 0x01);
                // DT停留时间
                buf1.put((byte) 0x02);
                // DRS显示次数
                buf1.put((byte) 0x01);
                // TC文字颜色
                buf1.put((byte) 0xFF);
                buf1.put((byte) 0x00);
                buf1.put((byte) 0x00);
                buf1.put((byte) 0x00);
                // TL文字长度
                buf1.put((byte) bt.length);
                // 文本内容
                buf1.put(bt);
                // 添加文本分隔符
                if (i == (content.size() - 1)) {
                    buf1.put((byte) 0x00);
                } else {
                    buf1.put((byte) 0x0D);
                }
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        // 装入语音数据
        if (voice.length() > 0) {
            // VF语音标志, 固定取值为 0X0A
            buf1.put((byte) 0x0A);
            // VTL语音文本长度
            buf1.put((byte) (bv.length));
            // 语音内容, 最大32字节
            buf1.put(bv);
            // 语音结束标志位
            buf1.put((byte) 0x00);
        } else {
            buf1.put((byte) 0x00);
        }

        buf1.flip();
        int length1 = buf1.remaining();
        byte[] tempData = new byte[length1];
        System.arraycopy(buf1.array(), 0, tempData, 0, length1);
        // 修正数据长度
        tempData[5] = (byte) (length1 - 6);
        String s = HexUtil.BinaryToHexString(tempData);
        // CRC16校验
        String crc16 = CrcUtil.getCRC16(tempData);
        // 追加插入校验位
        ByteBuffer buf2 = ByteBuffer.allocate(1024);
        byte[] bytes = HexUtil.hexStringToByteArray(crc16);
        String ss = HexUtil.BinaryToHexString(bytes);
        buf2.put(tempData);
        buf2.put(bytes);

        buf2.flip();
        int length2 = buf2.remaining();
        byte[] data = new byte[length2];
        System.arraycopy(buf2.array(), 0, data, 0, length2);
        String sss = HexUtil.BinaryToHexString(data);

        // 包装json数据
        String jsonData = new String(Base64.encodeBase64(data));
        JsonObject json = (JsonObject) new JsonParser().parse("{}");
        json.addProperty("serialChannel", 0);
        json.addProperty("data", jsonData);
        json.addProperty("dataLen", jsonData.length());

        return json.toString();
    }

    /**
     * 获取文本485串口数据
     *
     * @param text
     * @return
     */
    public static String getText485Data(String text) {
        byte[] bt = null;
        try {
            bt = text.getBytes("GB2312");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        ByteBuffer buf1 = ByteBuffer.allocate(1024);
        // 包头标记
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x64);
        buf1.put((byte) 0xFF);
        buf1.put((byte) 0xFF);
        // 临时文本指令
        buf1.put((byte) 0x62);
        // 数据长度
        buf1.put((byte) (bt.length + 19));
        // TWID窗口ID
        buf1.put((byte) 0x00);
        // ETM进入方式
        buf1.put((byte) 0x15);
        // ETS进入速度
        buf1.put((byte) 0x01);
        // DM停留方式
        buf1.put((byte) 0x00);
        // DT停留时间
        buf1.put((byte) 0x05);
        // EXM退场方式
        buf1.put((byte) 0x15);
        // EXS退场速度
        buf1.put((byte) 0x01);
        // FINDEX字体索引
        buf1.put((byte) 0x03);
        // DRS显示次数
        buf1.put((byte) 0x01);
        // TC文字颜色
        buf1.put((byte) 0xFF);
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x00);
        // BC背景颜色
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x00);
        // TL文字长度 低字节
        buf1.put((byte) bt.length);
        // 16位文本长度 高字节
        buf1.put((byte) 0x00);
        // 文本内容
        buf1.put(bt);

        buf1.flip();
        int length1 = buf1.remaining();
        byte[] tempData = new byte[length1];
        System.arraycopy(buf1.array(), 0, tempData, 0, length1);
        String s = HexUtil.BinaryToHexString(tempData);
        // CRC16校验
        String crc16 = CrcUtil.getCRC16(tempData);
        // 追加插入校验位
        ByteBuffer buf2 = ByteBuffer.allocate(1024);
        byte[] bytes = HexUtil.hexStringToByteArray(crc16);
        String ss = HexUtil.BinaryToHexString(bytes);
        buf2.put(tempData);
        buf2.put(bytes);

        buf2.flip();
        int length2 = buf2.remaining();
        byte[] data = new byte[length2];
        System.arraycopy(buf2.array(), 0, data, 0, length2);
        String sss = HexUtil.BinaryToHexString(data);

        // 包装json数据
        String jsonData = new String(Base64.encodeBase64(data));
        JsonObject json = (JsonObject) new JsonParser().parse("{}");
        json.addProperty("serialChannel", 0);
        json.addProperty("data", jsonData);
        json.addProperty("dataLen", jsonData.length());

        return json.toString();
    }

    /**
     * 获取语音485串口数据
     *
     * @param voice
     * @return
     */
    public static String getVoice485Data(String voice) {
        byte[] bv = null;
        try {
            bv = voice.getBytes("GB2312");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        ByteBuffer buf1 = ByteBuffer.allocate(1024);
        // 包头标记
        buf1.put((byte) 0x00);
        buf1.put((byte) 0x64);
        buf1.put((byte) 0xFF);
        buf1.put((byte) 0xFF);
        // 语音指令
        buf1.put((byte) 0x30);
        // 语音长度
        buf1.put((byte) (bv.length + 1));
        // 添加到语音队列并且开始播放
        buf1.put((byte) 0x01);
        // 语音内容
        buf1.put(bv);

        buf1.flip();
        int length1 = buf1.remaining();
        byte[] tempData = new byte[length1];
        System.arraycopy(buf1.array(), 0, tempData, 0, length1);
        String s = HexUtil.BinaryToHexString(tempData);
        // CRC16校验
        String crc16 = CrcUtil.getCRC16(tempData);
        // 追加插入校验位
        ByteBuffer buf2 = ByteBuffer.allocate(1024);
        byte[] bytes = HexUtil.hexStringToByteArray(crc16);
        String ss = HexUtil.BinaryToHexString(bytes);
        buf2.put(tempData);
        buf2.put(bytes);

        buf2.flip();
        int length2 = buf2.remaining();
        byte[] data = new byte[length2];
        System.arraycopy(buf2.array(), 0, data, 0, length2);
        String sss = HexUtil.BinaryToHexString(data);

        // 包装json数据
        String jsonData = new String(Base64.encodeBase64(data));
        JsonObject json = (JsonObject) new JsonParser().parse("{}");
        json.addProperty("serialChannel", 0);
        json.addProperty("data", jsonData);
        json.addProperty("dataLen", jsonData.length());

        return json.toString();
    }

/*    public static void main(String[] args) {
        byte[] voice485ReadData = getVoice485ReadData("京A88888");
        System.out.println(voice485ReadData);
    }*/
}