package com.dncrm.controller.system.department;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.*;

@RequestMapping("/department")
@Controller
public class DepartmentController extends BaseController {
    @Resource(name = "departmentService")
    private DepartmentService departmentService;

    /**
     * 显示部门列表
     *
     * @return
     */
    @RequestMapping("/listDepartments")
    public ModelAndView listDepartments() {
        ModelAndView mv = this.getModelAndView();
        try {
            mv.setViewName("system/department/department_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> departments = departmentService.listAllDepartments();
            if (departments.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.make(departments);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("departments", node);
            } else {
                mv.addObject("departments", departments);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 获取所有一条数据
     *
     */
    @RequestMapping("/getAllDepartments")
    @ResponseBody
    public Object getAllDepartments() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray json = new JSONArray();
        try {
            List<PageData> departments = departmentService.listAllDepartments();

            if (departments.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.make(departments);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                map.put("msg","success");
                map.put("departments",node.toString());

            } else {
                map.put("msg","failed");
                map.put("err","没有数据了");
            }
        } catch (Exception e) {
            map.put("msg","系统错误");
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 新增一条数据
     *
     */
    @RequestMapping("/addDepartment")
    @ResponseBody
    public Object addDepartment() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //如果没有任何数据，默认设置第一个数据的父类ID为0
            List<PageData> departments = departmentService.listAllDepartments();
            if (departments == null || departments.size() <= 0) {
                pd.put("parentId", "0");
                pd.put("id",UUID.randomUUID().toString());
                String id = departmentService.addDepartment(pd);
                if (id != "-1") {
                    map.put("msg", "success");
                    map.put("id", id);
                } else {
                    map.put("msg", "failed");
                    map.put("err", "新增失败");
                }
            } else {
                String parentId = (String) pd.get("parentId");
                if (parentId.equalsIgnoreCase("0")) {
                    map.put("msg", "failed");
                    map.put("err", "根节点已存在");
                } else {
                    //查询父类ID是否存在
                    PageData ppData = new PageData();
                    ppData.put("id", parentId);
                    List<PageData> list = departmentService.getDepartmentById(ppData);
                    if (list == null || list.size() == 0) {
                        map.put("msg", "failed");
                        map.put("err", "父类ID不存在");
                    } else {
                        pd.put("id",UUID.randomUUID().toString());
                        String id = departmentService.addDepartment(pd);
                        if (id != "-1") {
                            map.put("msg", "success");
                            map.put("id", id);
                        } else {
                            map.put("msg", "failed");
                            map.put("err", "新增失败");
                        }
                    }
                }

            }

        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 删除一条数据
     *
     */
    @RequestMapping("/delDepartment")
    @ResponseBody
    public Object delDepartment() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            int id = departmentService.delDepartment(pd);
            if (id != 0) {
                map.put("msg", "success");
            } else {
                map.put("msg", "failed");
                map.put("err", "删除失败");
            }
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 修改一条数据
     *
     */
    @RequestMapping("/editDepartment")
    @ResponseBody
    public Object editDepartment() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            int id = departmentService.editDepartment(pd);
            if (id != 0) {
                map.put("msg", "success");
            } else {
                map.put("msg", "failed");
                map.put("err", "修改失败");
            }
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     *导出tb_department 
     */
    @RequestMapping(value="toExcelDepartment")
    public ModelAndView toExcelDepartment(){
    	ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("部门id");
			titles.add("部门名称");
			titles.add("排序编号");
			titles.add("父级id");
			titles.add("创建时间");
			titles.add("类型");
			dataMap.put("titles", titles);
			
			List<PageData> departmentList = departmentService.findDepartmentList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < departmentList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", departmentList.get(i).containsKey("id")?departmentList.get(i).get("id").toString():"");
				vpd.put("var2", departmentList.get(i).containsKey("name")?departmentList.get(i).get("name").toString():"");
				vpd.put("var3", departmentList.get(i).containsKey("orderNo")?departmentList.get(i).get("orderNo").toString():"");
				vpd.put("var4", departmentList.get(i).containsKey("parentId")?departmentList.get(i).get("parentId").toString():"");
				vpd.put("var5", departmentList.get(i).containsKey("create_time")?departmentList.get(i).get("create_time").toString():"");
				vpd.put("var6", departmentList.get(i).containsKey("type")?departmentList.get(i).get("type").toString():"");
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv, dataMap);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    
    /**
     *导入tb_department 
     */
    @RequestMapping(value="importExcelDepartment")
    @ResponseBody
    public Object importExcelDepartment(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    				/*pd.put("id", this.get32UUID());*/
    				pd.put("id", UUID.randomUUID().toString());
    	        	pd.put("name", listPd.get(i).getString("var1"));
    	        	pd.put("orderNo", listPd.get(i).getString("var2"));
    	        	pd.put("parentId", listPd.get(i).getString("var3"));
    	        	pd.put("create_time", listPd.get(i).getString("var4"));
    	        	pd.put("type", listPd.get(i).getString("var5"));
    	        	//保存至数据库
    	        	departmentService.saveDepartment(pd);
    			}
    			map.put("msg", "success");
    		}else{
    			map.put("errorMsg", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
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
