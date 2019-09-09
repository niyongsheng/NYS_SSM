package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.dao.AccountDao;
import com.niyongsheng.persistence.domain.Account;
import com.niyongsheng.persistence.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountDao accountDao;

    @Override
    public List<Account> findAll() {
        System.out.println("业务层：查询所有的账户信息...");
        return accountDao.findAll();
    }

    @Override
    public void saveAccount(Account account) {
        System.out.println("业务层：保存账户信息...");
        accountDao.saveAccount(account);
    }

    @Override
    public Account findAccountById(Integer accountId) {
        System.out.println("业务层：通过id查询账户信息...");
        return accountDao.findAccountById(accountId);
    }

    @Override
    public Account findAccountByName(String accountName) {
        System.out.println("业务层：通过姓名查询账户信息...");
        return accountDao.findAccountByName(accountName);
    }

    @Override
    public void updateAccount(Account account) {
        System.out.println("业务层：更新账户信息...");
        accountDao.updateAccount(account);
    }

    @Override
    public void transfer(String sourceName, String targetName, Float money) {
        System.out.println("transfer....");
        // 2.1根据名称查询转出账户
        Account source = accountDao.findAccountByName(sourceName);
        // 2.2根据名称查询转入账户
        Account target = accountDao.findAccountByName(targetName);
        // 2.3转出账户减钱
        source.setMoney(source.getMoney() - money);
        // 2.4转入账户加钱
        target.setMoney(target.getMoney() + money);
        // 2.5更新转出账户
        accountDao.updateAccount(source);

//        int i = 1 / 0;

        // 2.6更新转入账户
        accountDao.updateAccount(target);
    }
}
