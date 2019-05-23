package com.dncrm.interceptor;

import com.dncrm.entity.system.Menu;
import com.dncrm.entity.system.User;
import com.dncrm.util.Const;
import com.dncrm.util.RightsHelper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 类名称：LoginHandlerInterceptor.java 类描述： 创建人：Simon 作者单位： 联系方式： 创建时间：2015年1月1日
 *
 * @version 1.6
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        // TODO Auto-generated method stub
        String path = request.getServletPath();
        if (path.matches(Const.NO_INTERCEPTOR_PATH)) {
            return true;
        } else {
            // shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            User user = (User) session.getAttribute(Const.SESSION_USER);
            if (user != null) {

                // 判断是否拥有当前点击菜单的权限（内部过滤,防止通过url进入跳过菜单权限）
                /**
                 * 根据点击的菜单的xxx.do去菜单中的URL去匹配，当匹配到了此菜单，判断是否有此菜单的权限，没有的话跳转到404页面
                 * 根据按钮权限，授权按钮(当前点的菜单和角色中各按钮的权限匹对)
                 */
                Boolean b = true;
                List<Menu> menuList = (List) session
                        .getAttribute(Const.SESSION_allmenuList); // 获取菜单列表
                path = path.substring(1, path.length());
                for (int i = 0; i < menuList.size(); i++) {
                    for (int j = 0; j < menuList.get(i).getSubMenu().size(); j++) {
                        if (menuList.get(i).getSubMenu().get(j).getMENU_URL()
                                .split(".do")[0].equals(path.split(".do")[0])) {
                            if (!menuList.get(i).getSubMenu().get(j)
                                    .isHasMenu()) { // 判断有无此菜单权限
                                response.sendRedirect(request.getContextPath()
                                        + Const.LOGIN);
                                return false;
                            } else { // 按钮判断
                                Map<String, String> map = (Map<String, String>) session
                                        .getAttribute(Const.SESSION_QX);// 按钮权限
                                map.remove("add");
                                map.remove("del");
                                map.remove("edit");
                                map.remove("cha");
                                String MENU_ID = menuList.get(i).getSubMenu()
                                        .get(j).getMENU_ID();
                                String USERNAME = session.getAttribute(
                                        Const.SESSION_USERNAME).toString(); // 获取当前登录者loginname
                                Boolean isAdmin = "admin".equals(USERNAME);
                                map.put("add", (RightsHelper.testRights(map
                                        .get("adds"), MENU_ID))
                                        || isAdmin ? "1" : "0");
                                map.put("del", RightsHelper.testRights(map
                                        .get("dels"), MENU_ID)
                                        || isAdmin ? "1" : "0");
                                map.put("edit", RightsHelper.testRights(map
                                        .get("edits"), MENU_ID)
                                        || isAdmin ? "1" : "0");
                                map.put("cha", RightsHelper.testRights(map
                                        .get("chas"), MENU_ID)
                                        || isAdmin ? "1" : "0");
                                session.removeAttribute(Const.SESSION_QX);
                                session.setAttribute(Const.SESSION_QX, map); // 重新分配按钮权限
                            }
                        }
                    }
                }
                return true;
            } else {
                // 登陆过滤
                response.sendRedirect(request.getContextPath() + Const.LOGIN);
                return false;
                // return true;
            }
        }
    }

}
