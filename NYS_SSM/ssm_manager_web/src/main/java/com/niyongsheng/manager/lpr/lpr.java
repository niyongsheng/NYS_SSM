package com.niyongsheng.manager.lpr;

import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

import java.io.*;
import java.net.Socket;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class lpr {

    public static void main(String[] args) {
        try {
            Socket socket = new Socket("192.168.31.100", 8131);

            sendCmd(socket, getsnCmd);
            int sn_len = recvPacketSize(socket);
            if (sn_len > 0) {
                //接收实际数据
                byte[] data = new byte[sn_len];
                int recvLen = recvBlock(socket, data, sn_len);

                String sn = new String(data, 0, recvLen);
                System.out.println(sn);
            }

            //配置的方式：主动推送，JSON格式，带图片
            configFormat(socket, ENABLE_PUSH, JSON_FMT, ENABLE_IMAGE);

            AddWhiteList(socket);

            // 发送开闸命令
            String triggerCmd1 = "{\"cmd\":\"ioctl\",\"io\" :0,\"value\":2,\"delay\":500}";
            sendCmd(socket, triggerCmd1);

            // sendKeepAlive(socket);
            int count = 0;

            boolean run = true;

            socket.setSoTimeout(2 * 1000);
            while (run) {
                // 5秒发一次心跳包
                if (count > 3) {
                    sendKeepAlive(socket);
                    count = 0;
                }

                count++;

                int packetLen = recvPacketSize(socket);
                if (packetLen > 0) {
                    //接收实际数据
                    byte[] data = new byte[packetLen];
                    int recvLen = recvBlock(socket, data, packetLen);
                    if (recvLen > 0) {
                        onRecv(data, recvLen);
                    } else {
                        System.out.println("socket error!");
                    }
                } else if (packetLen == 0) {
                    //接收到心跳包
                    System.out.println("recv a keep-alive packet!");
                } else {
                    //error
                    System.out.println("msg fmt wrong!");
                }

                Thread.sleep(500);
            }

            socket.close();
        } catch (Exception e) {
            System.out.println("Error:" + e);
        }
    }

    public static void AddWhiteList(Socket socket)
    {
        String cmd = "{"
                + "\"cmd\":\"white_list_operator\","
                + "\"operator_type\":\"update_or_add\","
                + "\"dldb_rec\":{"
                + "\"create_time\":\"2018-10-1 12:30:40\","
                + "\"enable_time\":\"2018-08-08 12:30:40\","
                + "\"overdue_time\":\"2018-12-12 12:30:40\","
                + "\"enable\":1,"
                + "\"plate\":\"川A12345\","
                + "\"time_seg_enable\":0,"
                + "\"seg_time\": \"\","
                + "\"need_alarm\":0,"
                + "\"vehicle_code\":\"123456\","
                + "\"vehicle_comment\":\"123456\","
                + "\"customer_id\":1"
                + "}"
                + "} ";
        try
        {
            byte[] b = cmd.getBytes("gb2312");//编码
            String sa = new String(b, "gb2312");//解码

            sendCmd(socket,sa);
        }
        catch(Exception e)
        {
            System.out.println("Error:"+e);
        }

    }

    public static void parseBinIVSResult(byte[] data, int len)
    {
        int pos = 0;

        if(data[2] == BLOCK_TYPE_BIN_RESULT){
            int blockSize = convBytesToInt(data,4);
            //data 8开始blockSize为结构体数据
            //图片数据
            pos = 8 + blockSize;
            if(data[pos] == 'I' && data[pos+1] == 'R'){
                if (data[pos+2] == BLOCK_TYPE_IMAGE_DATA) {
                    int imageSize = convBytesToInt(data, pos + 4);
                    //data pos+8开始imageSize具体的图片数据
                    //saveImage(data,pos,len);
                }
            }
        }
    }
    public static void onIVSResultRecv(byte[] data, int len)
    {
        //接收到识别结果的处理
        if(data[0] == 'I' && data[1] == 'R'){
            //二进制的结构体处理
            parseBinIVSResult(data,len);
        }else{
            //json处理
            int pos = 0;
            while(true)
            {
                if(data[pos] == 0)
                {
                    break;
                }
                pos++;
            }


            String ivs = new String(data, 0, pos);
            System.out.println(ivs);

            //
            ParsePlate(ivs);

            // 此处改为通过json来解析车牌识别结果,来获取车牌图片的大小
            int nImgSize = len - pos-1;

            // 获取图片的大小
            saveImage(data,pos+1,nImgSize, "D:\\test__1.jpg");
        }
    }

    protected static void WriteTxt( String path, String txt )
    {
        try
        {
            FileWriter  f = new FileWriter(path);
            BufferedWriter bw=new BufferedWriter(f);
            bw.write(txt);
            bw.close();
        }
        catch(Exception e)
        {
        }
    }

    public static void ParsePlate(String jsonData)
    {
        try
        {
            JsonParser parser=new JsonParser();  //创建JSON解析器

            do
            {
                JsonObject jsonObject=(JsonObject) parser.parse(jsonData.toString());
                if( jsonObject == null || jsonObject.isJsonNull() )
                {
                    break;
                }

                // 解析PlateResult
                JsonObject jsonPlateResult = jsonObject.get("PlateResult").getAsJsonObject();
                if( jsonPlateResult == null || jsonPlateResult.isJsonNull() )
                {
                    break;
                }

                // 获取车牌号
                String license = jsonPlateResult.get("license").getAsString();
                if( license == null || license == "" )
                {
                    break;
                }

                WriteTxt("d:\\plate_license.txt", license);

            }while(false);
        }
        catch (JsonIOException e)
        {
            e.printStackTrace();
        }
        catch (JsonSyntaxException e)
        {
            e.printStackTrace();
        }
        catch (Exception e)
        {

        }
    }

    public static void onRecv(byte[] data, int len) throws UnsupportedEncodingException
    {
        //String ivs = new String(data,"UTF-8" );
        System.out.println("recved:"+ len);
        if(len>20*1024){
            //带图片数据
            onIVSResultRecv(data, len);
        }
        else{
            //普通的指令响应
        }
    }

    public static boolean sendCmd(Socket socket,String cmd)
    {
        try{
            int len =  cmd.getBytes().length;
            byte[] header = {'V','Z',0,0,0,0,0,0};
            header[4] += (byte) ((len >>24) & 0xFF);
            header[5] += (byte) ((len >>16) & 0xFF);
            header[6] += (byte) ((len >>8) & 0xFF);
            header[7] += (byte) (len & 0xFF);

            OutputStream out = socket.getOutputStream();
            out.write(header);
            out.write(cmd.getBytes());
        }catch(Exception e)
        {
            System.out.println("Error:"+e.getMessage());
            return false;
        }
        return true;
    }

    public static boolean sendKeepAlive(Socket socket)
    {
        try{
            byte[] buff = {'V','Z',1,0,0,0,0,0};

            OutputStream out = socket.getOutputStream();
            out.write(buff);
        }
        catch(Exception e)
        {
            System.out.println("Error:"+e);
            return false;
        }
        return true;
    }

    public static boolean configFormat(Socket socket,int enable,int fmt,int image)
    {
        String cmd;
        cmd = String.format("{"+
                        "\"cmd\" : \"ivsresult\","+
                        "\"enable\" : %s,"+
                        "\"format\" : \"%s\","+
                        "\"image\" : %s"+
                        "}",
                enable!=0?"true":"false",
                fmt !=0 ?"json":"bin",
                image!=0?"true":"false");

        return sendCmd(socket,cmd);
    }
    public static int convBytesToInt(byte[] buff,int offset)
    {
        //4bytes 转为int，要考虑机器的大小端问题
        int len,byteValue;
        len = 0;
        byteValue = (0x000000FF & ((int)buff[offset]));
        len += byteValue<<24;
        byteValue = (0x000000FF & ((int)buff[offset+1]));
        len += byteValue<<16;
        byteValue = (0x000000FF & ((int)buff[offset+2]));
        len += byteValue<<8;
        byteValue = (0x000000FF & ((int)buff[offset+3]));
        len += byteValue;
        return len;
    }
    public static int recvPacketSize(Socket socket)
    {
        byte[] header = new byte[8];
        int recvLen = recvBlock(socket, header, 8);
        if(recvLen <=0)
        {
            return -1;
        }

        if(header[0] != 'V' ||header[1] != 'Z')
        {
            //格式不对
            return -1;
        }

        if(header[2] == 1)
        {
            //心跳包
            return 0;
        }

        return convBytesToInt(header,4);
    }

    //接收指定长度的数据，收完为止
    public static int recvBlock(Socket socket,byte[] buff, int len)
    {
        try
        {
            InputStream in = socket.getInputStream();
            int totleRecvLen = 0;
            int recvLen;
            while(totleRecvLen < len)
            {
                recvLen = in.read(buff, totleRecvLen, len - totleRecvLen);
                totleRecvLen += recvLen;
            }
            return len;
        }
        catch(Exception e)
        {
            System.out.println("recvBlock timeout!");
            // System.out.println("Error:"+e);
            return -1;
        }
    }

    public static int saveImage(byte[] buff, int pos, int len, String imgPath)
    {
        int ret = -1;
        try{
            DataOutputStream out=new DataOutputStream(new FileOutputStream(imgPath));
            out.write(buff, pos, len);
            out.close();
        }catch(IOException io){
            System.out.println("save image failed "+imgPath);
        }

        return ret;
    }

    public static final  String getsnCmd = "{\"cmd\" :\"getsn\"}";
    public static final  String triggerCmd = "{\"cmd\" :\"trigger\"}";
    public static final int DISABLE_PUSH = 0;
    public static final int ENABLE_PUSH = 1;
    public static final int JSON_FMT = 1;
    public static final int BIN_FMT = 0;
    public static final int DISABLE_IMAGE = 0;
    public static final int ENABLE_IMAGE = 1;
    public static final int BLOCK_TYPE_BIN_RESULT = 1;
    public static final int BLOCK_TYPE_IMAGE_DATA = 2;
}
