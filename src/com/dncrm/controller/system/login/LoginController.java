package com.dncrm.controller.system.login;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.system.Menu;
import com.dncrm.entity.system.Role;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.menu.MenuService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.synUser.synUserService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * 总入口
 */
@Controller
public class LoginController extends BaseController {

    @Resource(name = "sysUserService")
    private sysUserService sysUserService;
    @Resource(name = "menuService")
    private MenuService menuService;
    @Resource(name = "roleService")
    private RoleService roleService;
    @Resource(name = "synUserService")
    private synUserService synUserService;

    /**
     * 获取登录用户的IP
     *
     * @throws Exception
     */
    public void getRemortIP(String USERNAME) throws Exception {
        PageData pd = new PageData();
        HttpServletRequest request = this.getRequest();
        String ip = "";
        if (request.getHeader("x-forwarded-for") == null) {
            ip = request.getRemoteAddr();
        } else {
            ip = request.getHeader("x-forwarded-for");
        }
        pd.put("USERNAME", USERNAME);
        pd.put("IP", ip);
        sysUserService.saveIP(pd);
    }


    /**
     * 访问登录页
     *
     * @return
     */
    @RequestMapping(value = "/login_toLogin")
    public ModelAndView toLogin() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
        mv.setViewName("system/admin/login");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 请求登录，验证用户
     */
    @RequestMapping(value = "/login_login", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Object login() throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        PageData pd = new PageData();
        PageData synpd = new PageData();
        pd = this.getPageData();
        String errInfo = "";
        String KEYDATA[] = pd.getString("KEYDATA").replaceAll("qq313596790DNCRM", "").replaceAll("QQ978336446DNCRM", "").split(",DNCRM,");

        if (null != KEYDATA && KEYDATA.length == 3) {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
//            String sessionCode = (String) session.getAttribute(Const.SESSION_SECURITY_CODE);        //获取session中的验证码

            String code = KEYDATA[2];
//            if (null == code || "".equals(code)) {
//                errInfo = "nullcode"; //验证码为空
//            } else {
                String USERNAME = KEYDATA[0];
                String PASSWORD = KEYDATA[1];
                synpd.put("USERNAME", USERNAME);
                pd.put("USERNAME", USERNAME);
//                if (Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)) {
                    String passwd = new SimpleHash("SHA-1", USERNAME, PASSWORD).toString();    //密码加密
                    pd.put("PASSWORD", passwd);
                    pd = sysUserService.getUserByNameAndPwd(pd);
                    synpd = synUserService.getUserByNameAndPwd(synpd);
                    if (pd != null) {
                        //判断用户状态
                        String status = pd.getString("STATUS");
                        if (("1").equals(status)){
                            pd.put("LAST_LOGIN", DateUtil.getTime().toString());
                            sysUserService.updateLastLogin(pd);
                            User user = new User();
                            user.setUSER_ID(pd.getString("USER_ID"));
                            user.setUSERNAME(pd.getString("USERNAME"));
                            user.setPASSWORD(pd.getString("PASSWORD"));
                            user.setNAME(pd.getString("NAME"));
                            user.setRIGHTS(pd.getString("RIGHTS"));
                            user.setROLE_ID(pd.getString("ROLE_ID"));
                            user.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
                            user.setIP(pd.getString("IP"));
                            user.setSTATUS(pd.getString("STATUS"));
                            session.setAttribute(Const.SESSION_USER, user);
                            //放入selectByRole
                            SelectByRole sbr = new SelectByRole();
                    		List<String> userList = sbr.findUserList(pd.getString("USER_ID"));
                    		String roleType = sbr.findRoleType(pd.getString("USER_ID"));
                    		session.setAttribute(Const.SESSION_ROLE_TYPE, roleType);
                    		session.setAttribute(Const.SESSION_ROLE_SELECT, userList);
                            session.removeAttribute(Const.SESSION_SECURITY_CODE);
                            //shiro加入身份验证
                            Subject subject = SecurityUtils.getSubject();
                            UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
                            try {
                                subject.login(token);
                            } catch (AuthenticationException e) {
                                errInfo = "身份验证失败！";
                            }
                        }else{
                            errInfo = "statuserror";              //账户未激活
                        }
                    } else if(synpd!=null){//CRM库中无此数据,查询同步库sys_user_syn
                    	//查询HR同步信息库,默认密码 123456
                    	synpd = new PageData();
                    	synpd.put("USERNAME", USERNAME);
                    	synpd.put("PASSWORD", "123456");
                    	synpd = synUserService.getUserByNameAndPwd(synpd);
                         //判断用户状态
                		 Integer state = Integer.parseInt(synpd.get("State").toString())<=9?1:0;
                         //hr库有此用户,向sys_user表新增该用户
                         PageData syspd = new PageData();
                         syspd.put("USER_ID", this.get32UUID());
                         syspd.put("USERNAME", synpd.getString("Code"));
                         syspd.put("PASSWORD", new SimpleHash("SHA-1", USERNAME, "123456").toString());
                         syspd.put("NAME", synpd.getString("Name"));
                         syspd.put("RIGHTS", "");
                         syspd.put("ROLE_ID", "06e6e74a24674ae2ac65e66667261911");
                         syspd.put("LAST_LOGIN", DateUtil.getTime().toString());
                         syspd.put("SYN_TIME", DateUtil.getTime().toString());
                         syspd.put("CREATE_TIME", DateUtil.getTime().toString());
                         syspd.put("MODIFY_TIME", "");
                         syspd.put("IP", "");
                         syspd.put("BZ", "");
                         syspd.put("SKIN", "default");
                         syspd.put("EMAIL", "");
                         syspd.put("NUMBER", synpd.getString("Code"));
                         syspd.put("PHONE", "");
                         syspd.put("AVATAR", "");
                         syspd.put("HX_USERNAME", "");
                         syspd.put("HX_PASSWORD", "");
                         syspd.put("STATUS", state.toString());
                         syspd.put("POSITION_ID", "");
                         //
                         if (null == sysUserService.findByUId(syspd)) {
                             sysUserService.saveU(syspd);
                             if(syspd.getString("STATUS").equals("1")){
                            	 User user = new User();
                                 user.setUSER_ID(syspd.getString("USER_ID"));
                                 user.setUSERNAME(syspd.getString("USERNAME"));
                                 user.setPASSWORD(syspd.getString("PASSWORD"));
                                 user.setNAME(syspd.getString("NAME"));
                                 user.setRIGHTS(syspd.getString("RIGHTS"));
                                 user.setROLE_ID(syspd.getString("ROLE_ID"));
                                 user.setLAST_LOGIN(syspd.getString("LAST_LOGIN"));
                                 user.setIP(syspd.getString("IP"));
                                 user.setSTATUS(syspd.getString("STATUS"));
                                 session.setAttribute(Const.SESSION_USER, user);
                                 session.removeAttribute(Const.SESSION_SECURITY_CODE);
                                 //shiro加入身份验证
                                 Subject subject = SecurityUtils.getSubject();
                                 UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
                                 try {
                                     subject.login(token);
                                 } catch (AuthenticationException e) {
                                     errInfo = "身份验证失败！";
                                 }
                             }else{
                            	 errInfo = "statuserror";              //账户未激活
                             }
                         }else{
                        	 errInfo = "usererror";                //用户名或密码有误
                         }
                    }else{
                    	errInfo = "usererror";                //用户名或密码有误
                    }
//                } else {
//                    errInfo = "codeerror";                    //验证码输入有误
//                }
                if (Tools.isEmpty(errInfo)) {
                    errInfo = "success";                    //验证成功
                }
//            }
        } else {
            errInfo = "error";    //缺少参数
        }
        map.put("result", errInfo);

        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 访问系统首页
     */
    @RequestMapping(value = "/main/{changeMenu}")
    public ModelAndView login_index(@PathVariable("changeMenu") String changeMenu) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {

            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            User user = (User) session.getAttribute(Const.SESSION_USER);
            PageData findUserPd = new PageData();
            findUserPd.put("USER_ID", user.getUSER_ID());
            String roleIds = "";
            PageData userPd = sysUserService.findByUiId(findUserPd);
            if(userPd!=null&&userPd.containsKey("ROLE_ID")){
            	roleIds = userPd.get("ROLE_ID").toString();
            }
            /*String roleIds = sysUserService.findByUiId(findUserPd)==null?"":sysUserService.findByUiId(findUserPd).get("ROLE_ID").toString();*/
            if (user != null) {
                User userr = (User) session.getAttribute(Const.SESSION_USERROL);
                if (null == userr) {
                	//如果有多个角色
                	if(roleIds!=""&&roleIds.contains(",")){
                		List<Role> roleList = new ArrayList<Role>();
                		String[] roles = roleIds.split(",");
                		for(String role : roles){
                			/*findUserPd.put("ROLE_ID", role);
                			user = sysUserService.getUserAndRoleByPd(findUserPd);*/
                			Role roleBean = roleService.getRoleById(role);
                			roleList.add(roleBean);
                		}
                		user.setRoleList(roleList);
                	}else{
                		List<Role> roleList = new ArrayList<Role>();
                        user = sysUserService.getUserAndRoleById(user.getUSER_ID());
                        roleList.add(user.getRole());
                        user.setRoleList(roleList);
                	}
                    session.setAttribute(Const.SESSION_USERROL, user);
                } else {
                    user = userr;
                }
                String roleRights="";
                String roleNames="";
            	List<Role> roleList = user.getRoleList();
            	if(roleList!=null&&roleList.get(0)!=null){
                	for(Role role : roleList){
                        roleRights += role != null ? role.getRIGHTS()+"," : "";
                        roleNames += role!= null ? role.getROLE_NAME()+"," : "";
                	}
                	roleRights = roleRights.substring(0,roleRights.length()-1);
                	roleNames = roleNames.substring(0,roleNames.length()-1);
            	}
            	
                //避免每次拦截用户操作时查询数据库，以下将用户所属角色权限、用户权限限都存入session
                session.setAttribute(Const.SESSION_ROLE_RIGHTS, roleRights);        //将角色权限存入session
                session.setAttribute(Const.SESSION_USERNAME, user.getUSERNAME());    //放入用户名
                pd.put("USERNAME", user.getUSERNAME());
                /*pd.put("USERROLE", user.getRole().getROLE_NAME());*/
                pd.put("USERROLE", roleNames);
                pd.put("AVATAR", user.getAVATAR());
                pd.put("NAME", user.getNAME());
                pd.put("deptname", userPd.getString("deptname"));
                //获取用户头像
                PageData uPageData = new PageData();
                uPageData = sysUserService.getUserAvatarById(user.getUSER_ID());
                if (uPageData != null) {
                    if (uPageData.get("AVATAR") != null) {
                        pd.put("AVATAR", uPageData.get("AVATAR"));
                    }
                }
                List<Menu> allmenuList = new ArrayList<Menu>();
                if (null == session.getAttribute(Const.SESSION_allmenuList)) {
                    allmenuList = menuService.listAllMenu();
                    if (Tools.notEmpty(roleRights)) {
                        for(Role role : roleList){
                            for (Menu menu : allmenuList) {
                                if(!menu.isHasMenu()){
                                    menu.setHasMenu(RightsHelper.testRights(role.getRIGHTS(), menu.getMENU_ID()));
                                }
                                if (menu.isHasMenu()) {
                                    for (Menu sub :  menu.getSubMenu()) {
                                        if(!sub.isHasMenu()){
                                            sub.setHasMenu(RightsHelper.testRights(role.getRIGHTS(), sub.getMENU_ID()));
                                        }
                                    }
                                }
                            }
                        }
                        /*for (Menu menu : allmenuList) {
                        	//遍历roleList中每个role的roleRights,如果有一个testBit为true,setHasMenu为true
                        	boolean hasMenu = false;
                        	for(Role role : roleList){
                        		if(RightsHelper.testRights(role.getRIGHTS(), menu.getMENU_ID())){
                        			hasMenu = true;
                        		}
                        	}
                            menu.setHasMenu(hasMenu);
                            if (menu.isHasMenu()) {
                                List<Menu> subMenuList = menu.getSubMenu();
                                for (Menu sub : subMenuList) {
                                	//遍历roleList中每个role的roleRights,如果有一个testBit为true,setHasMenu为true
                                	boolean hasSubMenu = false;
                                	for(Role role : roleList){
                                		if(RightsHelper.testRights(role.getRIGHTS(), sub.getMENU_ID())){
                                			hasSubMenu = true;
                                		}
                                	}
                                    sub.setHasMenu(hasSubMenu);
                                }
                            }
                        }*/
                    }
                    session.setAttribute(Const.SESSION_allmenuList, allmenuList);            //菜单权限放入session中
                } else {
                    allmenuList = (List<Menu>) session.getAttribute(Const.SESSION_allmenuList);
                }

                //切换菜单=====
                List<Menu> menuList = new ArrayList<Menu>();
                //if(null == session.getAttribute(Const.SESSION_menuList) || ("yes".equals(pd.getString("changeMenu")))){
                if (null == session.getAttribute(Const.SESSION_menuList) || ("yes".equals(changeMenu))) {
                    List<Menu> menuList1 = new ArrayList<Menu>();
                    List<Menu> menuList2 = new ArrayList<Menu>();

                    //拆分菜单
                    for (int i = 0; i < allmenuList.size(); i++) {
                        Menu menu = allmenuList.get(i);
                        if ("1".equals(menu.getMENU_TYPE())) {
                            menuList1.add(menu);
                        } else {
                            menuList2.add(menu);
                        }
                    }

                    session.removeAttribute(Const.SESSION_menuList);
                    if ("2".equals(session.getAttribute("changeMenu"))) {
                        session.setAttribute(Const.SESSION_menuList, menuList1);
                        session.removeAttribute("changeMenu");
                        session.setAttribute("changeMenu", "1");
                        menuList = menuList1;
                    } else {
                        session.setAttribute(Const.SESSION_menuList, menuList2);
                        session.removeAttribute("changeMenu");
                        session.setAttribute("changeMenu", "2");
                        menuList = menuList2;
                    }
                } else {
                    menuList = (List<Menu>) session.getAttribute(Const.SESSION_menuList);
                }
                //切换菜单=====

                if (null == session.getAttribute(Const.SESSION_QX)) {
                    session.setAttribute(Const.SESSION_QX, this.getUQX(session));    //按钮权限放到session中
                }

                //FusionCharts 报表
                String strXML = "<graph caption='前12个月订单销量柱状图' xAxisName='月份' yAxisName='值' decimalPrecision='0' formatNumberScale='0'><set name='2013-05' value='4' color='AFD8F8'/><set name='2013-04' value='0' color='AFD8F8'/><set name='2013-03' value='0' color='AFD8F8'/><set name='2013-02' value='0' color='AFD8F8'/><set name='2013-01' value='0' color='AFD8F8'/><set name='2012-01' value='0' color='AFD8F8'/><set name='2012-11' value='0' color='AFD8F8'/><set name='2012-10' value='0' color='AFD8F8'/><set name='2012-09' value='0' color='AFD8F8'/><set name='2012-08' value='0' color='AFD8F8'/><set name='2012-07' value='0' color='AFD8F8'/><set name='2012-06' value='0' color='AFD8F8'/></graph>";
                mv.addObject("strXML", strXML);
                //FusionCharts 报表

                mv.setViewName("system/admin/index");
                mv.addObject("user", user);
                mv.addObject("menuList", menuList);
            } else {
                mv.setViewName("system/admin/login");//session失效后跳转登录页面
            }


        } catch (Exception e) {
            mv.setViewName("system/admin/login");
            logger.error(e.getMessage(), e);
        }
        pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 进入tab标签
     *
     * @return
     */
    @RequestMapping(value = "/tab")
    public String tab() {
        return "system/admin/tab";
    }

    /**
     * 进入首页后的默认页面
     *
     * @return
     */
    @RequestMapping(value = "/login_default")
    public String defaultPage() {
        return "system/admin/default";
    }

    /**
     * 用户注销
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/logout")
    public ModelAndView logout() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();

        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();

        session.removeAttribute(Const.SESSION_USER);
        session.removeAttribute(Const.SESSION_ROLE_RIGHTS);
        session.removeAttribute(Const.SESSION_allmenuList);
        session.removeAttribute(Const.SESSION_menuList);
        session.removeAttribute(Const.SESSION_QX);
        session.removeAttribute(Const.SESSION_userpds);
        session.removeAttribute(Const.SESSION_USERNAME);
        session.removeAttribute(Const.SESSION_USERROL);
        session.removeAttribute("changeMenu");

        //shiro销毁登录
        Subject subject = SecurityUtils.getSubject();
        subject.logout();

        pd = this.getPageData();
        String msg = pd.getString("msg");
        pd.put("msg", msg);

        pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); //读取系统名称
        mv.setViewName("system/admin/login");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 获取用户权限
     */
    public Map<String, String> getUQX(Session session) {
        PageData pd = new PageData();
        Map<String, String> map = new HashMap<String, String>();
        try {
            String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();
            pd.put(Const.SESSION_USERNAME, USERNAME);
            String ROLE_ID = sysUserService.findByUId(pd).get("ROLE_ID").toString();
            //-----  pd开始
            String roleIds = ROLE_ID;
            //如果有多个角色
        	if(roleIds!=""&&roleIds.contains(",")){
        		//取到menuList
        		List<Menu> allmenuList = new ArrayList<Menu>();
        		List<Menu> menuList = new ArrayList<Menu>();
        		if (null == session.getAttribute(Const.SESSION_allmenuList)) {
                    allmenuList = menuService.listAllMenu();
        		} else {
                    allmenuList = (List<Menu>) session.getAttribute(Const.SESSION_allmenuList);
                }
        		//所有角色比对menuList,重新生成ADD_QX,DEL_QX,EDIT_QX,DEL_QX放入session
        		String[] roles = roleIds.split(",");
        		BigInteger ADD_QX = new BigInteger("0");
        		BigInteger DEL_QX = new BigInteger("0");
        		BigInteger EDIT_QX = new BigInteger("0");
        		BigInteger CHA_QX = new BigInteger("0");
        		String addRights = "";
        		String delRights = "";
        		String editRights = "";
        		String chaRights = "";
        		/*for(Menu menu : allmenuList){
        			for(Menu subMenu : menu.getSubMenu()){
        				menuList.add(subMenu);
        			}
        			menuList.add(menu);
        		}*/
                for(String role : roles){
                    Role roleBean = roleService.getRoleById(role);
                    if(roleBean!=null){
                        if(!Tools.isEmpty(roleBean.getADD_QX()))
                        ADD_QX=ADD_QX==null?new BigInteger( roleBean.getADD_QX()):ADD_QX.or(new BigInteger( roleBean.getADD_QX()));
                        if(!Tools.isEmpty(roleBean.getDEL_QX()))
                        DEL_QX=DEL_QX==null?new BigInteger( roleBean.getDEL_QX()):DEL_QX.or(new BigInteger( roleBean.getDEL_QX()));
                        if(!Tools.isEmpty(roleBean.getEDIT_QX()))
                        EDIT_QX=EDIT_QX==null?new BigInteger( roleBean.getEDIT_QX()):EDIT_QX.or(new BigInteger( roleBean.getEDIT_QX()));
                        if(!Tools.isEmpty(roleBean.getCHA_QX()))
                        CHA_QX=CHA_QX==null?new BigInteger( roleBean.getCHA_QX()):CHA_QX.or(new BigInteger( roleBean.getCHA_QX()));

                    }
                }
        		/*for(String role : roles){
        			Role roleBean = roleService.getRoleById(role);
        			if(roleBean!=null){
        				addRights = roleBean.getADD_QX();
        				delRights = roleBean.getDEL_QX();
        				editRights = roleBean.getEDIT_QX();
        				chaRights = roleBean.getCHA_QX();
        				//比对menuList
        				for(Menu menu : menuList){
        					if(RightsHelper.testRights(addRights, menu.getMENU_ID())){
        						ADD_QX = ADD_QX.setBit(Integer.parseInt(menu.getMENU_ID()));
        					}
        					if(RightsHelper.testRights(delRights, menu.getMENU_ID())){
        						DEL_QX = DEL_QX.setBit(Integer.parseInt(menu.getMENU_ID()));
        					}
        					if(RightsHelper.testRights(editRights, menu.getMENU_ID())){
        						EDIT_QX = EDIT_QX.setBit(Integer.parseInt(menu.getMENU_ID()));
        					}
        					if(RightsHelper.testRights(chaRights, menu.getMENU_ID())){
        						CHA_QX = CHA_QX.setBit(Integer.parseInt(menu.getMENU_ID()));
        					}
        				}
        			}
        		}*/
        		map.put("adds", ADD_QX.toString());
                map.put("dels", DEL_QX.toString());
                map.put("edits", EDIT_QX.toString());
                map.put("chas", CHA_QX.toString());
                
                System.out.println(map.get("adds"));
        	}else{
                pd.put("ROLE_ID", ROLE_ID);
                pd = roleService.findObjectById(pd);
                map.put("adds", pd.getString("ADD_QX"));
                map.put("dels", pd.getString("DEL_QX"));
                map.put("edits", pd.getString("EDIT_QX"));
                map.put("chas", pd.getString("CHA_QX"));
        	}
            
            //-----   pd结束
            //-----  pd2开始
            PageData pd2 = new PageData();
            pd2.put(Const.SESSION_USERNAME, USERNAME);
            pd2.put("ROLE_ID", ROLE_ID);


            pd2 = roleService.findGLbyrid(pd2);
            if (null != pd2) {
                map.put("FX_QX", pd2.get("FX_QX").toString());
                map.put("FW_QX", pd2.get("FW_QX").toString());
                map.put("QX1", pd2.get("QX1").toString());
                map.put("QX2", pd2.get("QX2").toString());
                map.put("QX3", pd2.get("QX3").toString());
                map.put("QX4", pd2.get("QX4").toString());

                pd2.put("ROLE_ID", ROLE_ID);
                pd2 = roleService.findYHbyrid(pd2);
                map.put("C1", pd2.get("C1").toString());
                map.put("C2", pd2.get("C2").toString());
                map.put("C3", pd2.get("C3").toString());
                map.put("C4", pd2.get("C4").toString());
                map.put("Q1", pd2.get("Q1").toString());
                map.put("Q2", pd2.get("Q2").toString());
                map.put("Q3", pd2.get("Q3").toString());
                map.put("Q4", pd2.get("Q4").toString());
            }
            
            //-----  pd2结束


            //System.out.println(map);

            this.getRemortIP(USERNAME);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return map;
    }

}
