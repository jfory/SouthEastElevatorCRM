package com.dncrm.controller.system.HousesType;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.service.system.housesType.HousesTypeService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@RequestMapping("/housesType")
@Controller
public class HousesTypeController extends BaseController
{
	@Resource(name = "housestypeService")
	private HousesTypeService housestypeService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	
	/**
	 * 显示楼盘类型信息
	 *
	 * @return
	 */
	@RequestMapping("/housesType")
	public ModelAndView listHousesType(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> housestypeList = housestypeService.listPdPageHousesType(page);
			mv.setViewName("system/housesType/housesType");
			mv.addObject("housestypeList", housestypeList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	
	/**
	 * 跳到添加页面
	 * @return
	 */

	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 10); // 生成随机2位数字
		String id = ("T" + time + number); // 拼接
		try {
		mv.setViewName("system/housesType/housesType_edit");
		mv.addObject("msg", "saveS");
		pd.put("id", id);
		mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
	 * 跳到编辑页面
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goEditS")
	public ModelAndView goEditS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = housestypeService.findHousesTypeById(pd);
			mv.setViewName("system/housesType/housesType_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	
	/**
	 * 删除一条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/delShop")
	@ResponseBody
	public Object delShop() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			housestypeService.deleteHousesType(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 删除多条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/deleteAllS")
	@ResponseBody
	public Object delShops() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String ids = (String) pd.get("ids");
			for (String id : ids.split(",")) {
				pd.put("id", id);
				housestypeService.deleteHousesType(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 保存新增
	 *
	 * @return
	 */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Page page = this.getPage();
		try {
			pd = this.getPageData();
			PageData shop = housestypeService.findHousesTypeById(pd);
			if (shop != null) {// 判断门店编号
				mv.addObject("msg", "failed");
			} else {
				housestypeService.saveS(pd);   //保存楼盘基本信息 
				mv.addObject("msg", "success");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}
	
	/**
	 * 保存编辑
	 *
	 * @return
	 */
	@RequestMapping("/editS")
	public ModelAndView editS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			PageData shop = housestypeService.findHousesTypeById(pd);
			if (shop == null) {// 判断这个编号是否存在
				mv.addObject("msg", "failed");
			} else {
			housestypeService.editS(pd);
			mv.addObject("msg", "success");
			}
		} 
		catch (Exception e)
		{
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}
	
	/**
	 * 判断井道类型编号是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/hasShop")
	@ResponseBody
	public Object hasShop() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = housestypeService.findHousesTypeById(pd);
			if (shop != null) {
				map.put("msg","error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 判断楼盘类型名称是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/housestypeName")
	@ResponseBody
	public Object housestypeName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = housestypeService.findHousesTypeByName(pd);
			if (shop != null) {
				map.put("msg","error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("建筑结构类型编号");
			titles.add("建筑结构类型名称");
			titles.add("建筑结构类型描述");
			dataMap.put("titles", titles);
			
			List<PageData> itemList = housestypeService.findHousesTypeList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				/*int id1=(int)itemList.get(i).get("id");
				String id=Integer.toString(id1) ;*/
				vpd.put("var1", itemList.get(i).get("id").toString());
				vpd.put("var2", itemList.get(i).getString("type_name"));
				vpd.put("var3", itemList.get(i).getString("type_describe"));
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
	 *导入Excel到数据库 
	 */
	@RequestMapping(value="importExcel")
	@ResponseBody
	public Object importExcel(@RequestParam(value = "file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				//保存错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++)
				{
					//保存错误信息集合
	    			List<PageData> errList = new ArrayList<PageData>();
					Date dt = new Date();
					SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
					String time = matter1.format(dt);
					int number = (int) ((Math.random() * 9 + 1) * 10); // 生成随机2位数字
					String id = ("T" + time + number); // 拼接
		        	
					String type_name= listPd.get(i).getString("var0");
					if(type_name!=null && !type_name.equals(""))
					{
						PageData typepd=new PageData();
						typepd.put("type_name", type_name);
						PageData shop = housestypeService.findHousesTypeByName(typepd);
						if(shop!=null)
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "类型名称重复!");
	    	        		errPd.put("errCol", "1");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "类型名称不能为空!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					if(errList.size()==0)
				    {
						pd.put("id", id);
			        	pd.put("type_name", listPd.get(i).getString("var0"));
			        	pd.put("type_describe", listPd.get(i).getString("var1"));
				    	allErr = false;
				    	//保存至数据库
			        	housestypeService.saveS(pd);
				    }
				    else
				    {
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}
					
				}
				//↑↑↑----------循环结束------------↑↑↑
				//判断总错误数
				if(allErrList.size()==0){
        			map.put("msg", "success");
    			}else{
    				if(allErr){
    					//导入全部失败
            			map.put("msg", "allErr");
    				}else{
    					//部分导入成功，部分导入失败
    					map.put("msg", "error");
    				}
    				//执行完操作之后抛出报错集合
        			String errStr = "";
        			errStr += "总错误:"+allErrList.size();
        			for(PageData forPd : allErrList){
        				errStr += "\n错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
        			}
        			map.put("errorUpload", errStr);
    			}
	    	}else{
	    		map.put("msg", "exception");
	    		map.put("errorMsg", "上传失败,没有数据！");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
		}
		return JSONObject.fromObject(map);
	}
	
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }
    public String getRoleType(){
    	Subject currentUser = SecurityUtils.getSubject();
    	Session session = currentUser.getSession();
    	return (String)session.getAttribute(Const.SESSION_ROLE_TYPE);
    }
/* ===============================用户================================== */
}
