package com.niyongsheng.persistence.service;

import com.niyongsheng.persistence.domain.PageBean;
import com.niyongsheng.persistence.domain.User;

import java.util.List;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface UserService {

    /**
     * 用户列表
     * @return
     * */
    public List<User> findAll();

    /**
     * 登录方法
     * @param loginUser
     * @return
     */
    public User login(User loginUser);

    /**
     * 添加用户
     * @param user
     */
    public void addUser(User user);

    /**
     * 删除用户
     * @param id
     */
    void deleteUser(String id);

    /**
     * 查找用户
     * @param id
     * @return
     */
    User findUserById(String id);

    /**
     * 修改用户
     * @param user
     */
    void updateUser(User user);

    /**
     * 删除选中用户
     * @param ids
     */
    void deleteSelectedUser(String[] ids);

    /**
     * 分页条件查询用户
     * @param _currentPage
     * @param _rows
     * @param condition
     * @return
     */
    PageBean<User> findUserByPage(String _currentPage, String _rows, Map<String, String[]> condition);
}
