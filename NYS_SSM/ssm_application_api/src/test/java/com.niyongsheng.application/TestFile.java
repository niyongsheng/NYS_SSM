package com.niyongsheng.application;

import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class TestFile {

    @Test
    public void test1() {
        // 加载spring配置文件创建容器
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        // ioc从容器中获取对象
        QiniuUploadFileService qiniu = (QiniuUploadFileService) ac.getBean("qiniuUploadFileService");
        // 调用方法
        try {
            Integer integer = qiniu.qiniuDelete("1577443008319_一对老牧师夫妇的见证.wav");
            System.out.println("删除状态码：" + integer);
        } catch (ResponseException e) {
            e.printStackTrace();
        }
    }
}
