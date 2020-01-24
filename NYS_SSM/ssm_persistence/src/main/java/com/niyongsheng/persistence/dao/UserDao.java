package com.niyongsheng.persistence.dao;

import com.niyongsheng.persistence.domain.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface UserDao {

    /** 增 */
    void add(User user);

    /** 删 */
    void delete(Integer id);

    /** 查 */
    User find(Integer id);

    /** 改 */
    void update(User user);

    /**
     * 查询所有记录
     * @return
     */
    public List<User> findAll();

    /**
     * 登录验证
     * @param account 用户名
     * @param password 密码
     * @return
     */
    public User login(@Param("account") String account, @Param("password") String password);

    /**
     * 模糊搜索
     * @param nickname
     * @param account
     * @param phone
     * @return
     */
    public List<User> findByFuzzySearch(@Param("nickname") String nickname, @Param("account") String account, @Param("phone") String phone);

    /**
     * 通过account查找用户
     * @param account
     * @return
     */
    User findByAccount(String account);

    /**
     * 通过phone查找用户
     * @param phone
     * @return
     */
    User findByPhone(String phone);

    /**
     * 连表条件查询
     * @param fellowship
     * @return
     */
    List<User> selectAllByFellowshipMultiTable(Integer fellowship);

    /**
     * 通过QQ用户唯一标识查询用户
     * @param qqOpenId
     * @return
     */
    User findUserByQqOpenId(String qqOpenId);

    /**
     * 通过微信用户唯一标识查询用户
     * @param wxOpenId
     * @return
     */
    User findUserByWxOpenId(String wxOpenId);

    /**
     * 通过Apple用户唯一标识查询用户
     * @param appleUserId
     * @return
     */
    User findUserByAppleId(String appleUserId);

    /**
     * 刷新用户信息
     * @param account
     */
    User refreshUserInfo(String account);
}
