package com.dncrm.controller.system.productionPlan;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.productionPlan.ProductionPlanService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.echarts.Echarts;
import com.github.abel533.echarts.json.GsonOption;

import net.sf.json.JSONObject;

@RequestMapping("/productionPlan")
@Controller
public class productionPlanController extends BaseController {
	@Resource(name = "productionPlanService")
	private ProductionPlanService productionPlanService;

	/**
	 * 显示排产计划基本信息（一排）
	 *
	 * @return
	 */
	@RequestMapping("/productionOnePlan")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> productionList = productionPlanService.proPlanlistPage(page);
			mv.setViewName("system/productionPlan/productionPlan");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 显示排产计划基本信息（二排）
	 *
	 * @return
	 */
	@RequestMapping("/productionTowPlan")
	public ModelAndView listStoresTow(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> productionList = productionPlanService.proTowPlanlistPage(page);
			mv.setViewName("system/productionPlan/productionPlan_TowList");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * （一排）显示审核完成的电梯信息》》》选择进入排产计划
	 * 
	 * @return
	 */
	@RequestMapping("/addelevator")
	public ModelAndView elevatorlistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			page.setPd(pd);
			List<PageData> productionList = productionPlanService.elevatorlistPage(page);
			mv.setViewName("system/productionPlan/plan_elevator_one");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * （二排）显示审核完成的电梯信息》》》选择进入排产计划
	 * 
	 * @return
	 */
	@RequestMapping("/addelevatorTow")
	public ModelAndView elevatorTowlistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			page.setPd(pd);
			List<PageData> productionList = productionPlanService.elevatorTowlistPage(page);
			mv.setViewName("system/productionPlan/plan_elevator_tow");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 跳转到创建排产计划(一排)
	 *
	 * @return
	 */
	@RequestMapping("/insertPlan")
	public ModelAndView insertPlan(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/productionPlan/productionPlan_edit");
		mv.addObject("page", page);
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳转到创建排产计划(二排)
	 *
	 * @return
	 */
	@RequestMapping("/insertPlanTow")
	public ModelAndView insertPlanTow(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/productionPlan/productionPlan_TowEdit");
		mv.addObject("page", page);
		mv.addObject("msg", "TowsaveS");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 显示电梯信息
	 * 
	 * @return
	 */
	@RequestMapping("/view")
	public ModelAndView view(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			page.setPd(pd);
			List<PageData> productionList = productionPlanService.findplanById(page);
			mv.setViewName("system/productionPlan/productionPlan_viwe");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存新增（二排）
	 *
	 * @return
	 */
	@RequestMapping("/TowsaveS")
	public ModelAndView TowsaveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000);
		String pro_no = ('T' + time + number);
		String type = "2";
		//获取系统时间
		String df=DateUtil.getTime().toString();
		//获取系统当前登陆人
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
		String user_id=user.getUSER_ID();
		try {
			pd = this.getPageData();
			pd.put("pro_no", pro_no);
			pd.put("type", type); // 类型
			pd.put("pro_uuid", UUID.randomUUID().toString());
			pd.put("input_user", user_id);
			pd.put("input_time", df); 
			productionPlanService.saveS(pd); // 保存排产计划
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 保存新增（一排）
	 *
	 * @return
	 */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000);
		String pro_no = ('Y' + time + number);
		String type = "1";
		//获取系统时间
		String df=DateUtil.getTime().toString();
		//获取系统当前登陆人
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
		String user_id=user.getUSER_ID();
		try {
			pd = this.getPageData();
			pd.put("pro_no", pro_no);
			pd.put("type", type); // 类型
			pd.put("pro_uuid", UUID.randomUUID().toString());
			pd.put("input_user", user_id);
			pd.put("input_time", df); 
			productionPlanService.saveS(pd); // 保存
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 添加电梯
	 *
	 * @return
	 */
	@RequestMapping("/addelevatorS")
	@ResponseBody
	public Object addelevator() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		String plan_state = "1";
		String type = "1";
		try {
			pd = this.getPageData();
			String elevator_nos = (String) pd.get("stra_nos");
			String pro_no=pd.getString("pro_no");
			for (String elevator_no : elevator_nos.split(",")) {
				Date dt = new Date();
				pd.put("elevator_no", elevator_no);
				pd=productionPlanService.fpById(pd);//根据电梯编号查询电梯是不是特批电梯
				String special_state=pd.getString("special_state");
				SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
				String time = matter1.format(dt);
				int number = (int) ((Math.random() * 9 + 1) * 100000);
				String pro_nos = ('P' + time + number);
				pd.put("special_state", special_state);
				pd.put("pro_no", pro_no);
				pd.put("pro_eleva_no", pro_nos);
				pd.put("elevator_no", elevator_no);
				pd.put("plan_state", plan_state);
				pd.put("type", type);
				productionPlanService.elevatorsaveS(pd); // 保存新增排产电梯
				productionPlanService.upfindById(pd);    // 修改电梯状态
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 添加电梯到排产计划(二排)
	 * 
	 * @return
	 */
	@RequestMapping("/addelevatortow")
	@ResponseBody
	public Object addelevatorTow() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		String plan_state = "1";
		String type = "2";
		try {
			pd = this.getPageData();
			String elevator_nos = (String) pd.get("stra_nos");
			String pro_no=pd.getString("pro_no");
			for (String elevator_no : elevator_nos.split(",")) {
				Date dt = new Date();
				pd.put("elevator_no", elevator_no);
				pd=productionPlanService.fpTowById(pd);//根据电梯编号查询电梯是不是特批电梯
				String special_state=pd.getString("special_state");
				SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
				String time = matter1.format(dt);
				int number = (int) ((Math.random() * 9 + 1) * 100000);
				String pro_nos = ('P' + time + number);
				pd.put("elevator_no", elevator_no);
				pd = (PageData) productionPlanService.findelevadById(pd); // 根据电梯编号查询电梯信息
				pd.put("pro_eleva_no", pro_nos);
				pd.put("special_state", special_state);
				pd.put("elevator_no", elevator_no);
				pd.put("pro_no", pro_no);
				pd.put("plan_state", plan_state);
				pd.put("type", type);
				productionPlanService.elevatorsaveS(pd); // 保存新增排产电梯
				productionPlanService.upfindtowById(pd); // 修改电梯状态
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	
	
	 /* ===============================报表================================== */
    @RequestMapping(value="productionPlanInfo")
   	public ModelAndView reportInfo(){
   		ModelAndView mv = new ModelAndView();
   		try{
   			mv.setViewName("system/productionPlan/productionPlanInfo");
   		}catch(Exception e){
   			logger.error(e.getMessage(), e);
   		}
   		return mv;
   	}
       
       
       /**
   	 *set by month 
   	 */
   	@RequestMapping(value="setByType",produces = "text/html;charset=UTF-8")
   	@ResponseBody
   	public Object setByType(){
   		PageData pd = new PageData();
   		GsonOption option = new GsonOption();
   		Echarts echarts = new Echarts();
   		try{
   			pd = this.getPageData();
   			List<PageData> list = new ArrayList<PageData>();
   			String type = pd.get("type").toString();
   			String itemStatus = pd.get("itemStatus").toString();
   			String xAxisName = "";
   			String yAxisName = "num";
   			if(itemStatus.equals("1"))
   			{
   				if(type.equals("year")){
   	   				list =productionPlanService.productionYearNum();
   	   				xAxisName="(年)";
   	   			}else if(type.equals("month")){
   	   				String year = new SimpleDateFormat("yyyy").format(new Date());
   	   				list = productionPlanService.productionMonthNum(year);
   	   				echarts.setXAxisMonth(option);
   	   				xAxisName="(月份)";
   	   			}else if(type.equals("quarter")){
   	   				String year = new SimpleDateFormat("yyyy").format(new Date());
   	   				list = productionPlanService.productionQuarterNum(year);
   	   				echarts.setXAxisQuarter(option);
   	   				xAxisName="(季度)";
   	   			}
   				Map<String, String> legendMap = new HashMap<String, String>();
   	   			legendMap.put("category", "date");
   	   			legendMap.put("排产数量", "num");
   	   			/*legendMap.put("东南安装", "cellNumDN001");
   	   			legendMap.put("对手安装", "cellNum");*/
   	   			option = echarts.setOption(list, legendMap);
   	   			echarts.setYAxisName(option, yAxisName);
   	   			echarts.setXAxisName(option, xAxisName);
   			}
   			else if(itemStatus.equals("2"))
   			{
   				if(type.equals("year")){
   	   				list =productionPlanService.productionYearTypeNum();
   	   				xAxisName="(年)";
   	   			}else if(type.equals("month")){
   	   				String year = new SimpleDateFormat("yyyy").format(new Date());
   	   				list = productionPlanService.productionMonthTypeNum(year);
   	   				echarts.setXAxisMonth(option);
   	   				xAxisName="(月份)";
   	   			}else if(type.equals("quarter")){
   	   				String year = new SimpleDateFormat("yyyy").format(new Date());
   	   				list = productionPlanService.productionQuarterTypeNum(year);
   	   				echarts.setXAxisQuarter(option);
   	   				xAxisName="(季度)";
   	   			}
   				Map<String, String> legendMap = new HashMap<String, String>();
   	   			legendMap.put("category", "date");
   	   			legendMap.put("常规梯", "GeneralNum");
   	   			legendMap.put("家用梯", "HomeUseNum");
   	   			legendMap.put("特种梯", "SpecialNum");
   	   		    legendMap.put("扶梯", "EscalatorNum");
   	   			option = echarts.setOption(list, legendMap);
   	   			echarts.setYAxisName(option, yAxisName);
   	   			echarts.setXAxisName(option, xAxisName);
   			}
   		}catch(Exception e){
   			logger.error(e.getMessage(), e);
   		}
   		return option.toString();
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
			titles.add("排产计划UUID");
			titles.add("排产计划编号");
			titles.add("排产计划名称");
			titles.add("日期");
			titles.add("类型");
			titles.add("录入人");
			titles.add("录入时间");
			dataMap.put("titles", titles);
			
			List<PageData> itemList = productionPlanService.findProductionPlanOneList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("pro_uuid"));
				vpd.put("var2", itemList.get(i).getString("pro_no"));
				vpd.put("var3", itemList.get(i).getString("pro_name"));
				
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
				String str = df.format(itemList.get(i).get("End_Time"));
				vpd.put("var4", str);
				String type=itemList.get(i).getString("type");
				vpd.put("var5", type.equals("1")?"一排":"二排");
				vpd.put("var6", itemList.get(i).getString("input_user"));
				vpd.put("var7", itemList.get(i).getString("input_time"));
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
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000);
		String pro_no = ('Y' + time + number);
		String type = "1";
		//获取系统时间
		String df=DateUtil.getTime().toString();
		//获取系统当前登陆人
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
		String user_id=user.getUSER_ID();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++){
		        	pd.put("pro_uuid",UUID.randomUUID().toString());
		        	pd.put("pro_no", pro_no);
		        	pd.put("pro_name", listPd.get(i).getString("var0"));
		        	pd.put("End_Time",  listPd.get(i).getString("var1"));
		        	pd.put("type", type);
		        	pd.put("input_user", user_id);
		        	pd.put("input_time", df);
		        	//保存至数据库
		        	productionPlanService.saveS(pd);
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
	
	
	
	//二排  导入导出
	 /**
		 *导出到Excel 
		 */
		@RequestMapping(value="toExcel2")
		public ModelAndView toExcel2(){
			ModelAndView mv = new ModelAndView();
			try{
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("排产计划UUID");
				titles.add("排产计划编号");
				titles.add("排产计划名称");
				titles.add("日期");
				titles.add("类型");
				titles.add("录入人");
				titles.add("录入时间");
				dataMap.put("titles", titles);
				
				List<PageData> itemList = productionPlanService.findProductionPlanTowList();
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).getString("pro_uuid"));
					vpd.put("var2", itemList.get(i).getString("pro_no"));
					vpd.put("var3", itemList.get(i).getString("pro_name"));
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
					String str = df.format(itemList.get(i).get("End_Time"));
					vpd.put("var4", str);
					String type=itemList.get(i).getString("type");
					vpd.put("var5", type.equals("1")?"一排":"二排");
					vpd.put("var6", itemList.get(i).getString("input_user"));
					vpd.put("var7", itemList.get(i).getString("input_time"));
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
		@RequestMapping(value="importExcel2")
		@ResponseBody
		public Object importExcel2(@RequestParam(value = "file") MultipartFile file){
			Map<String, Object> map = new HashMap<String, Object>();
			Date dt = new Date();
			SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
			String time = matter1.format(dt);
			int number = (int) ((Math.random() * 9 + 1) * 100000);
			String pro_no = ('T' + time + number);
			String type = "2";
			//获取系统时间
			String df=DateUtil.getTime().toString();
			//获取系统当前登陆人
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			User user=(User) session.getAttribute(Const.SESSION_USER);
			String user_id=user.getUSER_ID();
			try{
				if(file!=null && !file.isEmpty()){
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					PageData pd = new PageData();
					for(int i = 0;i<listPd.size();i++){
			        	pd.put("pro_uuid",UUID.randomUUID().toString());//
			        	pd.put("pro_no", pro_no);//
			        	pd.put("pro_name", listPd.get(i).getString("var0"));//
			        	pd.put("End_Time",  listPd.get(i).getString("var1"));//
			        	pd.put("type", type);//
			        	pd.put("input_user", user_id);
			        	pd.put("input_time", df);
			        	//保存至数据库
			        	productionPlanService.saveS(pd);
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
