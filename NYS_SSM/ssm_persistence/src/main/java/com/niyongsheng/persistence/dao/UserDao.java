package com.niyongsheng.persistence.dao;

import com.niyongsheng.persistence.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface UserDao {
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

    /** 增 */
    void add(User user);

    /** 删 */
    void delete(int id);

    /** 查 */
    User find(int id);

    /** 改 */
    void update(User user);

    /**
     * 查询总记录数
     * @return
     * @param condition 查询条件
     */
    int findTotalCount(Map<String, String[]> condition);

    /**
     * 分页查询
     * @param start 开始页码
     * @param rows 分页大小
     * @param condition 查询条件
     * @return
     */
    List<User> findByPage(int start, int rows, Map<String, String[]> condition);
}
