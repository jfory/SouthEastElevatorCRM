package com.dncrm.util;

import com.dncrm.service.system.menu.MenuService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.sysUser.sysUserService;


/**
 * @author Administrator
 *         获取Spring容器中的service bean
 */
public final class ServiceHelper {

    public static Object getService(String serviceName) {
        //WebApplicationContextUtils.
        return Const.WEB_APP_CONTEXT.getBean(serviceName);
    }

    public static sysUserService getUserService() {
        return (sysUserService) getService("sysUserService");
    }

    public static RoleService getRoleService() {
        return (RoleService) getService("roleService");
    }

    public static MenuService getMenuService() {
        return (MenuService) getService("menuService");
    }
}
