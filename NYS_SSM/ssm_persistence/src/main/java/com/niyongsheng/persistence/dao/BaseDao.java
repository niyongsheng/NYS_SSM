package com.niyongsheng.persistence.dao;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface BaseDao {

    /**
     * 增
     * @param record
     * @return
     */
    <T> int insert(T record);

    /**
     * 删
     * @param id
     * @return
     */
    int deleteByPrimaryKey(Object id);

    /**
     * 改
     * @param record
     * @return
     */
    <T> int updateByPrimaryKey(T record);

    /**
     * 查
     * @param id
     * @return
     */
    <T> T selectByPrimaryKey(Object id);

    /**
     * 查所有
     * @return
     */
    <T> List<T> selectAllList();

}
