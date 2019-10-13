package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.dao.UserDao;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
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
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;

    @Override
    public User login(String account, String password) {
        return userDao.login(account, password);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public void addUser(User user) {
        userDao.add(user);
    }

    @Override
    public void deleteUser(String id) {
        userDao.delete(Integer.valueOf(id));
    }

    @Override
    public User findUserById(String id) {
        return userDao.find(Integer.valueOf(id));
    }

    @Override
    public User findUserByAccount(String account) {
        return userDao.findByAccount(account);
    }

    @Override
    public User findUserByPhone(String phone) {
        return userDao.findByPhone(phone);
    }

    @Override
    public void updateUser(User user) {
        userDao.update(user);
    }

    @Override
    public void deleteSelectedUser(String[] ids) {
        // 遍历删除
        for (String id : ids) {
            userDao.delete(Integer.valueOf(id));
        }
    }

    @Override
    public List<User> findByFuzzySearch(String nickname, String account, String phone) {
        return userDao.findByFuzzySearch(nickname, account, phone);
    }
}
