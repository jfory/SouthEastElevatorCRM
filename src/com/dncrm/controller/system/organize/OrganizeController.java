package com.dncrm.controller.system.organize;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.UuidUtil;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.*;

@RequestMapping("/organize")
@Controller
public class OrganizeController extends BaseController {
    @Resource(name = "positionService")
    private PositionService positionService;
    @Resource(name = "departmentService")
    private DepartmentService departmentService;

    //保存所有子节点
    private List<PageData> childDepartments = new ArrayList<PageData>();
    //保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();
    /**
     * 显示组织列表
     *
     * @return
     */
    @RequestMapping("/listOrganizes_backup")
    public ModelAndView listPositions_backup() {
        ModelAndView mv = this.getModelAndView();
        try {
        	mv.setViewName("system/organize/organize_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> organizes = departmentService.listAllDepartments();
            if (organizes.size() > 0) {
                JSONArray obj = JSONArray.fromObject(organizes);
                mv.addObject("organizes", organizes);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    @RequestMapping("/listOrganizes")
    public ModelAndView listPositions() {
        ModelAndView mv = this.getModelAndView();
        try {
        	mv.setViewName("system/organize/organize_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> organizes = departmentService.listAllDepartments();
            if (organizes.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.make(organizes);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("organizes", node);
            	/*JSONArray obj = JSONArray.fromObject(organizes);
            	mv.addObject("organizes", obj);*/
            }else{
            	mv.addObject("organizes", organizes);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 跳到编辑页面
     *
     * @return
     */
    @RequestMapping("/goEditOrganize")
    public ModelAndView goEditOrganize() {
        ModelAndView mv = new ModelAndView();
        List<String> ids = new ArrayList<String>();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/organize/organize_edit");
        mv.addObject("msg", "editOrganize");
        try {
        	//获取当前选中对象
            pd = departmentService.getDepartmentById(pd).get(0);
            //获取当前选中对象的所有子级对象
            List<PageData> childPds = getAllChildDepartments(pd);
            for(PageData childPd : childPds){
            	ids.add(childPd.getString("id"));
            }
            //排除当前对象
            ids.add((String)pd.get("id"));
            //初始化全局变量
            this.childDepartments = new ArrayList<PageData>();
            //获取当前选中对象的父级对象
            PageData parentPd = departmentService.findParentDepartment(pd);
            if(parentPd!=null){
                pd.put("parentId", (String)parentPd.get("id"));
                pd.put("parentName", (String)parentPd.get("name"));
            }else{
                pd.put("parentId", "0");
                pd.put("parentName", "");
            }
            //获取除开该对象的所有其他对象
            List<PageData> otherOrganizes = departmentService.findOtherDepartments(ids);
            if (otherOrganizes.size() > 0) {
            	 //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.make(otherOrganizes);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("organizes", node);
            }
            List<PageData> orgTypes = departmentService.findAllOrgType();
            mv.addObject("orgTypes", orgTypes);
        }catch (Exception e){
            logger.error(e.toString(), e);
        }
        mv.addObject("operateType", "edit");
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 跳到新增页面
     *
     * @return
     */
    @RequestMapping("/goAddOrganize")
    public ModelAndView goAddOrganize() {
    	ModelAndView mv = this.getModelAndView();
        try {
        	mv.setViewName("system/organize/organize_edit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> organizes = departmentService.listAllDepartments();
            List<PageData> orgTypes = departmentService.findAllOrgType();
            mv.addObject("orgTypes", orgTypes);
            mv.addObject("msg", "addOrganize");
            mv.addObject("operateType", "add");
            if (organizes.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.make(organizes);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("organizes", node);
            	/*JSONArray obj = JSONArray.fromObject(organizes);
            	mv.addObject("organizes", obj);*/
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    
    /**
     * 保存编辑
     *
     * @return
     */
    @RequestMapping("/editOrganize")
    public ModelAndView editOrganize() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	departmentService.updateParentDepartment(pd);
        	mv.addObject("msg", "success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg", "error");
        }
        mv.addObject("pd", pd);
        mv.addObject("form","organizeForm");
        mv.addObject("id", "editOrganize");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 保存新增
     *
     * @return
     */
    @RequestMapping("/addOrganize")
    public ModelAndView addOrganize() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	pd.put("id", this.get32UUID());
        	departmentService.insertOrganize(pd);
        	mv.addObject("msg", "success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg", "error");
        }
        mv.addObject("pd", pd);
        mv.addObject("form","organizeForm");
        mv.addObject("id", "editOrganize");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 删除一条数据
     *
     */
    @RequestMapping("/delOrganize")
    @ResponseBody
    public Object delOrganize() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
        	int departmentCount = departmentService.findChildDepartment(pd).size();
        	int positionCount = departmentService.findPosition(pd).size();
        	if(departmentCount<=0&&positionCount<=0){
        		departmentService.delDepartment(pd);
                map.put("msg", "success");
        	}else{
                map.put("msg", "failed");
                map.put("err", "删除失败,有子级部门或职位不可删除");
        	}
        } catch (Exception e) {
            map.put("msg", "error");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     *递归获取所有子节点 
     */
    public List<PageData> getAllChildDepartments(PageData pd)throws Exception{
    	List<PageData> pdList = departmentService.findAllChildDepartments(pd);
    	if(pdList.size()>0){
    		for(PageData childPd : pdList){
    			childDepartments.add(childPd);
    			getAllChildDepartments(childPd);
    		}
    	}
    	return childDepartments;
    }
    
    /**
     *递归获取所有父节点 
     */
    public List<PageData> getAllParentDepartments(PageData pd)throws Exception{
    	PageData parentPd = departmentService.findAllParentDepartments(pd);
    	if(parentPd!=null){
    		parentDepartments.add(parentPd);
    		getAllParentDepartments(parentPd);
    	}
    	return parentDepartments;
    }

    /**
     * 获取权限
     *
     * @return
     */
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
}
