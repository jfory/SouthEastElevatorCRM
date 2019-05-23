package com.dncrm.controller.system.customer;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.position.PositionService;
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

import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/ordinaryType")
@Controller
public class OrdinaryTypeController extends BaseController {
	@Resource(name="customerService")
	private CustomerService customerService;

    /**
     * 显示客户类型列表
     *
     * @return
     */
    @RequestMapping("/listOrdinaryType")
    public ModelAndView listOrdinaryType() {
        ModelAndView mv = this.getModelAndView();
        try {
        	mv.setViewName("system/customer/customer_ordinary_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> ordinaryTypes = customerService.findOrdinaryTypeList();
            if (ordinaryTypes.size() > 0) {
                JSONArray obj = JSONArray.fromObject(ordinaryTypes);
                mv.addObject("ordinaryTypes", obj);
            }else{
                mv.addObject("ordinaryTypes", null);
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
    @RequestMapping("/goEditOrdinaryType")
    public ModelAndView goEditOrdinaryType() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
	        pd = customerService.findOrdinaryById(pd);
	        mv.setViewName("system/customer/customer_ordinary_edit");
	        mv.addObject("msg", "editOrdinaryType");
        }catch (Exception e){
            logger.error(e.toString(), e);
        }
        mv.addObject("pd", pd);
        mv.addObject("operateType","edit");
        return mv;
    }
    
    /**
     * 跳到新增页面
     *
     * @return
     */
    @RequestMapping("/goAddOrdinaryType")
    public ModelAndView goAddOrdinaryType() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("system/customer/customer_ordinary_edit");
        mv.addObject("msg", "addOrdinaryType");
        mv.addObject("operateType","add");
        return mv;
    }
    
    /**
     * 保存新增
     *
     * @return
     */
    @RequestMapping("/addOrdinaryType")
    public ModelAndView addOrdinaryType() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("id", this.get32UUID());
        try {
        	customerService.saveOrdinaryType(pd);
            mv.addObject("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","error");
        }
        mv.addObject("id", "EditOrdinaryType");
        mv.addObject("form", "OrdinaryTypeForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    
    
    /**
     * 保存编辑
     *
     * @return
     */
    @RequestMapping("/editOrdinaryType")
    public ModelAndView editOrdinaryType() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	customerService.editOrdinaryType(pd);
            mv.addObject("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","error");
        }
        mv.addObject("pd", pd);
        mv.addObject("id", "EditOrdinaryType");
        mv.addObject("form", "OrdinaryTypeForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 执行删除
     *
     * @return
     */
    @RequestMapping("/delOrdinaryType")
    @ResponseBody
    public Object delOrdinaryType() {
        Map<String,Object> map = new HashMap<String,Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        boolean ifDel=false;
        try {
        	ifDel = customerService.ifDelOrdinaryType(pd);
        	if(!ifDel){
            	customerService.delOrdinaryType(pd);
                map.put("msg","success");
        	}else{
                map.put("msg","error");
                map.put("err","该行业有关联客户信息无法删除");
        	}
        }catch (Exception e){
            logger.error(e.toString(), e);
            map.put("msg","error");
            map.put("err","删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 执行批量删除
     *
     * @return
     */
    @RequestMapping("/delAllOrdinaryType")
    @ResponseBody
    public Object delAllOrdinaryType() {
        Map<String,Object> map = new HashMap<String,Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String[] ids = pd.getString("ids").split(",");
        try {
        	for(String id : ids){
        		pd.put("id", id);
            	customerService.delOrdinaryType(pd);
        	}
            map.put("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            map.put("msg","error");
            map.put("err","删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     *检测名称是否重复 
     */
    @RequestMapping(value="checkOrdinaryName")
    @ResponseBody
    public Object checkOrdinaryName(
    		@RequestParam String type,
    		@RequestParam String old_type,
    		@RequestParam String operateType
    		)throws Exception{
    	PageData pd = new PageData();
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<PageData> pdList = new ArrayList<PageData>();
    	pd.put("type", type);
    	pd.put("old_type", old_type);
    	if(operateType.equals("add")){
    		pdList = customerService.findOrdinaryTypeByName(pd);
    	}else if(operateType.equals("edit")){
    		pdList = customerService.findOrdinaryTypeByOldName(pd);
    	}
    	if(pdList.size()>0){
    		map.put("msg", "hasExist");
    	}else{
    		map.put("msg", "success");
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *导出 
     */
    @RequestMapping(value="toExcel")
    public ModelAndView toExcel(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("客户类型id");
			titles.add("客户类型名");
			titles.add("客户类型描述");
			dataMap.put("titles", titles);
			List<PageData> ordinaryTypeList = customerService.findOrdinaryTypeForExcel();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < ordinaryTypeList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", ordinaryTypeList.get(i).getString("id"));
				vpd.put("var2", ordinaryTypeList.get(i).getString("type"));
				vpd.put("var3", ordinaryTypeList.get(i).getString("descript"));
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
     *导入 
     */
    @RequestMapping(value="importExcel")
    @ResponseBody
    public Object importExcel(@RequestParam (value = "file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
	            
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++){
					//放入主键
					pd.put("id", this.get32UUID());
		        	pd.put("type", listPd.get(i).getString("var0"));
		        	pd.put("descript", listPd.get(i).getString("var1"));
		        	//保存至数据库 
		        	customerService.saveOrdinaryTypeForExcel(pd);
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
