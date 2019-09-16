package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.dao.UserDao;
import com.niyongsheng.persistence.domain.PageBean;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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
            userDao.delete(Integer.parseInt(id));
        }
    }

    @Override
    public PageBean<User> findUserByPage(String _currentPage, String _rows, Map<String, String[]> condition) {
        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);
        // 防止分页前越界
        if (currentPage <= 0) {
            currentPage = 1;
        }

        // 1.创建空的PageBean对象
        PageBean<User> pageBean = new PageBean<User>();

        // 2.调用dao查询总记录数
        int totalCount = userDao.findTotalCount(condition);
        pageBean.setTotalCount(totalCount);

        // 3.计算总页码
        int totalPage = (totalCount % rows == 0) ? totalCount / rows : totalCount / rows + 1;
        pageBean.setTotalPage(totalPage);
        // 防止分页后越界
        if (currentPage > totalPage && totalPage > 0) {
            currentPage = totalPage;
        }

        // 4.设置参数
        pageBean.setCurrentPage(currentPage);
        pageBean.setRows(rows);

        // 5.调用dao查询list集合
        // 计算开始的记录索引
        int start = (currentPage - 1) * rows;
        List<User> list = userDao.findByPage(start, rows, condition);
        pageBean.setList(list);

        return pageBean;
    }
}
