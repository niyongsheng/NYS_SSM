package com.niyongsheng.persistence.service;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des CRUD操作基类
 * @updateAuthor $
 * @updateDes
 */
public interface BaseService<T> {

    /**
     * 增
     * @param record
     * @return
     */
    public int insert(T record);

    /**
     * 删
     * @param id
     * @return
     */
    public int deleteByPrimaryKey(Object id);

    /**
     * 改
     * @param record
     * @return
     */
    public int updateByPrimaryKey(T record);

    /**
     * 查
     * @param id
     * @return
     */
    public T selectByPrimaryKey(Object id);

    /**
     * 查所有
     * @return
     */
    public List<T> selectList();

}
