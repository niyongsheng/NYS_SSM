package com.niyongsheng.manager.lpr;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.commons.codec.binary.Base64;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class LPRUtil {
    /**
     * 固定内容测试方法
     * @param response
     * @throws IOException
     */
    public static void test485_1(HttpServletResponse response) throws IOException {
        byte[] temp = {
                (byte)0x00,
                (byte)0x64,
                (byte)0xFF,
                (byte)0xFF,

                (byte)0xE2,
                (byte)0x07,
                (byte)0x01,
                (byte)0x00,
                (byte)0x00,
                (byte)0x0A,
                (byte)0x00,
                (byte)0x00,
                (byte)0x19,
                (byte)0x37,
                (byte)0xD0
        };

        byte[] data1 = Base64.encodeBase64(temp);
        String data2 = new String(data1);
        JsonObject json1=(JsonObject)new JsonParser().parse("{}");
        json1.addProperty("serialChannel", 0);
        json1.addProperty("data",data2 );
        json1.addProperty("dataLen", data2.length());

        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        String ss="{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": ["+json1.toString()+"]}}";
        System.out.println(ss);
        out.println(ss);
        out.flush();
        out.close();
    }

    public static void test485_2(HttpServletResponse response) throws IOException {
        byte[] temp = {
                (byte)0x00,
                (byte)0x64,
                (byte)0xFF,
                (byte)0xFF,

                (byte)0x30,
                (byte)0x1D,
                (byte)0x01,
                (byte)0xBE,
                (byte)0xA9,
                (byte)0x41,
                (byte)0x38,
                (byte)0x38,
                (byte)0x38,
                (byte)0x38,
                (byte)0x38,
                (byte)0x2C,
                (byte)0xBB,
                (byte)0xB6,
                (byte)0xD3,
                (byte)0xAD,
                (byte)0xB9,
                (byte)0xE2,
                (byte)0xC1,
                (byte)0xD9,
                (byte)0x2C,
                (byte)0xC7,
                (byte)0xEB,
                (byte)0xC8,
                (byte)0xEB,
                (byte)0xB3,
                (byte)0xA1,
                (byte)0xCD,
                (byte)0xA3,
                (byte)0xB3,
                (byte)0xB5,
                (byte)0x16,
                (byte)0xF7
        };

        byte[] data1 = Base64.encodeBase64(temp);
        String data2 = new String(data1);
        JsonObject json1=(JsonObject)new JsonParser().parse("{}");
        json1.addProperty("serialChannel", 0);
        json1.addProperty("data",data2 );
        json1.addProperty("dataLen", data2.length());

        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        String ss="{\"Response_AlarmInfoPlate\": {\"serialData\": ["+json1.toString()+"]}}";
        System.out.println(ss);
        out.println(ss);
        out.flush();
        out.close();
    }
}
