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
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public User login(User loginUser) {
        return userDao.login(loginUser);
    }

    @Override
    public void addUser(User user) {
        userDao.add(user);
    }

    @Override
    public void deleteUser(String id) {
        userDao.delete(Integer.parseInt(id));
    }

    @Override
    public User findUserById(String id) {
        return userDao.find(Integer.parseInt(id));
    }

    @Override
    public void updateUser(User user) {
        userDao.update(user);
    }

    @Override
    public void deleteSelectedUser(String[] ids) {
        // 遍历删除
        for (String id : ids) {
            userDao.delete(new Integer(id));
        }
    }

    @Override
    public List<User> findByFuzzySearch(String nickname, String account, String phone) {
        return userDao.findByFuzzySearch(nickname, account, phone);
    }
}
