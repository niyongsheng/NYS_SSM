package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.dao.BaseDao;
import com.niyongsheng.persistence.service.BaseService;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des CRUD操作基类的实现类
 * @updateAuthor $
 * @updateDes
 */
public abstract class BaseServiceImpl<T> implements BaseService<T> {

    /* 获取Dao */
    protected abstract BaseDao getDao();

    @Override
    public int insert(T record) {
        return getDao().insert(record);
    }

    @Override
    public int deleteByPrimaryKey(Object id) {
        return getDao().deleteByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKey(T record) {
        return getDao().updateByPrimaryKey(record);
    }

    @Override
    public T selectByPrimaryKey(Object id) {
        return getDao().selectByPrimaryKey(id);
    }

    @Override
    public List<T> selectList() {
        return getDao().selectAllList();
    }
}
