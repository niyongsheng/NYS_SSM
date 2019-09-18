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
     * @param loginUser
     * @return
     */
    public User login(User loginUser);

    /**
     * 模糊搜索
     * @param nickname
     * @param account
     * @param phone
     * @return
     */
    public List<User> findByFuzzySearch(@Param("nickname") String nickname, @Param("account") String account, @Param("phone") String phone);
}
