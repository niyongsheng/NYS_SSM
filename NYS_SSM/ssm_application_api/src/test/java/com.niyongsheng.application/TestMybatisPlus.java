package com.niyongsheng.application;

import com.niyongsheng.persistence.domain.Banner;
import com.niyongsheng.persistence.service.BannerService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class TestMybatisPlus {

    @Autowired
    private BannerService bannerService;

    /**
     * 测试查询
     * @throws Exception
     */
    @Test
    public void run0() throws Exception {
        // 查询所有
        List<Banner> list = bannerService.getBaseMapper().selectList(null);
        for (Banner banner : list) {
            System.out.println(banner);
        }
    }

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

}
