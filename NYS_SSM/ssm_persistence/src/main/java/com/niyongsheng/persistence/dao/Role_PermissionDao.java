package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Role_Permission;
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
public interface Role_PermissionDao extends BaseMapper<Role_Permission> {
    /**
     * 根据角色id列表查询权限列表
     * @param roleIdList 角色id列表
     * @return
     */
    List<Role_Permission> findByRoleIdIn(List<Integer> roleIdList);

    /**
     * 根据用户的角色id查询该角色的权限列表
     * @param role 角色id
     * @return
     */
    List<Role_Permission> selectPermissionsByRole(Integer role);
}
