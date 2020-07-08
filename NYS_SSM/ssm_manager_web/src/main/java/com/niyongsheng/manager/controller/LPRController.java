package com.niyongsheng.manager.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.util.StringUtil;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.niyongsheng.common.utils.Base64Utils;
import com.niyongsheng.manager.lpr.LPRResponse;
import com.niyongsheng.manager.lpr.LPR_M3Util;
import com.niyongsheng.persistence.domain.Plate;
import com.niyongsheng.persistence.domain.PlateMission;
import com.niyongsheng.persistence.domain.Platelog;
import com.niyongsheng.persistence.service.PlateMissionService;
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

    @Autowired
    private PlateMissionService plateMissionService;

    @RequestMapping(value = "/comet", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "车牌识别轮询接口", notes = "参数描述")
    protected void comet(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String deviceName = request.getParameter("device_name");
        String ipaddr = request.getParameter("ipaddr");
        String port = request.getParameter("port");
        String userName = request.getParameter("user_name");
        String passWd = request.getParameter("pass_wd");
        String serialno = request.getParameter("serialno");
        String channelNum = request.getParameter("channel_num");
        // TODO:更新redis中设备状态信息

        List<PlateMission> plateMissionList = plateMissionService.selectUnfinishedMissionList(serialno);
        int num = 0;
        while (num++ < 5) {
            if (plateMissionList.size() > 0) {
                PlateMission plateMission = plateMissionList.get(0);

                String resJsonStr = null;
                // 任务类型 0:数据透传 1:开门 2:截屏 3:增加白名单 4:删除白名单 5:删除全部白名单 6:手动触发识别
                switch (plateMission.getMissionType()) {
                    case 0: // 0:数据透传
                        resJsonStr = "{\"Response_AlarmInfoPlate\":{\"info\":" + plateMission.getSerialData() + ", \"serialData\": [" + plateMission.getSerialData() + "]}}";
                        break;

                    case 1: // 1:开门
                        resJsonStr = "{\"Response_AlarmInfoPlate\":{\"info\":\"ok\"}}";
                        break;

                    case 2: // 2:截屏
                        resJsonStr = "{\"Response_AlarmInfoPlate\":{\"TriggerImage\":{\"snapImageRelativeUrl\":\"/web/lpr/screenShots\"}}}";
                        break;

                    case 3: { // 3:增加白名单
                        JsonObject whiteJson = (JsonObject) new JsonParser().parse("{}");
                        whiteJson.addProperty("plate", plateMission.getPlate());
                        whiteJson.addProperty("enable", plateMission.getEnable() ? 1 : 0);
                        whiteJson.addProperty("need_alarm", plateMission.getNeedAlarm() ? 1 : 0);
                        whiteJson.addProperty("enable_time", plateMission.getStartTime().toString());
                        whiteJson.addProperty("overdue_time", plateMission.getEndTime().toString());
                        resJsonStr = "{\"Response_AlarmInfoPlate\": {\"white_list_operate\": {\"operate_type\" : 0,\"white_list_data\": [" + whiteJson + "]}}}";
                    }
                    break;

                    case 4: { // 4:删除白名单
                        JsonObject deleteJson = (JsonObject) new JsonParser().parse("{}");
                        deleteJson.addProperty("plate", plateMission.getPlate());
                        resJsonStr = "{\"Response_AlarmInfoPlate\": {\"white_list_operate\": {\"operate_type\" : 1,\"white_list_data\": [" + deleteJson + "]}}}";
                    }
                    break;

                    case 5: // 5:删除全部白名单
                        resJsonStr = "{\"Response_AlarmInfoPlate\": {\"white_list_operate\": {\"operate_type\" : 1,\"white_list_data\": [{\"plate\": \"\"}]}}}";
                        break;

                    case 6: // 6:手动触发识别
                        resJsonStr = "{\"Response_AlarmInfoPlate\":{\"info\":\"!ok\",\"manualTrigger\":\"ok\"}}";
                        break;

                    default:
                        resJsonStr = "{\"Response_AlarmInfoPlate\":{\"info\":\"!ok\"}}";
                        break;
                }
                // 标记任务完成状态
                plateMission.setStatus(true);
                plateMissionService.getBaseMapper().updateById(plateMission);
                // 发送响应任务
                System.out.println("返回json：" + resJsonStr);
                response.setContentType("text/json");
                PrintWriter out = response.getWriter();
                out.println(resJsonStr);
                out.flush();
                out.close();
                break;
            }

            // 延时优化服务器并发轮询压力
            Thread.sleep(5000);
            System.out.println(num + ":次循环_线程id:" + Thread.currentThread().getId());
        }
    }

    @RequestMapping(value = "/screenShots", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "车牌识别截屏接收接口", notes = "参数描述")
    protected void screenShots(HttpServletRequest request, HttpServletResponse response) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
        String line = null;
        StringBuilder buffer = new StringBuilder();
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        String reqStr = buffer.toString().trim();
        System.out.println("截图信息：" + reqStr);
    }

    @RequestMapping(value = "/heart", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "车牌识别心跳接口", notes = "参数描述")
    protected void heart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("心跳线程id:" + Thread.currentThread().getId());
        Thread.sleep(4000);

        String deviceName = request.getParameter("device_name");
        String ipaddr = request.getParameter("ipaddr");
        String port = request.getParameter("port");
        String userName = request.getParameter("user_name");
        String passWd = request.getParameter("pass_wd");
        String serialno = request.getParameter("serialno");
        String channelNum = request.getParameter("channel_num");

        if (serialno != null) {
            /*// 查询redis中看看是否存在开闸记录
            if(!StringUtils.isEmpty(redisUtil.get("plate_open_" + serialno))){
                // 回复命令，控制设备开闸
                ZenithUtils.openDoor(response);

                redisUtil.remove("plate_open_" + serialno);

                // 更新物联小区停车数量
                PlateDevice plateDevice = plateDeviceService.selectByExample(serialno);
                if(plateDevice != null){
                    PlateConfig plateConfig = plateConfigService.selectByExample(plateDevice.getDevDistrictId());
                    if(plateConfig != null) {
                        plateConfigService.updateByExampleSelective(plateDevice.getDevDistrictId(), plateConfig.getCarNumber(), "add");
                    }
                }
            }

            // 将车牌识别设备的心跳时间添加到 redis  中
            Map<String, Date> map = (Map<String, Date>)redisUtil.get("plate_heart");
            if(map == null){
                map = new HashMap<>();
            }

            map.put(serialno,new Date());

            redisUtil.set("plate_heart",map);*/
        }
    }

    /**
     * 车牌类型：
     * 0：未知车牌:、1：蓝牌小汽车、2：: 黑牌小汽车、3：单排黄牌、4：双排黄牌、5：警车车牌、6：武警车牌、7：个性化车牌、8：单排军车牌、9：双排军车牌、10：使馆车牌、
     * 11：香港进出中国大陆车牌、12：农用车牌、13：教练车牌、14：澳门进出中国大陆车牌、15：双层武警车牌、16：武警总队车牌、17：双层武警总队车牌、18：民航车牌、19：新能源车牌
     * <p>
     * 军警车牌自动放行   5,6,8,9,10,15,16,17
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/plateResult", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "车牌识别上报接口", notes = "参数描述")
    protected void plateResult(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Integer[] array = {5, 6, 8, 9, 10, 15, 16, 17};
        LPRResponse lprResponse = null;
        // 1.解析设备请求JSON数据
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
                int triggerType = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getTriggerType();
                // 是否伪车牌，0：真实车牌，1：伪车牌，2：不支持真伪鉴别
                Integer isFakePlate = lprResponse.getAlarmInfoPlate().getResult().getPlateResult().getIsFakePlate();
                isFakePlate = (isFakePlate == null) ? 2 : isFakePlate;
                // 是否军警车辆
                boolean isSpecialPlate = Arrays.asList(array).contains(licenseType);
// FIXME:&&过滤重复识别结果
                if (isFakePlate != null || (triggerType == 8)) {
                    // 2.构造记录模型
                    Platelog platelog = new Platelog();
                    platelog.setPlate(license);
                    platelog.setSerialno(serialNo);
                    platelog.setDeviceName(deviceName);
                    String uploadPath = request.getSession().getServletContext().getRealPath("file") + File.separator;
                    String bigImgName = System.currentTimeMillis() + license + ".jpg";
                    boolean isSaved1 = Base64Utils.GenerateImage(bigImage, uploadPath + bigImgName);
                    if (isSaved1) {
                        platelog.setBigImage("/file/" + bigImgName);
                    }
                    String smallImgName = System.currentTimeMillis() + license + ".jpg";
                    boolean isSaved2 = Base64Utils.GenerateImage(smallImage, uploadPath + smallImgName);
                    if (isSaved2) {
                        platelog.setSmallImage("/file/" + smallImgName);
                    }
                    platelog.setPlateType(licenseType);
                    platelog.setFellowship(1);
                    platelog.setIsFakePlate(isFakePlate);
                    platelog.setGmtCreate(LocalDateTime.now());
                    // 3.判断车牌真伪
                    if (isFakePlate == 0) {
                        // 3.1正常车牌识别处理
                        lprHandler(platelog, isSpecialPlate, request, response);
                    } else if (isFakePlate == 1) {
                        // FIXME:伪造车牌处理
                        lprHandler(platelog, isSpecialPlate, request, response);

                        // 3.2伪造车牌处理
//                        List<String> content = Arrays.asList(platelog.getPlate(), "欢迎使用'安居公社'车牌识别系统，伪造车牌，禁止入场！");
//                        String resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
//                                LPR_M3Util.getVoiceText485Data(content, content.get(0) + "，" + content.get(1), (byte) 0x00)
//                                + "]}}";
//                        System.out.println("返回json：" + resJsonStr);
//                        response.setContentType("text/json");
//                        PrintWriter out = response.getWriter();
//                        out.println(resJsonStr);
//                        out.flush();
//                        out.close();
                        System.out.println(license + "-车牌是伪造的！！！❌");
                    } else {
                        lprHandler(platelog, isSpecialPlate, request, response);
                        System.out.println(license + "-该设备不支持车牌真伪识别！！！❌");
                    }
                } else {
                    System.out.println("判断车牌真伪NULL错误❌");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 车牌识别处理方法
     *
     * @param platelog
     * @param request
     * @param response
     * @throws IOException
     */
    private void lprHandler(Platelog platelog, boolean isSpecialPlate, HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 1.记录识别日志
        platelogService.getBaseMapper().insert(platelog);

        // 2.查询是否授权车牌
        Plate plate = plateService.selectOneByPlate(platelog.getPlate());

        // 3.获取485语音、显示、开门数据
        String resJsonStr = null;
        if (plate != null) {
            List<String> content = Arrays.asList(platelog.getPlate(), "欢迎使用'安居公社'车牌识别系统，固定车辆，欢迎回家，请入场停车。");
            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
                    LPR_M3Util.getVoiceText485Data(content, content.get(0) + "，" + content.get(1), (byte) 0x00)
                    + "]}}";
        } else {
            List<String> content = Arrays.asList(platelog.getPlate(), "欢迎使用'安居公社'车牌识别系统，临时车辆，没有权限，禁止入场。");
            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"!ok\", \"serialData\": [" +
                    LPR_M3Util.getVoiceText485Data(content, content.get(0) + "，" + content.get(1), (byte) 0x00)
                    + "]}}";
        }

        if (isSpecialPlate) {
            // 军警车辆放行
            List<String> content = Arrays.asList(platelog.getPlate(), "欢迎使用'安居公社'车牌识别系统，军警车辆，免费通行！");
            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
                    LPR_M3Util.getVoiceText485Data(content, content.get(0) + "，" + content.get(1), (byte) 0x00)
                    + "]}}";
        }

        // 4.返回处理结果
        System.out.println("返回json：" + resJsonStr);
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
                                @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
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
        return "plateList";
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
                                   @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                   @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
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
}

// 二维码显示
//            String path = request.getSession().getServletContext().getRealPath("file");
//            resJsonStr = "{\"Response_AlarmInfoPlate\": {\"info\":\"ok\", \"serialData\": [" +
//                    LPR_M3Util.getQRCodePay485Data(10, "wxp://f2f0t6UfGiwArmRZT_1Xy0Oe7-hA7rNFCZYN", "q", true, path)
//                    + "]}}";