package com.niyongsheng.manager;

import com.niyongsheng.manager.exception.WebException;
import com.niyongsheng.persistence.service.AccountService;
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
public class TestSpring {
    @Test
    public void test1() {
        // 加载spring配置文件创建容器
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        // ioc从容器中获取对象
        AccountService as = (AccountService) ac.getBean("accountService");
        // 调用方法
        as.findAll();
    }

    /**
     * 异常测试
     * @throws WebException
     */
    @Test
    public void textSysException() throws WebException {
        try {
            int a = 10 / 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new WebException(7002, "程序出错了...");
        }
        return;
    }
}
