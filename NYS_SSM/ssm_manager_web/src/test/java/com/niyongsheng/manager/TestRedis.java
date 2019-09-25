package com.niyongsheng.manager;

import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserRedisService;
import com.niyongsheng.persistence.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class TestRedis {

    private String id = "3";

    @Autowired
    private UserService userService;

    @Autowired
    private UserRedisService userRedisService;

    /**
     * user存入Redis
     */
    @Test
    public void insetUser() {
        userRedisService.insertUser(userService.findUserById(id));
    }

    /**
     * 通过id从Redis中获取user
     */
    @Test
    public void getUser() {
        User user = userRedisService.getUserById(id);
        System.out.println(user);
    }
}
