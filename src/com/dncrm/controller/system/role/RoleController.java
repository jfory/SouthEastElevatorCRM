package com.dncrm.controller.system.role;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.Menu;
import com.dncrm.entity.system.Role;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.menu.MenuService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.*;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 * 类名称：RoleController
 * 创建人：Simon
 * 创建时间：2014年6月30日
 */
@Controller
@RequestMapping(value = "/role")
public class RoleController extends BaseController {

    @Resource(name = "menuService")
    private MenuService menuService;
    @Resource(name = "roleService")
    private RoleService roleService;
    @Resource(name="sysUserService")
    private sysUserService sysUserService;

    /**
     * 权限(增删改查)
     */
    @RequestMapping(value = "/qx")
    public ModelAndView qx() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String msg = pd.getString("msg");
            roleService.updateQx(msg, pd);

            mv.setViewName("save_result");
            mv.addObject("msg", "success");
            mv.addObject("form", "RoleForm");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * K权限
     */
    @RequestMapping(value = "/kfqx")
    public ModelAndView kfqx() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String msg = pd.getString("msg");
            roleService.updateKFQx(msg, pd);

            mv.setViewName("save_result");
            mv.addObject("msg", "success");
            mv.addObject("id", "EditRights");
            mv.addObject("form", "RoleForm");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * c权限
     */
    @RequestMapping(value = "/gysqxc")
    public ModelAndView gysqxc() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String msg = pd.getString("msg");
            roleService.gysqxc(msg, pd);

            mv.setViewName("save_result");
            mv.addObject("msg", "success");
            mv.addObject("form", "RoleForm");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 列表
     */
    @RequestMapping
    public ModelAndView list(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        String roleId = pd.getString("ROLE_ID");
        if (roleId == null || "".equals(roleId)) {
            pd.put("ROLE_ID", "1");
        }
        List<Role> roleList = roleService.listAllRoles();                //列出所有部门
        List<Role> roleList_z = roleService.listAllRolesByPId(pd);        //列出此部门的所有下级

        List<PageData> kefuqxlist = roleService.listAllkefu(pd);        //管理权限列表
        List<PageData> gysqxlist = roleService.listAllGysQX(pd);        //用户权限列表
        pd = roleService.findObjectById(pd);                            //取得点击部门
        mv.addObject("pd", pd);
        mv.addObject("kefuqxlist", kefuqxlist);
        mv.addObject("gysqxlist", gysqxlist);
        mv.addObject("roleList", roleList);
        mv.addObject("roleList_z", roleList_z);
        mv.setViewName("system/role/role_list");
        mv.addObject(Const.SESSION_QX, this.getHC());    //按钮权限

        return mv;
    }

    /**
     * 新增页面
     */
    @RequestMapping(value = "/toAdd")
    public ModelAndView toAdd(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            mv.setViewName("system/role/role_add");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存新增信息
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            String parent_id = pd.getString("PARENT_ID");        //父类角色id
            pd.put("ROLE_ID", parent_id);
            if ("0".equals(parent_id)) {
                pd.put("RIGHTS", "");
            } else {
                String rights = roleService.findObjectById(pd).getString("RIGHTS");
                pd.put("RIGHTS", (null == rights) ? "" : rights);
            }

            pd.put("QX_ID", "");

            String UUID = this.get32UUID();

            pd.put("GL_ID", UUID);
            pd.put("FX_QX", 0);                //发信权限
            pd.put("FW_QX", 0);                //服务权限
            pd.put("QX1", 0);                //操作权限
            pd.put("QX2", 0);                //产品权限
            pd.put("QX3", 0);                //预留权限
            pd.put("QX4", 0);                //预留权限
            roleService.saveKeFu(pd);        //保存到K权限表

            pd.put("U_ID", UUID);
            pd.put("C1", 0);                //每日发信数量
            pd.put("C2", 0);
            pd.put("C3", 0);
            pd.put("C4", 0);
            pd.put("Q1", 0);                //权限1
            pd.put("Q2", 0);                //权限2
            pd.put("Q3", 0);
            pd.put("Q4", 0);
            roleService.saveGYSQX(pd);        //保存到G权限表
            pd.put("QX_ID", UUID);

            pd.put("ROLE_ID", UUID);
            pd.put("ADD_QX", "0");
            pd.put("DEL_QX", "0");
            pd.put("EDIT_QX", "0");
            pd.put("CHA_QX", "0");
            roleService.add(pd);
            mv.addObject("msg", "success");
            //保存activiti的group信息
            WorkFlow workFlow = new WorkFlow();
            Group group = new GroupEntity();
            group.setId(pd.getString("ROLE_ID"));
            group.setName(pd.getString("ROLE_NAME"));
            group.setType("assignment");
            workFlow.getIdentityService().saveGroup(group);
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }
        mv.addObject("form", "RoleForm");
        mv.addObject("id", "AddRole");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 请求编辑
     */
    @RequestMapping(value = "/toEdit")
    public ModelAndView toEdit(String ROLE_ID) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd.put("ROLE_ID", ROLE_ID);
            pd = roleService.findObjectById(pd);

