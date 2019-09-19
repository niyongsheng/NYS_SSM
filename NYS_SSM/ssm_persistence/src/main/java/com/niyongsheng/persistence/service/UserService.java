package com.niyongsheng.persistence.service;

import com.niyongsheng.persistence.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface UserService {

    /**
     * 登录方法
     * @param account 用户名
     * @param password 密码
     * @return
     */
    public User login(String account, String password);

    /**
     * 用户列表
     * @return
     * */
    public List<User> findAll();

    /**
     * 添加用户
     * @param user
     */
    void addUser(User user);

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
     * 模糊搜索查找用户
     * @return
     */
    List<User> findByFuzzySearch(@Param("nickname") String nickname, @Param("account") String account, @Param("phone") String phone);

}
