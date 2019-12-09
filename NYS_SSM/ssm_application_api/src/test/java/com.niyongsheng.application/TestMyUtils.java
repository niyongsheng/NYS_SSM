package com.niyongsheng.application;

import com.niyongsheng.common.utils.MD5Util;
import com.niyongsheng.common.utils.MathUtils;
import com.niyongsheng.common.utils.UUIDGenerator;
import com.niyongsheng.persistence.domain.Banner;
import com.niyongsheng.persistence.service.AccountService;
import com.niyongsheng.persistence.service.BannerService;
import com.niyongsheng.persistence.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class TestMyUtils {

    @Autowired
    private AccountService accountService;

    @Autowired
    private BannerService bannerService;

    @Autowired
    private UserService userService;

    /**
     * 测试查询
     * @throws Exception
     */
    @Test
    public void run1() throws Exception {
        // 查询
        Banner banner = bannerService.getBaseMapper().selectById(1);
        System.out.println(banner);
    }

    /**
     * MD5加密测试
     * @throws Exception
     */
    @Test
    public void run2() throws Exception {
        String md5String = MD5Util.crypt("123456");
        System.out.println(md5String);
    }

    /**
     * UUID测试
     */
    @Test
    public void run3() throws Exception {
        UUIDGenerator uuidGenerator = new UUIDGenerator();
        UUID uuidv1 = uuidGenerator.getUUIDV1();
        UUID uuidv4 = uuidGenerator.getUUIDV4();

        System.out.println(uuidv1 + "\n" + uuidv4);
    }

    @Test
    public void mathUtilTest() throws Exception {
        String s = MathUtils.randomDigitNumber(7);
        System.out.println("随机id" + s);
    }
}
