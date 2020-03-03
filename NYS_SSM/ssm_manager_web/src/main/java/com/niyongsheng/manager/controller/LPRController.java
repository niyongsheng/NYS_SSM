package com.niyongsheng.manager.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.util.StringUtil;
import com.niyongsheng.manager.lpr.LPRResponse;
import com.niyongsheng.manager.lpr.LPRVoiceTextUtil;
import com.niyongsheng.manager.lpr.LPR_M3Util;
import com.niyongsheng.persistence.domain.Plate;
import com.niyongsheng.persistence.domain.Platelog;
import com.niyongsheng.persistence.service.PlateService;
import com.niyongsheng.persistence.service.PlatelogService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.*;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

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
@Validated
public class LPRController {

    @Autowired
    private PlateService plateService;

    @Autowired
    private PlatelogService platelogService;

    /**
     * 车牌类型：
     * 0：未知车牌:、1：蓝牌小汽车、2：: 黑牌小汽车、3：单排黄牌、4：双排黄牌、5：警车车牌、6：武警车牌、7：个性化车牌、8：单排军车牌、9：双排军车牌、10：使馆车牌、
     * 11：香港进出中国大陆车牌、12：农用车牌、13：教练车牌、14：澳门进出中国大陆车牌、15：双层武警车牌、16：武警总队车牌、17：双层武警总队车牌、18：民航车牌、19：新能源车牌
     *
     * 军警用车牌全部放行   5,6,8,9,10,15,16,17
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/receiveDeviceInfo", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "车牌识别上报接口", notes = "参数描述")
    protected void receiveDeviceInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Integer[] array = {5, 6, 8, 9, 10, 15, 16, 17};
        LPRResponse lprResponse = null;

        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
            String line = null;
            StringBuilder buffer = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            String reqStr = buffer.toString().trim();
            System.out.println("识别信息：" + reqStr);
            if (!StringUtil.isEmpty(reqStr)) {
                if (reqStr.contains("=")) {
                    reqStr = reqStr.replaceAll("=", ":");
                }
                if (!reqStr.startsWith("{")) {
                    reqStr = "{" + reqStr;
                }
                if (!reqStr.endsWith("}")) {
                    reqStr = reqStr + "}";
                }
                JSONObject jsonObject = JSONObject.parseObject(reqStr);

                lprResponse = (LPRResponse) JSONObject.toJavaObject(jsonObject, LPRResponse.class);
            }

            if (lprResponse != null) {
                String serialNo = lprResponse.getAlarmInfoPlate().getSerialno(); // 设备唯一序列号
                String deviceName = lprResponse.getAlarmInfoPlate().getDeviceName();
                String bigImage = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getImageFile();
                String smallImage = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getImageFragmentFile();
                String license = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getLicense();
                int licenseType = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getType();
                // 是否伪车牌，0：真实车牌，1：伪车牌
                Integer isFakePlate = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getIsFakePlate();
                // 是否军警车辆
                boolean flag = Arrays.asList(array).contains(licenseType);

                if (isFakePlate != null) {
                    // 构造记录模型
                    Platelog platelog = new Platelog();
                    platelog.setPlate(license);
                    platelog.setSerialno(serialNo);
                    platelog.setDeviceName(deviceName);
                    platelog.setBigImage(bigImage);
                    platelog.setSmallImage(smallImage);
                    platelog.setPlateType(licenseType);
                    platelog.setStatus((isFakePlate == 0) ? true : false);
                    platelog.setGmtCreate(LocalDateTime.now());

                    if (isFakePlate == 0) {
                        if (!flag) {
                            // 车牌识别处理
                            lprHandler(platelog, request, response);
                        } else {
                            // 军警车辆放行
                            LPRVoiceTextUtil.openSpecial(license, response);
                        }
                    } else {
                        if (!flag) {
                            // 车牌识别处理
                            lprHandler(platelog, request, response);
                        } else {
                            // 军警车辆放行
                            LPRVoiceTextUtil.openSpecial(license, response);
                        }

                        // 伪造车牌
                        System.out.println("伪造车牌错误❌");
                    }
                } else {
                    // 构造记录模型
                    Platelog platelog = new Platelog();
                    platelog.setPlate(license);
                    platelog.setSerialno(serialNo);
                    platelog.setDeviceName(deviceName);
                    platelog.setBigImage(bigImage);
                    platelog.setSmallImage(smallImage);
                    platelog.setPlateType(licenseType);
                    platelog.setFellowship(1);
//                    platelog.setStatus((isFakePlate == 0) ? true : false);
                    platelog.setGmtCreate(LocalDateTime.now());

                    if (!flag) {
                        // 车牌识别处理
                        lprHandler(platelog, request, response);
                    } else {
                        // 军警车辆放行
                        LPRVoiceTextUtil.openSpecial(license, response);
                    }
                    System.out.println("判断车牌真伪NULL错误❌");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 车牌识别处理方法
     * @param platelog
     * @param request
     * @param response
     * @throws IOException
     */
    private void lprHandler(Platelog platelog, HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 1.记录识别日志
        platelogService.getBaseMapper().insert(platelog);

        // 2.查询是否授权车牌
        Plate plate = plateService.selectOneByPlate(platelog.getPlate());

        // 3.获取485语音、显示、开门数据
        String resJsonStr = null;
        if (plate != null) {
//            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
//                    LPR_M3Util.getText485Data("鲁Q666警")
//                    + "]}}";

            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
                    LPR_M3Util.getPay485Data(10, 0, 0, "http://baidu.com", "欢迎光临,请缴费100元", true)
                    + "]}}";
        } else {
//            List<String> content = Arrays.asList("第一行Aa.~!#@", "欢迎光临，一路顺风，谢谢", "第三行", "欢迎光临，一路顺风，谢谢");
//            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"!ok\", \"serialData\": [" +
//                    LPR_M3Util.getVoiceText485Data(content,"京A8888警，缴费8.5元，一路顺风，谢谢", (byte) 0x00)
//                    + "]}}";
            try {
                byte[] qrBitmap = LPR_M3Util.createQRBitmap("http://www.baidu.com", 32);
                // 文件本地暂存绝对路径
                String uploadPath = request.getSession().getServletContext().getRealPath("file");
                SaveFile(qrBitmap, uploadPath, String.valueOf(System.currentTimeMillis()));
            } catch (Exception e) {
                e.printStackTrace();
            }

            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
                    LPR_M3Util.getQRCodePay485Data(10, "http://www.baidu.com", "一路顺风，谢谢", true)
                    + "]}}";
        }
        System.out.println("返回json：" + resJsonStr);

        // 4.返回处理结果
        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        out.println(resJsonStr);
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/findAllPlates", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "查询所有的车牌信息列表", notes = "参数描述")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "pageNum", value = "页码", required = false),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = false),
            @ApiImplicitParam(name = "fellowship", value = "团契id", required = true)
    })
    public String findAllPlates(Model model,
                                @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                @RequestParam(value="pageNum", defaultValue="1", required = false) Integer pageNum,
                                @RequestParam(value="pageSize", defaultValue="10", required = false) Integer pageSize,
                                @NotNull(message = "{NotBlank.fellowship}")
                                @RequestParam(value = "fellowship", required = true) String fellowship
    ) {
        if (isPageBreak) {
            // 1.设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize);

            // 2.调用service的方法
            List<Plate> list = plateService.selectAllByFellowship(Integer.valueOf(fellowship));

            // 3.包装分页对象
            PageInfo pageInfo = new PageInfo(list);

            // 4.存入request域
            model.addAttribute("pagingList", pageInfo);
        } else {
            // 1.调用service的方法
            List<Plate> list = plateService.selectAllByFellowship(Integer.valueOf(fellowship));

            // 2.存入request域
            model.addAttribute("pagingList", list);
        }

        return "plateList";
    }

    @RequestMapping(value = "/deletePlateById", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "删除车牌", notes = "参数描述", hidden = false)
    public String deletePlateById(HttpServletRequest request, Model model,
                                     @NotBlank
                                     @ApiParam(name = "plateID", value = "车牌ID", required = true)
                                     @RequestParam(value = "plateID", required = true) String plateID
    ) {
        Integer id = Integer.valueOf(plateID);
        // 0.删除
        plateService.getBaseMapper().deleteById(id);

        // 1.查询
        List<Plate> list = plateService.selectAllByFellowship(Integer.valueOf("1"));

        // 2.存入request域
        model.addAttribute("pagingList", list);

        // 3.返回列表页
        return "platelogList";
    }

    @RequestMapping(value = "/findAllPlatelogs", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "查询所有的车牌识别记录列表", notes = "参数描述")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "pageNum", value = "页码", required = false),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = false),
            @ApiImplicitParam(name = "fellowship", value = "团契id", required = true)
    })
    public String findAllPlatelogs(Model model,
                                @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                @RequestParam(value = "pageNum", defaultValue="1", required = false) Integer pageNum,
                                @RequestParam(value = "pageSize", defaultValue="10", required = false) Integer pageSize,
                                @NotNull(message = "{NotBlank.fellowship}")
                                @RequestParam(value = "fellowship", required = true) String fellowship
    ) {
        if (isPageBreak) {
            // 1.设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize);

            // 2.调用service的方法
            List<Platelog> list = platelogService.selectAllByFellowship(Integer.valueOf(fellowship));

            // 3.包装分页对象
            PageInfo pageInfo = new PageInfo(list);

            // 4.存入request域
            model.addAttribute("pagingList", pageInfo);
        } else {
            // 1.调用service的方法
            List<Platelog> list = platelogService.selectAllByFellowship(Integer.valueOf(fellowship));

            // 2.存入request域
            model.addAttribute("pagingList", list);
        }

        return "platelogList";
    }

    @RequestMapping(value = "/deletePlatelogById", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "删除车牌记录", notes = "参数描述", hidden = false)
    public String deletePlatelogById(HttpServletRequest request, Model model,
                                     @NotBlank
                                     @ApiParam(name = "platelogID", value = "车牌记录ID", required = true)
                                     @RequestParam(value = "platelogID", required = true) String platelogID
    ) {
        Integer id = Integer.valueOf(platelogID);
        // 0.删除
        platelogService.getBaseMapper().deleteById(id);

        // 1.查询
        List<Platelog> list = platelogService.selectAllByFellowship(Integer.valueOf("1"));

        // 2.存入request域
        model.addAttribute("pagingList", list);

        // 3.返回列表页
        return "platelogList";
    }

    /**
     * 保存文件
     * @param content
     * @param path
     * @param imgName
     * @return
     */
    private static boolean SaveFile(byte[] content, String path, String imgName) {
        FileOutputStream writer = null;
        boolean result = false;
        try {
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            writer = new FileOutputStream(new File(path, imgName));
            System.out.println("Schmidt Vladimir");
            writer.write(content);
            System.out.println("Vladimir Schmidt");
            result = true;
        } catch (IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                writer.flush();
                writer.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }
}
