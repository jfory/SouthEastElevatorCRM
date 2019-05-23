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

import java.util.*;

@RequestMapping("/tradeType")
@Controller
public class TradeTypeController extends BaseController {
	@Resource(name="customerService")
	private CustomerService customerService;

	 /**
     * 显示客户类型列表
     *
     * @return
     */
    @RequestMapping("/listTradeType")
    public ModelAndView listTradeType() {
        ModelAndView mv = this.getModelAndView();
        try {
        	mv.setViewName("system/customer/customer_trade_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> tradeTypes = customerService.findTradeTypeList();
            if (tradeTypes.size() > 0) {
                JSONArray obj = JSONArray.fromObject(tradeTypes);
                mv.addObject("tradeTypes", obj);
            }else{
                mv.addObject("tradeTypes", null);
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
    @RequestMapping("/goEditTradeType")
    public ModelAndView goEditTradeType() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
	        pd = customerService.findTradeById(pd);
	        mv.setViewName("system/customer/customer_trade_edit");
	        mv.addObject("msg", "editTradeType");
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
    @RequestMapping("/goAddTradeType")
    public ModelAndView goAddTradeType() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("system/customer/customer_trade_edit");
        mv.addObject("msg", "addTradeType");
        mv.addObject("operateType","add");
        return mv;
    }
    
    /**
     * 保存新增
     *
     * @return
     */
    @RequestMapping("/addTradeType")
    public ModelAndView addTradeType() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("id", this.get32UUID());
        try {
        	customerService.saveTradeType(pd);
            mv.addObject("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","error");
        }
        mv.addObject("id", "EditTradeType");
        mv.addObject("form", "TradeTypeForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    
    
    /**
     * 保存编辑
     *
     * @return
     */
    @RequestMapping("/editTradeType")
    public ModelAndView editTradeType() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	customerService.editTradeType(pd);
            mv.addObject("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","error");
        }
        mv.addObject("pd", pd);
        mv.addObject("id", "EditTradeType");
        mv.addObject("form", "TradeTypeForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 执行删除
     *
     * @return
     */
    @RequestMapping("/delTradeType")
    @ResponseBody
    public Object delTradeType() {
        Map<String,Object> map = new HashMap<String,Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        boolean ifDel = false;
        try {
        	ifDel = customerService.ifDelTradeType(pd);
        	if(!ifDel){
            	customerService.delTradeType(pd);
            	map.put("msg","success");
        	}else{
                map.put("msg","error");
                map.put("err","该类型有关联客户信息无法删除");
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
    @RequestMapping("/delAllTradeType")
    @ResponseBody
    public Object delAllTradeType() {
        Map<String,Object> map = new HashMap<String,Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String[] ids = pd.getString("ids").split(",");
        try {
        	for(String id : ids){
        		pd.put("id", id);
            	customerService.delTradeType(pd);
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
    @RequestMapping(value="checkTradeName")
    @ResponseBody
    public Object checkTradeName(
    		@RequestParam String name,
    		@RequestParam String old_name,
    		@RequestParam String operateType
    		)throws Exception{
    	PageData pd = new PageData();
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<PageData> pdList = new ArrayList<PageData>();
    	pd.put("name", name);
    	pd.put("old_name", old_name);
    	if(operateType.equals("add")){
    		pdList = customerService.findTradeTypeByName(pd);
    	}else if(operateType.equals("edit")){
    		pdList = customerService.findTradeTypeByOldName(pd);
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
			titles.add("客户行业id");
			titles.add("客户行业名");
			titles.add("客户行业描述");
			dataMap.put("titles", titles);
			List<PageData> tradeTypeList = customerService.findTradeTypeForExcel();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < tradeTypeList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", tradeTypeList.get(i).getString("id"));
				vpd.put("var2", tradeTypeList.get(i).getString("name"));
				vpd.put("var3", tradeTypeList.get(i).getString("descript"));
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
		        	pd.put("name", listPd.get(i).getString("var0"));
		        	pd.put("descript", listPd.get(i).getString("var1"));
		        	//保存至数据库 
		        	customerService.saveTradeTypeForExcel(pd);
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
