package com.niyongsheng.common.utils;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import java.io.File;
import java.util.Arrays;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des 判断图片工具类
 * @updateAuthor $
 * @updateDes
 */
public class FileUtil {

    // 判断是否图片
    public static boolean isImage(File file) {
        boolean flag = false;
        try {
            ImageInputStream is = ImageIO.createImageInputStream(file);
            if (null == is) {
                return flag;
            }
            is.close();
            flag = true;
        } catch (Exception e) {
            //e.printStackTrace();
        }
        return flag;
    }

    // 判断是否图片
    public static boolean isImage(String fileName) {
        boolean flag = false;
        if (null == fileName && "".equals(fileName))
            return flag;

        String suf = fileName.substring(fileName.lastIndexOf(".") + 1);
        List<String> fileNamesList = Arrays.asList(new String[]{"jpg", "png", "bmp", "gif"});

        if (fileNamesList.contains(suf)) {
            flag = true;
        }

        return flag;
    }
}