            mv.setViewName("system/role/role_edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 请求编辑角色成员
     */
    @RequestMapping(value = "/toEditRoleUser")
    public ModelAndView toEditRoleUser(String ROLE_ID) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd.put("ROLE_ID", ROLE_ID);
            List<PageData> checkUserList = roleService.listAllUserByRid(pd);
            List<PageData> userList = sysUserService.findAllUser();
            String jsonStr = "";
            int count = 0;
            for(PageData userPd:userList){
            	jsonStr +="{\"id\":\""+userPd.get("USER_ID").toString()+"\",\"name\":\""+userPd.get("NAME")+"\",\"pId\":\"1\",";
            	for(PageData checkUserPd : checkUserList){
            		if(checkUserPd.get("USER_ID").toString().equals(userPd.get("USER_ID").toString())){
            			count++;
            			break;
            		}
            	}
            	if(count==0){
            		jsonStr+="\"checked\":\"false\"},";
            	}else{
            		jsonStr+="\"checked\":\"true\"},";
            		count=0;
            	}
            }
            jsonStr = "["+jsonStr.substring(0,jsonStr.length()-1)+"]";
            jsonStr = "{\"id\":\"0\",\"name\":\"人员\",\"pId\":\"0\",\"children\":"+jsonStr+",\"nocheck\":\"true\"}";
            JSONObject users = JSONObject.fromObject(jsonStr);
            mv.setViewName("system/role/role_edit_user");
            mv.addObject("pd", pd);
            mv.addObject("users", users);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     *重新获取树json 
     */
    @RequestMapping(value="refreshTreeJson")
    @ResponseBody
    public Object refreshTreeJson(){
    	PageData pd;
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		pd = this.getPageData();
            List<PageData> checkUserList = roleService.listAllUserByRid(pd);
            List<PageData> userList = sysUserService.findAllUser();
            String jsonStr = "";
            int count = 0;
            for(PageData userPd:userList){
            	jsonStr +="{\"id\":\""+userPd.get("USER_ID").toString()+"\",\"name\":\""+userPd.get("NAME")+"\",\"pId\":\"1\",";
            	for(PageData checkUserPd : checkUserList){
            		if(checkUserPd.get("USER_ID").toString().equals(userPd.get("USER_ID").toString())){
            			count++;
            			break;
            		}
            	}
            	if(count==0){
            		jsonStr+="\"checked\":\"false\"},";
            	}else{
            		jsonStr+="\"checked\":\"true\"},";
            		count=0;
            	}
            }
            jsonStr = "["+jsonStr.substring(0,jsonStr.length()-1)+"]";
            jsonStr = "{\"id\":\"0\",\"name\":\"人员\",\"pId\":\"0\",\"children\":"+jsonStr+",\"nocheck\":\"true\"}";
            //JSONObject users = JSONObject.fromObject(jsonStr);
            map.put("users", jsonStr);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }

    /**
     * 编辑(只修改名字)
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd = roleService.edit(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }

        mv.addObject("form", "RoleForm");
        mv.addObject("id", "EditRole");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 编辑(修改角色成员)
     */
    @RequestMapping(value = "/editRoleUser")
    public ModelAndView editRoleUser(
    		@RequestParam String selectIds,
    		@RequestParam String disselectIds
    		) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	String roleId = "";
        	String act_role = pd.get("ROLE_ID").toString();
			WorkFlow workFlow = new WorkFlow();
        	if(selectIds!=""&&selectIds!=null){
            	String[] selectId = selectIds.split(",");
            	for(String i :selectId){
            		pd.put("USER_ID", i);
                	PageData rolePd = sysUserService.findByUiId(pd);
                	if(rolePd!=null){
                		roleId = rolePd.get("ROLE_ID").toString();
                    	/*if(!roleId.contains(pd.get("ROLE_ID").toString())){
                    		roleId = roleId.equals("")?roleId+pd.get("ROLE_ID").toString():roleId+","+pd.get("ROLE_ID").toString();
                    		pd.put("ROLE_ID", roleId);
                    	}*/
                		if(roleId.equals("")){
                			pd.put("ROLE_ID", pd.get("ROLE_ID").toString());
                		}else{
                    		for(String role : roleId.split(",")){
                    			if(!role.equals(pd.get("ROLE_ID").toString())){
                    				roleId = role+","+pd.get("ROLE_ID").toString();
                            		pd.put("ROLE_ID", roleId);
                    			}
                    		}
                		}
                	}
            		//选中
            		sysUserService.updateUserRoleByUserIds(pd);
            		
            		//更新activiti
        			//向act_id_membership表插入数据
        			workFlow.identityService.createMembership(i, act_role);
            	}
        	}
        	if(disselectIds!=""&&disselectIds!=null){
            	String[] disselectId = disselectIds.split(",");
            	for(String j :disselectId){
            		pd.put("USER_ID", j);
            		PageData rolePd = sysUserService.findByUiId(pd);
                	if(rolePd!=null){
                		roleId = rolePd.get("ROLE_ID").toString();
                    	/*if(roleId.contains(pd.get("ROLE_ID").toString())){
                    		roleId = roleId.replace(pd.get("ROLE_ID").toString()+",", "");
                    		roleId = roleId.replace(pd.get("ROLE_ID").toString(), "");
                    		pd.put("ROLE_ID", roleId);
                    	}*/
                		if(roleId.equals("")){
                			pd.put("ROLE_ID", roleId);
                		}else{
                    		for(String role : roleId.split(",")){
                    			if(role.equals(pd.get("ROLE_ID").toString())){
                    				roleId = roleId.replace(","+pd.get("ROLE_ID").toString()+",", "");
                    				roleId = roleId.replace(","+pd.get("ROLE_ID").toString(), "");
                    				roleId = roleId.replace(pd.get("ROLE_ID").toString()+",", "");
                            		roleId = roleId.replace(pd.get("ROLE_ID").toString(), "");
                            		pd.put("ROLE_ID", roleId);
                    			}
                    		}
                		}
                	}
            		//取消选中
            		/*sysUserService.updateUserRoleByChange(pd);*/
            		sysUserService.updateUserRoleByUserIds(pd);
            		
            		//更新activiti
        			//向act_id_membership表插入数据
        			workFlow.identityService.deleteMembership(j, act_role);
            	}
        	}
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }

