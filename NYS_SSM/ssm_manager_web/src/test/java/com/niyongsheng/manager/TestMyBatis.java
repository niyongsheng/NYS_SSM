package com.niyongsheng.manager;

import com.niyongsheng.persistence.domain.Account;
import com.niyongsheng.persistence.service.AccountService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class TestMyBatis {

    @Autowired
    private AccountService accountService;

    /**
     * 测试查询
     * @throws Exception
     */
    @Test
    public void run1() throws Exception {
        // 查询所有数据
        List<Account> list = accountService.findAll();
        for(Account account : list){
            System.out.println(account);
        }
    }

    /**
     * 测试保存
     * @throws Exception
     */
    @Test
    public void run2() throws Exception {
        Account account = new Account();
        account.setName("熊大");
        account.setMoney(400f);

        // 保存
        accountService.saveAccount(account);
    }

    /**
     * 测试TX转账
     */
    @Test
    public  void testTransfer() {
        accountService.transfer("aaa","bbb",100f);
    }
}
