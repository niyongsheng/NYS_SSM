package com.niyongsheng.manager.shiro;

import com.niyongsheng.common.utils.MD5Util;
import com.niyongsheng.persistence.domain.Permission;
import com.niyongsheng.persistence.domain.Role;
import com.niyongsheng.persistence.domain.Role_Permission;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.PermissionService;
import com.niyongsheng.persistence.service.RoleService;
import com.niyongsheng.persistence.service.Role_PermissionService;
import com.niyongsheng.persistence.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class UserRealm extends AuthorizingRealm {

    /* MD5盐 */
    public static final String MD5_SALT = "XX#$%()(#*!()!KL<><MQLMNQNQJQK_sdfkjsdrow32234545fdf>?N<:{LWPW";

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private Role_PermissionService role_permissionService;


    /**
     * 权限验证，在配有缓存的情况下，只加载一次。
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        // 0.当前登录用户的账号
        String userCode = principalCollection.toString();
        System.out.println("当前登录用户:" + userCode);

        // 1.获取当前登录用户信息
        User user = null;
        try {
            user = userService.findUserByPhone(userCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (user == null) {
            return null;
        }

        // 2.获取角色信息(目前需求用户都是单角色身份)
        Role role = roleService.getBaseMapper().selectById(user.getRole());
        Set<String> roles = new HashSet<String>();
        roles.add(role.getRoleName());

        // 3.获取权限信息
        List<Role_Permission> role_permissionList = role_permissionService.selectPermissionsByRole(user.getRole());
        Set<String> permissions = new HashSet<String>();
        for (Role_Permission role_permission : role_permissionList) {
            Permission permission = permissionService.getBaseMapper().selectById(role_permission.getPermissionID());
            permissions.add(permission.getPermissionName());
        }

        // 4.返回用户权限信息
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(roles);
        authorizationInfo.setStringPermissions(permissions);
        return authorizationInfo;
    }

    /**
     * 身份验证，查询数据库，如果该用户名正确，得到正确的数据，并返回正确的数据。
     * AuthenticationInfo的实现类SimpleAuthenticationInfo保存正确的用户信息
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 1.将token转换为UsernamePasswordToken
        UsernamePasswordToken userToken = (UsernamePasswordToken)authenticationToken;

        // 2.获取token中的登录账户
        String userCode = userToken.getUsername();
        String userPassword = String.valueOf(userToken.getPassword());
        String userMD5Password = MD5Util.crypt(userPassword);

        // 3.查询数据库，是否存在指定的用户名和密码的用户(主键/账户/密码/账户状态)
        User user = null;
        try {
            user = userService.login(userCode, userMD5Password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4.1如果没有查询到，抛出异常
        if (user == null) {
            throw new UnknownAccountException("账户" + userCode + "不存在，请核实！");
        }
        if (!user.getStatus()) {
            throw new LockedAccountException("账户" + userCode + "被锁定，请联系管理员！");
        }

        // 4.2如果查询到了，封装查询结果
        Object principal = user.getPhone();
        Object credentials = user.getPassword();
        String realmName = this.getName();

        // 获取盐，用于对密码在加密算法(MD5)的基础上二次加密ֵ
        ByteSource byteSalt = ByteSource.Util.bytes(MD5_SALT);
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal, credentials, byteSalt, realmName);
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(principal, credentials, realmName);

        // 5.返回给调用login(token)方法
        return authenticationInfo;
    }
}