        mv.addObject("form", "RoleForm");
        mv.addObject("id", "EditRoleUser");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 请求角色菜单授权页面
     */
    @RequestMapping(value = "/auth")
    public String auth(@RequestParam String ROLE_ID, Model model) throws Exception {

        try {
            List<Menu> menuList = menuService.listAllMenu();
            Role role = roleService.getRoleById(ROLE_ID);
            String roleRights = role.getRIGHTS();
            if (Tools.notEmpty(roleRights)) {
                for (Menu menu : menuList) {
                    menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMENU_ID()));
                    //if (menu.isHasMenu()) {
                        List<Menu> subMenuList = menu.getSubMenu();
                        for (Menu sub : subMenuList) {
                            sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMENU_ID()));
                            
                            List<Menu> operateMenu = new ArrayList<Menu>();
                            
                            Menu add_qx = new Menu();
                            add_qx.setMENU_NAME("增加");
                            add_qx.setMENU_ID("add_qx");
                            add_qx.setMENU_ORDER("1");
                            add_qx.setHasMenu(RightsHelper.testRights(role.getADD_QX(), sub.getMENU_ID()));
                            operateMenu.add(add_qx);
                            Menu del_qx = new Menu();
                            del_qx.setMENU_NAME("删除");
                            del_qx.setMENU_ID("del_qx");
                            del_qx.setMENU_ORDER("2");
                            del_qx.setHasMenu(RightsHelper.testRights(role.getDEL_QX(), sub.getMENU_ID()));
                            operateMenu.add(del_qx);
                            Menu edit_qx = new Menu();
                            edit_qx.setMENU_NAME("修改");
                            edit_qx.setMENU_ID("edit_qx");
                            edit_qx.setMENU_ORDER("3");
                            edit_qx.setHasMenu(RightsHelper.testRights(role.getEDIT_QX(), sub.getMENU_ID()));
                            operateMenu.add(edit_qx);
                            Menu cha_qx = new Menu();
                            cha_qx.setMENU_NAME("查看");
                            cha_qx.setMENU_ID("cha_qx");
                            cha_qx.setMENU_ORDER("4");
                            cha_qx.setHasMenu(RightsHelper.testRights(role.getCHA_QX(), sub.getMENU_ID()));
                            operateMenu.add(cha_qx);
                            
                            sub.setSubMenu(operateMenu);
                        }
                    //}
                }
            }else{
	        	for (Menu menu : menuList) {
		        	menu.setHasMenu(false);
		        	List<Menu> subMenuList = menu.getSubMenu();
		        	for (Menu sub : subMenuList) {
		                sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMENU_ID()));
		                
		                List<Menu> operateMenu = new ArrayList<Menu>();
		                
		                Menu add_qx = new Menu();
		                add_qx.setMENU_NAME("增加");
		                add_qx.setMENU_ID("add_qx");
		                add_qx.setMENU_ORDER("1");
		                add_qx.setHasMenu(false);
		                operateMenu.add(add_qx);
		                Menu del_qx = new Menu();
		                del_qx.setMENU_NAME("删除");
		                del_qx.setMENU_ID("del_qx");
		                del_qx.setMENU_ORDER("2");
		                del_qx.setHasMenu(false);
		                operateMenu.add(del_qx);
		                Menu edit_qx = new Menu();
		                edit_qx.setMENU_NAME("修改");
		                edit_qx.setMENU_ID("edit_qx");
		                edit_qx.setMENU_ORDER("3");
		                edit_qx.setHasMenu(false);
		                operateMenu.add(edit_qx);
		                Menu cha_qx = new Menu();
		                cha_qx.setMENU_NAME("查看");
		                cha_qx.setMENU_ID("cha_qx");
		                cha_qx.setMENU_ORDER("4");
		                cha_qx.setHasMenu(false);
		                operateMenu.add(cha_qx);
		                
		                sub.setSubMenu(operateMenu);
		        		}
	        	}
            }
            JSONArray arr = JSONArray.fromObject(menuList);
            String json = arr.toString();
            json = json.replaceAll("MENU_ID", "id").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
            model.addAttribute("zTreeNodes", json);
            model.addAttribute("roleId", ROLE_ID);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

        return "authorization";
    }

    /**
     * 请求角色按钮授权页面
     */
    @RequestMapping(value = "/button")
    public ModelAndView button(@RequestParam String ROLE_ID, @RequestParam String msg, Model model) throws Exception {
        ModelAndView mv = this.getModelAndView();
        try {
            List<Menu> menuList = menuService.listAllMenu();
            Role role = roleService.getRoleById(ROLE_ID);

            String roleRights = "";
            if ("add_qx".equals(msg)) {
                roleRights = role.getADD_QX();
            } else if ("del_qx".equals(msg)) {
                roleRights = role.getDEL_QX();
            } else if ("edit_qx".equals(msg)) {
                roleRights = role.getEDIT_QX();
            } else if ("cha_qx".equals(msg)) {
                roleRights = role.getCHA_QX();
            }

            if (Tools.notEmpty(roleRights)) {
                for (Menu menu : menuList) {
                    menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMENU_ID()));
                    if (menu.isHasMenu()) {
                        List<Menu> subMenuList = menu.getSubMenu();
                        for (Menu sub : subMenuList) {
                            sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMENU_ID()));
                        }
                    }
                }
            }
            JSONArray arr = JSONArray.fromObject(menuList);
            String json = arr.toString();
            //System.out.println(json);
            json = json.replaceAll("MENU_ID", "id").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
            mv.addObject("zTreeNodes", json);
            mv.addObject("roleId", ROLE_ID);
            mv.addObject("msg", msg);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        mv.setViewName("system/role/role_button");
        return mv;
    }

    /**
     * 保存角色菜单权限
     */
    @RequestMapping(value = "/auth/save")
    public void saveAuth(@RequestParam String ROLE_ID, @RequestParam String menuIds,@RequestParam String jsonStr, PrintWriter out) throws Exception {
        PageData pd = new PageData();
        try {
            if (null != menuIds && !"".equals(menuIds.trim())) {
                /*BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
                Role role = roleService.getRoleById(ROLE_ID);
                role.setRIGHTS(rights.toString());
                roleService.updateRoleRights(role);
                pd.put("rights", rights.toString());*/
            	String save_menuIds="";
            	String save_add_qx="";
            	String save_del_qx="";
            	String save_edit_qx="";
            	String save_cha_qx="";
            	JSONArray jsonArray = JSONArray.fromObject(jsonStr);
            	List<Map<String,Object>> mapListJson = (List)jsonArray;
                for (int i = 0; i < mapListJson.size(); i++) {
	                Map<String,Object> map=mapListJson.get(i);
	                save_menuIds+=map.get("menuId")+",";
	                if(map.get("add_qx")=="true"||"true".equals(map.get("add_qx"))){
	                	save_add_qx+=map.get("menuId")+","+map.get("pId")+",";
	                }
	                if(map.get("del_qx")=="true"||"true".equals(map.get("del_qx"))){
	                	save_del_qx+=map.get("menuId")+","+map.get("pId")+",";
	                }
	                if(map.get("edit_qx")=="true"||"true".equals(map.get("edit_qx"))){
	                	save_edit_qx+=map.get("menuId")+","+map.get("pId")+",";
	                }
	                if(map.get("cha_qx")=="true"||"true".equals(map.get("cha_qx"))){
	                	save_cha_qx+=map.get("menuId")+","+map.get("pId")+",";
	                }
                }
                BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
                BigInteger add_qx = RightsHelper.sumRights(Tools.str2StrArray(save_add_qx.substring(0,save_add_qx.length()-1)));
                BigInteger del_qx = RightsHelper.sumRights(Tools.str2StrArray(save_del_qx.substring(0,save_del_qx.length()-1)));
                BigInteger edit_qx = RightsHelper.sumRights(Tools.str2StrArray(save_edit_qx.substring(0,save_edit_qx.length()-1)));
                BigInteger cha_qx = RightsHelper.sumRights(Tools.str2StrArray(save_cha_qx.substring(0,save_cha_qx.length()-1)));
                pd.put("ROLE_ID", ROLE_ID);
                pd.put("RIGHTS", rights.toString());
                pd.put("ADD_QX", add_qx.toString());
                pd.put("DEL_QX", del_qx.toString());
                pd.put("EDIT_QX", edit_qx.toString());
                pd.put("CHA_QX", cha_qx.toString());
                roleService.updateQxByMenu(pd);
            } else {
                /*Role role = new Role();
                role.setRIGHTS("");
                role.setROLE_ID(ROLE_ID);
                roleService.updateRoleRights(role);
                pd.put("rights", "");*/
                pd.put("ROLE_ID", ROLE_ID);
                pd.put("RIGHTS", "");
                pd.put("ADD_QX", "");
                pd.put("DEL_QX", "");
                pd.put("EDIT_QX", "");
                pd.put("CHA_QX", "");
                roleService.updateQxByMenu(pd);
            }

            /*pd.put("roleId", ROLE_ID);
            roleService.setAllRights(pd);*/
            roleService.setAllQxRights(pd);
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 保存角色按钮权限
     */
    @RequestMapping(value = "/roleButton/save")
    public void orleButton(@RequestParam String ROLE_ID, @RequestParam String menuIds, @RequestParam String msg, PrintWriter out) throws Exception {
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            if (null != menuIds && !"".equals(menuIds.trim())) {
                BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
                pd.put("value", rights.toString());
            } else {
                pd.put("value", "");
            }
            pd.put("ROLE_ID", ROLE_ID);
            roleService.updateQx(msg, pd);

            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public Object deleteRole(@RequestParam String ROLE_ID) throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        PageData pd = new PageData();
        String errInfo = "";
        try {
            pd.put("ROLE_ID", ROLE_ID);
            List<Role> roleList_z = roleService.listAllRolesByPId(pd);        //列出此角色的所有下级
            if (roleList_z.size() > 0) {
                errInfo = "false1";
            } else {

                List<PageData> userlist = roleService.listAllUByRid(pd);
                if (userlist.size() > 0) {
                    errInfo = "false2";
                } else {
                    roleService.deleteRoleById(ROLE_ID);
                    roleService.deleteKeFuById(ROLE_ID);
                    roleService.deleteGById(ROLE_ID);
                    //更新activiti的group信息
                    WorkFlow workFlow = new WorkFlow();
                    //删除
                    workFlow.getIdentityService().deleteGroup(pd.getString("ROLE_ID"));
                    errInfo = "success";
                }
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }
    
    /**
     * 编辑角色成员
     */
    @RequestMapping(value="checkRoleUser")
    @ResponseBody
    public Object checkRoleUser(
    		@RequestParam String roleId,
    		@RequestParam String userId,
    		@RequestParam String userIds,
    		@RequestParam String operateType)throws Exception{
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = new PageData();
    	WorkFlow workFlow = new WorkFlow();
    	try{
    		
	    	pd.put("USER_ID", userId);
	    	String act_roleId = roleId;
	    	String ROLE_ID = "";
	    	if(operateType.equals("add")){
	    		PageData dataPd = sysUserService.findByUiId(pd);
	    		if(dataPd!=null&&dataPd.containsKey("ROLE_ID")){
		    		ROLE_ID = dataPd.get("ROLE_ID").toString();
	    		}
	    		if(ROLE_ID==null||"".equals(ROLE_ID)){
	    			pd.put("ROLE_ID", roleId);
	    		}else{
	    			if(!(ROLE_ID.lastIndexOf(roleId)>-1)){
		        		pd.put("ROLE_ID", ROLE_ID+","+roleId);
	    			}
	    		}
	    		sysUserService.editRoleUser(pd);
	        	map.put("msg", "success");
				workFlow.identityService.createMembership(userId, act_roleId);
	    	}else if(operateType.equals("delete")){
	    		PageData dataPd = sysUserService.findByUiId(pd);
	    		if(dataPd!=null&&dataPd.containsKey("ROLE_ID")){
		    		ROLE_ID = dataPd.get("ROLE_ID").toString();
	    		}
	    		if(ROLE_ID==null||"".equals(ROLE_ID)){
	    			pd.put("ROLE_ID", ROLE_ID);
	    		}else{
	    			if(ROLE_ID.indexOf(roleId)>-1){
		    			ROLE_ID = ROLE_ID.replace(","+roleId+",", "");
		    			ROLE_ID = ROLE_ID.replace(","+roleId, "");
		    			ROLE_ID = ROLE_ID.replace(roleId+",", "");
		    			ROLE_ID = ROLE_ID.replace(roleId, "");
		        		pd.put("ROLE_ID", ROLE_ID);
	    			}
	    		}
	    		sysUserService.editRoleUser(pd);
	        	map.put("msg", "success");
				workFlow.identityService.deleteMembership(userId, act_roleId);
	    	}else if(operateType.equals("addAll")){
	    		if(userIds.contains(",")){
	    			for(String USER_ID : userIds.split(",")){
	    				pd.put("USER_ID", USER_ID);
	    	    		PageData dataPd = sysUserService.findByUiId(pd);
	    	    		if(dataPd!=null&&dataPd.containsKey("ROLE_ID")){
	    		    		ROLE_ID = dataPd.get("ROLE_ID").toString();
	    	    		}
	    				if(ROLE_ID==null||ROLE_ID.equals("")){
	    	    			pd.put("ROLE_ID", roleId);
	    	    		}else{
	    	    			if(!ROLE_ID.contains(roleId)){
		    	        		pd.put("ROLE_ID", ROLE_ID+","+roleId);
	    	    			}
	    	    		}
	    	    		sysUserService.editRoleUser(pd);
	    	        	map.put("msg", "success");
	    				workFlow.identityService.deleteMembership(USER_ID, act_roleId);
	    				workFlow.identityService.createMembership(USER_ID, act_roleId);
	    			}
	    		}
	    	}else if(operateType.equals("deleteAll")){
	    		if(userIds.contains(",")){
	    			for(String USER_ID : userIds.split(",")){
	    				pd.put("USER_ID", USER_ID);
	    	    		PageData dataPd = sysUserService.findByUiId(pd);
	    	    		if(dataPd!=null&&dataPd.containsKey("ROLE_ID")){
	    		    		ROLE_ID = dataPd.get("ROLE_ID").toString();
	    	    		}
	    				if(ROLE_ID.indexOf(roleId)>-1){
	    	    			ROLE_ID = ROLE_ID.replace(","+roleId+",", "");
	    	    			ROLE_ID = ROLE_ID.replace(","+roleId, "");
	    	    			ROLE_ID = ROLE_ID.replace(roleId+",", "");
	    	    			ROLE_ID = ROLE_ID.replace(roleId, "");
	    	        		pd.put("ROLE_ID", ROLE_ID);
	    	    		}else{
	    	    			pd.put("ROLE_ID", ROLE_ID);
	    	    		}
	    	    		sysUserService.editRoleUser(pd);
	    	        	map.put("msg", "success");
	    				workFlow.identityService.deleteMembership(USER_ID, act_roleId);
	    			}
	    		}
	    	}
    	}catch(Exception e){
    		map.put("msg", "error");
    		logger.error(e.toString(),e);
    	}
    	JSONObject obj = JSONObject.fromObject(map);
    	return obj;
    }
    
    /**
     * 编辑所有角色成员
     */
    @RequestMapping(value="checkAllRoleUser")
    @ResponseBody
    public Object checkAllRoleUser(
    		@RequestParam String roleId,
    		@RequestParam String userIds,
    		@RequestParam String operateType)throws Exception{
    	if(operateType.equals("addAll")){
    		if(!userIds.equals("")&&userIds!=null){
    			for(String USER_ID : userIds.split(",")){
    				
    			}
    		}
    	}else if(operateType.equals("deleteAll")){
    		if(!userIds.equals("")&&userIds!=null){
    			
    		}
    	}
    	return null;
    }
    
    /**
     * 查询用户角色列表
     */
    @RequestMapping(value="getUserListByName")
    @ResponseBody
    public Object getUserListByName()throws Exception{
    	Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            System.out.println(pd.get("NAME").toString());
            List<PageData> userList = sysUserService.findUserListByName(pd);
            System.out.println(userList.size());
            String jsonStr = "";
            for(PageData userPd:userList){
            	jsonStr +="{\"id\":\""+userPd.get("USER_ID").toString()+"\",\"name\":\""+userPd.get("NAME")+"\",\"pId\":\"0\",\"orderNo\":\""+userPd.get("orderNo").toString()+"\",\"checked\":\""+userPd.get("checked").toString()+"\"},";
            }
            if(!jsonStr.equals("")&&jsonStr!=null){
                jsonStr = "["+jsonStr.substring(0,jsonStr.length()-1)+"]";
            }else{
            	jsonStr = "[]";
            }           
            jsonStr = "{\"id\":\"0\",\"name\":\"人员\",\"pId\":\"-1\",\"orderNo\":\"1\",\"checked\":\"false\",\"children\":"+jsonStr+"}";
        	map.put("searchUsers", jsonStr);
        	map.put("msg", "success");
        } catch (Exception e) {
        	map.put("msg", "error");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    @RequestMapping(value="testCheckUser")
    @ResponseBody
    public Object testCheckUser(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("msg", "success");
    	}catch(Exception e){
    		map.put("msg", "error");
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }

    
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */


}
