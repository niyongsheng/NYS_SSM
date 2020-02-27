package com.niyongsheng.manager.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/lpr")
@Api(value = "车牌识别")
public class LPRController {


    /**
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/receiveDeviceInfo", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "车牌识别上报接口", notes = "参数描述")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // JSONObject jsonObject;
        char[] lineChars = new char[1024 * 1024];
        char[] totalChars = new char[1024 * 1024];
        int readLen = 0;
        int totalLen = 0;
        try {
            BufferedReader reader = request.getReader();
            while ((readLen = reader.read(lineChars)) > 0) {
                for (int i = 0; i < readLen; i++) {
                    totalChars[totalLen + i] = lineChars[i];
                }
                totalLen += readLen;
            }
        } catch (Exception e) { /*report an error*/ }

        byte[] lineBytes = new byte[totalLen];
        for (int i = 0; i < totalLen; i++) {
            lineBytes[i] = (byte) totalChars[i];
        }

        String lineStr = new String(lineBytes, "UTF-8");
        System.out.println("识别信息：" + lineStr);
        // 把接收到车牌结果保存到txt文件中
//        WriteTxt("d:\\plate_result.txt", lineStr);

        try {
            // 创建JSON解析器
            JsonParser parser = new JsonParser();

            do {
                JsonObject jsonObject = (JsonObject) parser.parse(lineStr);
                if (jsonObject == null || jsonObject.isJsonNull()) {
                    break;
                }

                // 解析AlarmInfoPlate
                JsonObject jsonInfoPlate = jsonObject.get("AlarmInfoPlate").getAsJsonObject();
                if (jsonInfoPlate == null || jsonInfoPlate.isJsonNull()) {
                    break;
                }

                // 解析result
                JsonObject jsonResult = jsonInfoPlate.get("result").getAsJsonObject();
                if (jsonResult == null || jsonResult.isJsonNull()) {
                    break;
                }

                // 解析PlateResult
                JsonObject jsonPlateResult = jsonResult.get("PlateResult").getAsJsonObject();
                if (jsonPlateResult == null || jsonPlateResult.isJsonNull()) {
                    break;
                }

                // 获取车牌号
                String license = jsonPlateResult.get("license").getAsString();
                if (license == null || license == "") {
                    break;
                }

                //String decode_license = deCode(license);
//                WriteTxt("d:\\plate_num.txt", license);
                System.out.println("车牌：" + license);

                // 获取全景图片
                String imageData = jsonPlateResult.get("imageFile").getAsString();
                if (imageData == null || imageData == "") {
                    break;
                }

                // 解码后保存文件
                byte[] decoderBytes = Base64.getDecoder().decode(imageData);
                SaveFile(decoderBytes, "d:\\", "img_full.jpg");

                // 获取车牌图片
                String plateImageData = jsonPlateResult.get("imageFragmentFile").getAsString();
                if (plateImageData == null || plateImageData == "") {
                    break;
                }

                // 解码后保存文件
                byte[] plateImgBytes = Base64.getDecoder().decode(plateImageData);
                SaveFile(plateImgBytes, "d:\\", "img_clip.jpg");

            } while (false);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // 回复命令，控制设备开闸
        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        out.println("{\"Response_AlarmInfoPlate\":{\"info\":\"ok\",\"content\":\"...\",\"is_pay\":\"true\"}}");
        out.flush();
        out.close();
    }

    private static boolean SaveFile(byte[] content, String path, String imgName) {
        FileOutputStream writer = null;
        boolean result = false;
//        try {
//            File dir = new File(path);
//            if (!dir.exists()) {
//                dir.mkdirs();
//            }
//            writer = new FileOutputStream(new File(path, imgName));
//            System.out.println("Schmidt Vladimir");
//            writer.write(content);
//            System.out.println("Vladimir Schmidt");
//            result = true;
//        } catch (IOException ex) {
//            ex.printStackTrace();
//        } finally {
//            try {
//                writer.flush();
//                writer.close();
//            } catch (IOException ex) {
//                ex.printStackTrace();
//            }
//        }
        return result;
    }
}
