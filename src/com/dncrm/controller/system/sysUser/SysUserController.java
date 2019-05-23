package com.dncrm.controller.system.sysUser;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.Role;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.menu.MenuService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.*;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;

import net.sf.json.JSONObject;

import org.activiti.engine.identity.User;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.apache.commons.logging.Log;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 类名称：UserController 创建人：Simon 创建时间：2014年6月28日
 */
@Controller
@RequestMapping(value = "/sysUser")
public class SysUserController extends BaseController {

    @Resource(name = "sysUserService")
    private sysUserService sysUserService;
    @Resource(name = "roleService")
    private RoleService roleService;
    @Resource(name = "menuService")
    private MenuService menuService;
    @Resource(name = "departmentService")
    private DepartmentService departmentService;
    @Resource(name = "positionService")
    private PositionService positionService;

    /**
     * 保存用户
     */
    @RequestMapping(value = "/saveU")
    public ModelAndView saveU() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        pd.put("USER_ID", this.get32UUID()); // ID
        pd.put("RIGHTS", ""); // 权限
        pd.put("LAST_LOGIN", ""); // 最后登录时间
        pd.put("IP", ""); // IP
        pd.put("SKIN", "default"); // 默认皮肤
        pd.put("CREATE_TIME", DateUtil.getTime().toString());//创建时间

        pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd
                .getString("PASSWORD")).toString());

        if (null == sysUserService.findByUId(pd)) {
            sysUserService.saveU(pd);
            mv.addObject("msg", "success");
        } else {
            mv.addObject("msg", "failed");
        }
        mv.addObject("form", "userForm");
        mv.addObject("id", "AddUsers");
        mv.setViewName("save_result");
        //保存用户信息到activiti
        WorkFlow workFlow = new WorkFlow();
        User user = new UserEntity();
        user.setId(pd.getString("USER_ID"));
        user.setPassword(pd.getString("PASSWORD"));
        user.setEmail(pd.getString("EMAIL"));
        workFlow.getIdentityService().saveUser(user);
        //更新membership
        workFlow.getIdentityService().createMembership(pd.getString("USER_ID"),pd.getString("ROLE_ID"));
        return mv;
    }

    /**
     * 判断用户名是否存在
     */
    @RequestMapping(value = "/hasU")
    public void hasU(PrintWriter out) {
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd = sysUserService.findByUId(pd);
            if (pd!=null&&pd.get("USERNAME")!= null) {
                out.write("error");
            } else {
                out.write("success");
            }
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }

    /**
     * 判断邮箱是否存在
     */
    @RequestMapping(value = "/hasE")
    public void hasE(PrintWriter out) {
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            if (sysUserService.findByUE(pd) != null) {
                out.write("error");
            } else {
                out.write("success");
            }
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }

    /**
     * 判断编码是否存在
     */
    @RequestMapping(value = "/hasN")
    public void hasN(PrintWriter out) {
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            if (sysUserService.findByUN(pd) != null) {
                out.write("error");
            } else {
                out.write("success");
            }
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }

    /**
     * 修改用户
     */
    @RequestMapping(value = "/editU")
    public ModelAndView editU() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        if (pd.getString("PASSWORD") != null
                && !"".equals(pd.getString("PASSWORD"))) {
            pd.put("PASSWORD", new SimpleHash("SHA-1",
                    pd.getString("USERNAME"), pd.getString("PASSWORD"))
                    .toString());
        }
        
        pd.put("ROLE_ID", pd.get("ROLE_ID_SELECTED").toString());
        
        sysUserService.editU(pd);
        mv.addObject("msg", "success");
        mv.addObject("id", "EditUsers");
        mv.addObject("form", "userForm");
        mv.setViewName("save_result");

        //保存用户信息到activiti
        WorkFlow workFlow = new WorkFlow();
        //先删除用户信息
        workFlow.getIdentityService().deleteUser(pd.getString("USER_ID"));
        //再保存用户信息
        User user = new UserEntity();
        user.setId(pd.getString("USER_ID"));
        user.setPassword(pd.getString("PASSWORD"));
        user.setEmail(pd.getString("EMAIL"));
        workFlow.getIdentityService().saveUser(user);

        //更新membership
        /*2017_2_20更改,编辑多个角色时逐个更新act_id_membership*/
        if(pd.getString("ROLE_ID").contains(",")){
        	for(String role_id : pd.getString("ROLE_ID").split(",")){
        		workFlow.getIdentityService().createMembership(pd.getString("USER_ID"),role_id);
        	}
        }else{
        	workFlow.getIdentityService().createMembership(pd.getString("USER_ID"),pd.getString("ROLE_ID"));
        }
        /*workFlow.getIdentityService().createMembership(pd.getString("USER_ID"),pd.getString("ROLE_ID"));*/
        return mv;
    }

    /**
     * 去修改用户页面 Admin
     */
    @RequestMapping(value = "/goEditU")
    public ModelAndView goEditU() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        // 顶部修改个人资料
        String fx = pd.getString("fx");

        // System.out.println(fx);

        if ("head".equals(fx)) {
            mv.addObject("fx", "head");
        } else {
            mv.addObject("fx", "user");
        }
        try {
            List<Role> roleList = roleService.listAllERRoles(); // 列出所有二级角色
            pd = sysUserService.findByUiId(pd); // 根据ID读取
            PageData pspd = new PageData();

            if(pd.getString("POSITION_ID")!=null&&!Tools.isEmpty(pd.getString("POSITION_ID"))){
                pspd.put("id",pd.getString("POSITION_ID"));
                pspd=positionService.getPositionById(pspd);
                if (pspd != null && pspd.get("name")!=null){
                    pd.put("POSITION",pspd.getString("name")+"("+pspd.get("deptname")+")");
                }
            }
    		List<String> roleIdList = new ArrayList<String>();
            String roleIds = sysUserService.findRoleIdByUserId(pd.getString("USER_ID"));
            if(roleIds != null) {
            	if(roleIds.lastIndexOf(",")>-1){
    				for(String id: roleIds.split(",")){
    					roleIdList.add(id);
    				}
    			}else{
    				roleIdList.add(roleIds);
    			}
            }
            
            mv.setViewName("system/sysUser/user_edit");
            mv.addObject("msg", "editU");
            mv.addObject("pd", pd);
            mv.addObject("roleList", roleList);
            mv.addObject("roleIdList", roleIdList);

            //岗位
            List<PageData> positions = departmentService.listAllDepartmentsAndPositions();
            if (positions.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                HashMap skins = new HashMap();
                skins.put("department","parentSkin");
                skins.put("position","leafSkin");
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin(positions,skins);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("positions", node);
            } else {
                mv.addObject("positions", positions);
            }
        }catch (Exception e){
            logger.error(e.toString(), e);
        }

        return mv;
    }
    /**
     * 去修改用户页面 个人用户
     */
    @RequestMapping(value = "/goEditMyInfo")
    public ModelAndView goEditMyInfo() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        // 顶部修改个人资料
        try {
            pd = sysUserService.findByUiId(pd); // 根据ID读取
            mv.setViewName("system/sysUser/user_myinfo_edit");
            mv.addObject("msg", "editMyInfo");
            mv.addObject("pd", pd);
        }catch (Exception e){
            logger.error(e.toString(), e);
        }

        return mv;
    }
    /**
     * 修改个人信息
     */
    @RequestMapping(value = "/editMyInfo")
    public ModelAndView editMyInfo() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        if (pd.getString("PASSWORD") != null
                && !"".equals(pd.getString("PASSWORD"))) {
            pd.put("PASSWORD", new SimpleHash("SHA-1",
                    pd.getString("USERNAME"), pd.getString("PASSWORD"))
                    .toString());
        }
        sysUserService.editU(pd);
        mv.addObject("msg", "success");
        mv.addObject("id", "EditUsers");
        mv.addObject("form", "userForm");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 去新增用户页面
     */
    @RequestMapping(value = "/goAddU")
    public ModelAndView goAddU() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<Role> roleList;

        roleList = roleService.listAllERRoles(); // 列出所有二级角色

        mv.setViewName("system/sysUser/user_edit");
        mv.addObject("msg", "saveU");
        mv.addObject("pd", pd);
        mv.addObject("roleList", roleList);

        //岗位
        List<PageData> positions = departmentService.listAllDepartmentsAndPositions();
        if (positions.size() > 0) {
            //构建多叉数
            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            MultipleTree tree = new MultipleTree();
//                dataList = ConvertPageDataToList.makeIncludeNodeType(positions);
            HashMap skins = new HashMap();
            skins.put("department","parentSkin");
            skins.put("position","leafSkin");
            dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin(positions,skins);
            Node node = tree.makeTreeWithOderNo(dataList, 1);
            mv.addObject("positions", node);
        } else {
            mv.addObject("positions", positions);
        }
        return mv;
    }

    /**
     * 显示用户列表(用户组)
     */
    @RequestMapping(value = "/listUsers")
    public ModelAndView listUsers(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        String USERNAME = pd.getString("USERNAME");

        if (null != USERNAME && !"".equals(USERNAME)) {
            USERNAME = USERNAME.trim();
            pd.put("USERNAME", USERNAME);
        }

        String lastLoginStart = pd.getString("lastLoginStart");
        String lastLoginEnd = pd.getString("lastLoginEnd");

        if (lastLoginStart != null && !"".equals(lastLoginStart)) {
            lastLoginStart = lastLoginStart + " 00:00:00";
            pd.put("lastLoginStart", lastLoginStart);
        }
        if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
            lastLoginEnd = lastLoginEnd + " 00:00:00";
            pd.put("lastLoginEnd", lastLoginEnd);
        }
        page.setPd(pd);
        List<PageData> userList = sysUserService.listPdPageUser(page); // 列出用户列表
        List<Role> roleList = roleService.listAllERRoles(); // 列出所有二级角色
        mv.setViewName("system/sysUser/user_list");
        mv.addObject("userList", userList);
        mv.addObject("roleList", roleList);
        mv.addObject("pd", pd);
        mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        return mv;
    }

    /**
     * 显示用户列表(tab方式)
     */
    @RequestMapping(value = "/listtabUsers")
    public ModelAndView listtabUsers(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> userList = sysUserService.listAllUser(pd); // 列出用户列表
        mv.setViewName("system/sysUser/user_tb_list");
        mv.addObject("userList", userList);
        mv.addObject("pd", pd);
        mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        return mv;
    }

    /**
     * 删除用户
     */
    @RequestMapping(value = "/deleteU")
    public void deleteU(PrintWriter out) {
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            PageData newpd = new PageData();
            newpd.put("USER_ID",pd.getString("USER_ID"));
            PageData user = sysUserService.findByUiId(newpd);

            sysUserService.deleteU(pd);
            //删除Activiti的用户信息
            WorkFlow workFlow = new WorkFlow();
            workFlow.getIdentityService().deleteUser(pd.getString("USER_ID"));

            //更新membership
            workFlow.getIdentityService().deleteMembership(user.getString("ROLE_ID"),user.getString("USER_ID"));
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAllU")
    @ResponseBody
    public Object deleteAllU() {
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();
            String USER_IDS = pd.getString("USER_IDS");

            if (null != USER_IDS && !"".equals(USER_IDS)) {
                String ArrayUSER_IDS[] = USER_IDS.split(",");
                for (int i = 0; i < ArrayUSER_IDS.length; i++) {
                    //删除Activiti的用户信息
                    WorkFlow workFlow = new WorkFlow();
                    workFlow.getIdentityService().deleteUser(ArrayUSER_IDS[i]);
                    PageData newpd = new PageData();
                    newpd.put("USER_ID",ArrayUSER_IDS[i]);
                    PageData user = sysUserService.findByUiId(newpd);
                    //更新membership
                    workFlow.getIdentityService().deleteMembership(user.getString("ROLE_ID"),user.getString("USER_ID"));
                    //删除同步log

                }
                sysUserService.deleteAllU(ArrayUSER_IDS);
                map.put("msg", "success");
            } else {
                map.put("msg", "failed");
            }

            pdList.add(pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return JSONObject.fromObject(map);
    }

    // ===================================================================================================

    /*
     * 导出用户信息到EXCEL
     *
     * @return
     */
    @RequestMapping(value = "/excel")
    public ModelAndView exportExcel() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {

            // 检索条件===
            String USERNAME = pd.getString("USERNAME");
            if (null != USERNAME && !"".equals(USERNAME)) {
                USERNAME = USERNAME.trim();
                pd.put("USERNAME", USERNAME);
            }
            String lastLoginStart = pd.getString("lastLoginStart");
            String lastLoginEnd = pd.getString("lastLoginEnd");
            if (lastLoginStart != null && !"".equals(lastLoginStart)) {
                lastLoginStart = lastLoginStart + " 00:00:00";
                pd.put("lastLoginStart", lastLoginStart);
            }
            if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
                lastLoginEnd = lastLoginEnd + " 00:00:00";
                pd.put("lastLoginEnd", lastLoginEnd);
            }
            // 检索条件===

            Map<String, Object> dataMap = new HashMap<String, Object>();
            List<String> titles = new ArrayList<String>();

            titles.add("用户名"); // 1
            titles.add("编号"); // 2
            titles.add("姓名"); // 3
            titles.add("职位"); // 4
            titles.add("手机"); // 5
            titles.add("邮箱"); // 6
            titles.add("最近登录"); // 7
            titles.add("上次登录IP"); // 8

            dataMap.put("titles", titles);

            List<PageData> userList = sysUserService.listAllUser(pd);
            List<PageData> varList = new ArrayList<PageData>();
            for (int i = 0; i < userList.size(); i++) {
                PageData vpd = new PageData();
                vpd.put("var1", userList.get(i).getString("USERNAME")); // 1
                vpd.put("var2", userList.get(i).getString("NUMBER")); // 2
                vpd.put("var3", userList.get(i).getString("NAME")); // 3
                vpd.put("var4", userList.get(i).getString("ROLE_NAME")); // 4
                vpd.put("var5", userList.get(i).getString("PHONE")); // 5
                vpd.put("var6", userList.get(i).getString("EMAIL")); // 6
                vpd.put("var7", userList.get(i).getString("LAST_LOGIN")); // 7
                vpd.put("var8", userList.get(i).getString("IP")); // 8
                varList.add(vpd);
            }

            dataMap.put("varList", varList);

            ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作

            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 打开上传EXCEL页面
     */
    @RequestMapping(value = "/goUploadExcel")
    public ModelAndView goUploadExcel() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("system/sysUser/uploadexcel");
        return mv;
    }

    /**
     * 下载模版
     */
    @RequestMapping(value = "/downExcel")
    public void downExcel(HttpServletResponse response) throws Exception {

        FileDownload.fileDownload(response, PathUtil.getClasspath()
                + Const.FILEPATHFILE + "Users.xls", "Users.xls");

    }

    /**
     * 从EXCEL导入到数据库
     */
    @RequestMapping(value = "/readExcel")
    public ModelAndView readExcel(
            @RequestParam(value = "excel", required = false) MultipartFile file)
            throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();

        if (null != file && !file.isEmpty()) {
            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传

            List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,
                    fileName, 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
            // 2:从第3行开始；0:从第A列开始；0:第0个sheet

			/* 存入数据库操作====================================== */
            pd.put("RIGHTS", ""); // 权限
            pd.put("LAST_LOGIN", ""); // 最后登录时间
            pd.put("IP", ""); // IP
            pd.put("STATUS", "0"); // 状态
            pd.put("SKIN", "default"); // 默认皮肤

            List<Role> roleList = roleService.listAllERRoles(); // 列出所有二级角色

            pd.put("ROLE_ID", roleList.get(0).getROLE_ID()); // 设置角色ID为随便第一个
            /**
             * var0 :编号 var1 :姓名 var2 :手机 var3 :邮箱 var4 :备注
             */
            for (int i = 0; i < listPd.size(); i++) {
                pd.put("USER_ID", this.get32UUID()); // ID
                pd.put("NAME", listPd.get(i).getString("var1")); // 姓名

                String USERNAME = GetPinyin.getPingYin(listPd.get(i).getString(
                        "var1")); // 根据姓名汉字生成全拼
                pd.put("USERNAME", USERNAME);
                if (sysUserService.findByUId(pd) != null) { // 判断用户名是否重复
                    USERNAME = GetPinyin.getPingYin(listPd.get(i).getString(
                            "var1"))
                            + Tools.getRandomNum();
                    pd.put("USERNAME", USERNAME);
                }
                pd.put("BZ", listPd.get(i).getString("var4")); // 备注
                if (Tools.checkEmail(listPd.get(i).getString("var3"))) { // 邮箱格式不对就跳过
                    pd.put("EMAIL", listPd.get(i).getString("var3"));
                    if (sysUserService.findByUE(pd) != null) { // 邮箱已存在就跳过
                        continue;
                    }
                } else {
                    continue;
                }

                pd.put("NUMBER", listPd.get(i).getString("var0")); // 编号已存在就跳过
                pd.put("PHONE", listPd.get(i).getString("var2")); // 手机号

                pd.put("PASSWORD", new SimpleHash("SHA-1", USERNAME, "123")
                        .toString()); // 默认密码123
                if (sysUserService.findByUN(pd) != null) {
                    continue;
                }
                sysUserService.saveU(pd);
            }
            /* 存入数据库操作====================================== */

            mv.addObject("msg", "success");
        }

        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 去修改用户头像页面
     */
    @RequestMapping(value = "/goEditUserProfile")
    public ModelAndView goEditUserProfile() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        // 顶部修改个人资料
        String fx = pd.getString("fx");

        // System.out.println(fx);

        if ("head".equals(fx)) {
            mv.addObject("fx", "head");
        } else {
            mv.addObject("fx", "user");
        }

        List<Role> roleList = roleService.listAllERRoles(); // 列出所有二级角色
        pd = sysUserService.findByUiId(pd); // 根据ID读取
        mv.setViewName("system/sysUser/user_profile_edit");
        mv.addObject("msg", "editUserProfile");
        mv.addObject("pd", pd);
        mv.addObject("roleList", roleList);
        return mv;
    }

    /**
     * 更新用户头像
     *
     * @param
     */
    @RequestMapping("/updateAvatar")
    @ResponseBody
    public Object updateAvatar() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Page page = this.getPage();
            page.setPd(pd);
            sysUserService.updateAvatar(pd);
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "failed");
        }
        return JSONObject.fromObject(map);
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format,
                true));
    }

    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
	/* ===============================权限================================== */
}
