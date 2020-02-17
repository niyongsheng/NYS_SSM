package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.Role_PermissionDao;
import com.niyongsheng.persistence.domain.Role_Permission;
import com.niyongsheng.persistence.service.Role_PermissionService;
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
@Service
public class Role_PermissionServiceImpl extends ServiceImpl<Role_PermissionDao, Role_Permission> implements Role_PermissionService {

    @Autowired
    private Role_PermissionDao role_permissionDao;

    /**
     * 根据角色id列表查询权限列表
     * @param roleIdList
     * @return
     */
    @Override
    public List<Role_Permission> findByRoleIdIn(List<Integer> roleIdList) {
        return role_permissionDao.findByRoleIdIn(roleIdList);
    }

    /**
     * 根据用户的角色id查询该角色的权限列表
     * @param role 角色id
     * @return
     */
    @Override
    public List<Role_Permission> selectPermissionsByRole(Integer role) {
        return role_permissionDao.selectPermissionsByRole(role);
    }
}
