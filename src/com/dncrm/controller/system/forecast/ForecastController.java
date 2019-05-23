package com.dncrm.controller.system.forecast;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.forecast.ForecastService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.Tools;
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

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/forecast")
@Controller
public class ForecastController extends BaseController {
	
	@Resource(name="forecastService")
	private ForecastService forecastService; 
	@Resource(name="itemService")
	private ItemService itemService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="departmentService")
	private DepartmentService departmentService;
	@Resource(name="sysUserService")
	private sysUserService sysUserService;
	@Resource(name="positionService")
	private PositionService positionService;
	
	private List<PageData> parentDepartments = new ArrayList<PageData>();
	private List<PageData> childDepartments = new ArrayList<PageData>();
	
	
	
	/**
	 *显示申请列表 
	 * @throws Exception 
	 */
	@RequestMapping(value="listForecast")
	public ModelAndView listItem(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
        try{
        	int type = getUserRoleType();
			List<PageData> forecastList = forecastService.findForecastListByInputUser(getUser().getUSER_ID());
			for(int i =0;i<forecastList.size();i++){
				String status = forecastList.get(i).get("status").toString();
				if((status.equals("0")&&type==1)||(status.equals("2")&&type==2)||(status.equals("4")&&type==3)){
					forecastList.get(i).put("submitFlag", "1");
					forecastList.get(i).put("editFlag", "1");
					forecastList.get(i).put("setTopFlag", "1");
				}
				if(type==1){
					forecastList.get(i).put("setTopFlag", "0");
				}
				forecastList.get(i).put("selFlag", "1");
			}
			if(type==1){
				mv.addObject("selHistory", "1");
				mv.addObject("addTextFlag", "1");
				mv.addObject("addText","新增");
				mv.addObject("forecastList",forecastList);
			}else if(type==2||type==3){
				String monthNo = new SimpleDateFormat("yyyyMM").format(new Date());
				String USER_ID = getUser().getUSER_ID();
				PageData pd = new PageData();
				pd.put("month_no", monthNo);
				pd.put("USER_ID", USER_ID);
				Integer size = forecastService.findForecastCountByUserIdAndMonthNo(pd);
				if(size==0){
					mv.addObject("addTextFlag", "1");
				}
				mv.addObject("addText","本月汇总");
				mv.addObject("selHistory","1");
				mv.addObject("forecastList",forecastList);
			}else if(type==4){
				parentDepartments = findAllParentNodeByPosition();
				List<String> userIdList = findAllChildNodeByType(parentDepartments, "1");
				parentDepartments.clear();
				childDepartments.clear();
				List<String> userList = new ArrayList<String>();
				//过滤掉分公司和区域角色的用户
				for(String userId : userIdList){
					if(!userId.equals("1")){
						int i = getUserRoleTypeByUserId(userId);
						if(i==3){
							userList.add(userId);
						}
					}
				}
				PageData selForecastPd = new PageData();
				selForecastPd.put("userList", userList);
				selForecastPd.put("status", "5");
				List<PageData> forecastPdList = forecastService.findForecastListByUserIdAndMonthNo(selForecastPd);
				for(int i =0;i<forecastPdList.size();i++){
					forecastPdList.get(i).put("selFlag", "1");
				}
				mv.addObject("forecastList", forecastPdList);
			}
			mv.addObject("active", "1");
			mv.setViewName("system/forecast/forecast_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        }catch(Exception e){
        	logger.error(e.getMessage(),e);
        }
		return mv;
	}
	
	/**
	 *提交预测信息 
	 */
	@RequestMapping(value="submitForecast")
	@ResponseBody
	public Object submitForecast(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		int type = getUserRoleType();
		try{
			pd = this.getPageData();
			if(type==1){
				pd.put("status", "1");
			}else if(type==2){
				pd.put("status", "3");
			}else if(type==3){
				pd.put("status", "5");
			}
			forecastService.editStatus(pd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	
	
	/**
	 *跳转到新增页面 
	 */
	@RequestMapping(value="goAddForecast")
	public ModelAndView goAddForecast(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		int type = getUserRoleType();
		String USER_ID = getUser().getUSER_ID();
		String monthNo = new SimpleDateFormat("yyyyMM").format(new Date());
		List<String> itemIdList = new ArrayList<String>();
		List<PageData> itemPdList = new ArrayList<PageData>();
		PageData quota = findQuotaByRoleId();
		boolean allin = true;
		String parentType="";
		try{
			if(type==1){//销售
				//将当前登录人添加至列表查询条件
				pd.put("USER_ID", USER_ID);
				allin = false;
				List<String> ids = forecastService.findItemIdsByInputUser(pd);
				List<PageData> list = new ArrayList<PageData>();
				pd.put("itemIds", ids);
				if(ids.size()==0){
					list = itemService.findItemListByInputUser(pd);
				}else{
					list = itemService.findItemListNotForecastByInputUser(pd);
				}
				itemPdList = setItemPdList(list);
				mv.addObject("itemPdList", itemPdList);
			}else if(type==2){//分公司经理
				parentType="10";
			}else if(type==3){//区域经理
				parentType="8";
			}
			if(allin){
				parentDepartments = findAllParentNodeByPosition();
				List<String> userIdList = findAllChildNodeByType(parentDepartments, parentType);
				parentDepartments.clear();
				childDepartments.clear();
				List<String> userList = new ArrayList<String>();
				//过滤掉分公司和区域角色的用户
				for(String userId : userIdList){
					int i = getUserRoleTypeByUserId(userId);
					if(i==1&&type==2){
						userList.add(userId);
					}else if(i==2&&type==3){
						userList.add(userId);
					}
				}
				PageData selForecastPd = new PageData();
				selForecastPd.put("userList", userList);
				selForecastPd.put("month_no", monthNo);
				if(type==2){
					selForecastPd.put("status", "1");
				}else if(type==3){
					selForecastPd.put("status", "3");
				}
				//查到用户集合本月份的所有预测信息
				List<PageData> forecastPdList = forecastService.findForecastListByUserIdAndMonthNo(selForecastPd);
				for(PageData forecastPd : forecastPdList){
					String item_id = forecastPd.get("item_id").toString();
					if(item_id.lastIndexOf(",")>-1){
						for(String id : item_id.split(",")){
							itemIdList.add(id);
						}
					}else{
						itemIdList.add(item_id);
					}
				}
				List<PageData> itemList = itemService.findItemListByIdList(itemIdList);
				if(itemList!=null){
					itemPdList = setItemPdList(itemList);
					mv.addObject("itemPdList", itemPdList);
				}
			}
		//放入指标
		mv.addObject("pd",quota);
		//放入上月预测信息
		List<PageData> frontForecastList = getFrontMonthForecast();
		mv.addObject("frontForecastList",frontForecastList);
		mv.addObject("msg","saveForecast");
		mv.setViewName("system/forecast/forecast_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
		
		
	}
	/**
	 *保存新增 
	 */
	@RequestMapping(value="saveForecast")
	public ModelAndView saveForecast(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		int type = getUserRoleType();
		try{
			pd = this.getPageData();
			pd.put("report", "1");
			pd.put("input_user", getUser().getUSER_ID());
			pd.put("modified_by", getUser().getUSER_ID());
			pd.put("is_top", "0");
			pd.put("is_important", "0");
			if(type==1){
				pd.put("status", "0");//销售人员录入
			}else if(type==2){
				pd.put("status", "2");//分公司经理汇总
			}else if(type==3){
				pd.put("status", "4");//区域经理汇总
			}
			//放入年月编号
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			pd.put("month_no", sdf.format(new Date()));
			forecastService.saveForecast(pd);
			//---保存新增历史记录
			PageData forecastLogPd = new PageData();
			forecastLogPd.put("forecast", pd.get("id").toString());
			forecastLogPd.put("type", "add");
			forecastLogPd.put("user", getUser().getUSER_ID());
			forecastLogPd.put("date",  new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			forecastLogPd.put("descript", "用户"+getUser().getNAME()+"新增了id为"+pd.get("id").toString()+"的预测信息");
			forecastService.saveForecastLog(forecastLogPd);
			//---
			mv.addObject("msg", "success");
			mv.addObject("active", "3");
			mv.addObject("id", "EditForecast");
			mv.addObject("form", "ForecastForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到查看历史 
	 */
	@RequestMapping(value="selHistory")
	public ModelAndView selHistory(){
		ModelAndView mv = new ModelAndView();
		List<String> userList = new ArrayList<String>();
		PageData pd = new PageData();
		List<PageData> list = new ArrayList<PageData>();
		List<PageData> forecastHistory = new ArrayList<PageData>();
		int count=0;
		try{
			String USER_ID = getUser().getUSER_ID();
			Integer type = getUserRoleType();
			userList.add(USER_ID);
			pd.put("userList", userList);
			if(type==1){
				pd.put("status", "1");
			}else if(type==2){
				pd.put("status", "3");
			}else if(type==3){
				pd.put("status", "5");
			}
			list = forecastService.findForecastListByUserIdAndMonthNo(pd);
			if(list!=null){
				for(PageData itemPd : list){
					String elevatorInfo = itemService.findElevatorInfoById(itemPd.get("item_id").toString());
					JSONArray obj = JSONArray.fromObject(elevatorInfo);
					if(elevatorInfo!=null){
						Iterator<Object> it = obj.iterator();
						while(it.hasNext()){
							JSONObject jsonObj = (JSONObject)it.next();
							Map<Object, Object> data = (Map)jsonObj;
							count += Integer.parseInt(data.get("elevatorNum").toString());
						}
					}
					itemPd.put("count", count);
					forecastHistory.add(itemPd);
					count=0;
				}
				mv.addObject("forecastHistory", forecastHistory);
			}
			mv.setViewName("system/forecast/forecast_history");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *获取选中项目的电梯总数量 
	 */
	@RequestMapping(value="getNowMonthCount")
	@ResponseBody
	public Object getNowMonthCount(){
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		Integer count = 0;
		try{
			pd = this.getPageData();
			String ids = pd.get("ids").toString();
			if(ids.lastIndexOf(",")>-1){
				for(String id : ids.split(",")){
					String elevatorInfo = itemService.findElevatorInfoById(id);
					if(elevatorInfo!=null){
						JSONArray obj = JSONArray.fromObject(elevatorInfo);
						Iterator<Object> it = obj.iterator();
						while(it.hasNext()){
							JSONObject jsonObj = (JSONObject)it.next();
							Map<Object, Object> data = (Map)jsonObj;
							count += Integer.parseInt(data.get("elevatorNum").toString());
						}
					}
				}
			}else{
				String elevatorInfo = itemService.findElevatorInfoById(ids);
				JSONArray obj = JSONArray.fromObject(elevatorInfo);
				if(elevatorInfo!=null){
					Iterator<Object> it = obj.iterator();
					while(it.hasNext()){
						JSONObject jsonObj = (JSONObject)it.next();
						Map<Object, Object> data = (Map)jsonObj;
						count += Integer.parseInt(data.get("elevatorNum").toString());
					}
				}
			}
			map.put("msg", "success");
			map.put("count", count);
			String quota_str ="";
			if (pd.get("quota")!=null){
				quota_str = pd.get("quota").toString();
			}

			if (!Tools.isEmpty(quota_str)){
				Integer quota = Integer.parseInt(quota_str);
				// 创建一个数值格式化对象
				NumberFormat numberFormat = NumberFormat.getInstance();
				// 设置精确到小数点后2位
				numberFormat.setMaximumFractionDigits(2);
				String percent = numberFormat.format((float) count / (float) quota * 100);
				percent = percent.replaceAll(",", "");
				map.put("percent", percent);
			}else{
				map.put("percent", 0);
			}

		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *获取跨区信息 
	 */
	@RequestMapping(value="crossRegionInfo")
	@ResponseBody
	public Object crossRegionInfo(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		List<String> itemIdList = new ArrayList<String>();
		try{
			pd = this.getPageData();
			String ids = pd.get("ids").toString();
			if(ids.lastIndexOf(",")>-1){
				for(String id : ids.split(",")){
					itemIdList.add(id);
				}
			}else{
				itemIdList.add(ids);
			}
			List<PageData> areas = itemService.findAreaByItemIdList(itemIdList);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
		
	}
    
    /**
     *跳转到top10/重点项目页面 
     */
    @RequestMapping(value="goSetTop")
    public ModelAndView goSetTop(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	List<PageData> itemList = new ArrayList<PageData>();
    	try{
    		pd = this.getPageData();
    		pd = forecastService.findForecastById(pd);
    		String item_id = pd==null?"":pd.get("item_id").toString();
    		List<String> ids = new ArrayList<String>();
    		if(item_id.lastIndexOf(",")>-1){
    			for(String id : item_id.split(",")){
    				ids.add(id);
    			}
    		}else{
    			ids.add(item_id);
    		}
    		itemList = itemService.findItemListByIdList(ids);
    		mv.addObject("itemList", itemList);
            mv.setViewName("system/forecast/forecast_top");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     * 判断当前月份是否已有top10
     */
    @RequestMapping(value="checkMonthTop")
    @ResponseBody
    public Object checkMonthTop(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String month_no = sdf.format(new Date());
			List<String> itemIdList = forecastService.findItemIdByMonthNo(month_no);
			List<PageData> itemPdList = itemService.findItemListByIdList(itemIdList);
			if(itemPdList.size()>10){
				map.put("msg", "exception");
			}else{
				map.put("msg", "success");
			}
			map.put("size", itemPdList.size());
    	}catch(Exception e){
    		map.put("msg", "error");
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
	
	/**
	 *批量删除 
	 */
	@RequestMapping(value="delAllForecast")
	@ResponseBody
	public Object delAllForecast(){
		Map<String, Object> map = new HashMap<String, Object>();
		WorkFlow workflow = new WorkFlow();
		PageData pd = new PageData();
		PageData newPd = new PageData();
		PageData delPd = new PageData();
		String forecast_instance_id = "";
		try{
			pd = this.getPageData();
			String ids = pd.get("ids").toString();
			if(ids.lastIndexOf(",")>-1){
				for(String id : ids.split(",")){
					newPd.put("id", id);
					delPd = forecastService.findForecastById(newPd);
					if(delPd.containsKey("forecast_instance_id")){
						forecast_instance_id =  delPd.get("forecast_instance_id").toString();
					}
					if(forecast_instance_id!=null && !"".equals(forecast_instance_id)){
		            	workflow.getRuntimeService().deleteProcessInstance(forecast_instance_id, "删除项目预测信息流程");
		            }
					forecastService.delForecastById(delPd);
					newPd.clear();
				}
			}else{
				newPd.put("id", ids);
				delPd = forecastService.findForecastById(newPd);
				if(delPd.containsKey("forecast_instance_id")){
					forecast_instance_id =  delPd.get("forecast_instance_id").toString();
				}
				if(forecast_instance_id!=null && !"".equals(forecast_instance_id)){
	            	workflow.getRuntimeService().deleteProcessInstance(forecast_instance_id, "删除项目预测信息流程");
	            }
				forecastService.delForecastById(delPd);
				newPd.clear();
			}
			//---保存删除历史记录
			PageData forecastLogPd = new PageData();
			forecastLogPd.put("forecast", ids);
			forecastLogPd.put("type", "delete");
			forecastLogPd.put("user", getUser().getUSER_ID());
			forecastLogPd.put("date",  new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			forecastLogPd.put("descript", "用户"+getUser().getNAME()+"删除了id为"+ids+"的预测信息");
			forecastService.saveForecastLog(forecastLogPd);
			//---
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转至修改 
	 */
	@RequestMapping(value="goEditForecast")
	public ModelAndView goEditForecast(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		List<PageData> itemPdList = new ArrayList<PageData>();
		List<String> itemIdList = new ArrayList<String>();
		boolean allin = true;
		Integer type = getUserRoleType();
		String USER_ID = getUser().getUSER_ID();
		String parentType = "";
		try{
			pd = this.getPageData();
			String operateType = pd.containsKey("operateType")?pd.get("operateType").toString():"sel";
			pd = forecastService.findForecastById(pd);
			pd.put("USER_ID", USER_ID);
			String[] ids = pd.get("item_id").toString().split(",");
			
			List<PageData> nextList = new ArrayList<PageData>();
			if(type==1){//销售人员
				allin = false;
				nextList = itemService.findItemListByInputUser(pd);
			}else if(type==2){//分公司经理
				parentType = "10";
			}else if(type==3){//区域经理
				parentType = "8";
			}else if(type==4){//股份公司
				allin = false;
				nextList = itemService.findItemListByIdList(Arrays.asList(ids));
			}
			if(allin){
				parentDepartments = findAllParentNodeByPosition();
				List<String> userIdList = findAllChildNodeByType(parentDepartments, parentType);
				parentDepartments.clear();
				childDepartments.clear();
				List<String> userList = new ArrayList<String>();
				//过滤掉分公司和区域角色的用户
				for(String userId : userIdList){
					int i = getUserRoleTypeByUserId(userId);
					if(i==1&&type==2){
						userList.add(userId);
					}else if(i==2&&type==3){
						userList.add(userId);
					}
				}
				PageData selForecastPd = new PageData();
				selForecastPd.put("userList", userList);
				selForecastPd.put("month_no", pd.get("month_no").toString());
				if(type==2){
					selForecastPd.put("status", "1");
				}else if(type==3){
					selForecastPd.put("status", "3");
				}
				//查到用户集合本月份的所有预测信息
				List<PageData> forecastPdList = forecastService.findForecastListByUserIdAndMonthNo(selForecastPd);
				for(PageData forecastPd : forecastPdList){
					String item_id = forecastPd.get("item_id").toString();
					if(item_id.lastIndexOf(",")>-1){
						for(String id : item_id.split(",")){
							itemIdList.add(id);
						}
					}else{
						itemIdList.add(item_id);
					}
				}
				nextList = itemService.findItemListByIdList(itemIdList);
			}
			if(nextList!=null){
				itemPdList = setItemPdList(nextList);
			}
			//放入上月预测信息
			List<PageData> frontForecastList = getFrontMonthForecast();
			mv.addObject("frontForecastList",frontForecastList);
			mv.addObject("items", ids);
			mv.addObject("itemPdList", itemPdList);
			mv.addObject("pd", pd);
			mv.addObject("operateType", operateType);
			mv.addObject("msg", "editForecast");
			mv.setViewName("system/forecast/forecast_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存修改 
	 */
	@RequestMapping(value="editForecast")
	public ModelAndView editForecast(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("modified_by", getUser().getUSER_ID());
			forecastService.editForecast(pd);
			//---保存修改历史记录
			PageData forecastLogPd = new PageData();
			forecastLogPd.put("forecast", pd.get("id").toString());
			forecastLogPd.put("type", "edit");
			forecastLogPd.put("user", getUser().getUSER_ID());
			forecastLogPd.put("date",  new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			forecastLogPd.put("descript", "用户"+getUser().getNAME()+"修改了id为"+pd.get("id").toString()+"的预测信息");
			forecastService.saveForecastLog(forecastLogPd);
			//---
			mv.addObject("active", "3");
			mv.addObject("id", "EditForecast");
			mv.addObject("form", "ForecastForm");
			mv.addObject("msg", "success");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *根据userid获取角色类型 
	 */
	public Integer getUserRoleTypeByUserId(String userId){
		String roleIds = "";
		List<String> roleIdList = new ArrayList<String>();
		List<String> typeList = new ArrayList<String>();
		int type = 0;
		try{
			roleIds = sysUserService.findRoleIdByUserId(userId);
			if(roleIds.lastIndexOf(",")>-1){
				for(String id: roleIds.split(",")){
					roleIdList.add(id);
				}
			}else{
				roleIdList.add(roleIds);
			}
			typeList = roleService.findRoleTypeByIds(roleIdList);
			for(String str : typeList){
				int i = Integer.parseInt(str);
				if(i>type){
					type=i;
				}
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return type;
	}
	
	/**
	 *获取登录人角色类型
	 */
	public Integer getUserRoleType(){
		String roleIds = getUser().getROLE_ID();
		List<String> roleIdList = new ArrayList<String>();
		List<String> typeList = new ArrayList<String>();
		int type = 0;
		try{
			if(roleIds.lastIndexOf(",")>-1){
				for(String id: roleIds.split(",")){
					roleIdList.add(id);
				}
			}else{
				roleIdList.add(roleIds);
			}
			typeList = roleService.findRoleTypeByIds(roleIdList);
			for(String str : typeList){
				int i = Integer.parseInt(str);
				if(i>type){
					type=i;
				}
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return type;
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
     *递归获取所有子节点 
     */
    public List<PageData> getAllChildDepartments(PageData pd)throws Exception{
    	List<PageData> childPdList = departmentService.findAllChildDepartment(pd);
    	if(childPdList!=null){
    		for(PageData childPd : childPdList){
        		childDepartments.add(childPd);
        		getAllChildDepartments(childPd);
    		}
    	}
    	return childDepartments;
    }
    
    /**
     *根据当前登录人职位id返回所有的职位父级节点
     */
    public List<PageData> findAllParentNodeByPosition(){
    	try{
        	PageData positionPd = new PageData();
    		String USER_ID = getUser().getUSER_ID();
    		String POSITION_ID = sysUserService.findPositionIdByUserId(USER_ID);
    		positionPd.put("id", POSITION_ID);
    		positionPd = positionService.getPositionById(positionPd);
    		parentDepartments = getAllParentDepartments(positionPd);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return parentDepartments;
    }
    
    /**
     *返回父节点集合中类型为parentType的节点下所有职位关联的用户id集合
     */
    public List<String> findAllChildNodeByType(List<PageData> parentNodes,String parentType){
    	List<String> userIdList = new ArrayList<String>();
		List<String> positionIdList = new ArrayList<String>();
    	try{
    		for(PageData nodePd : parentNodes){
				if(nodePd.get("type").toString().equals(parentType)){
					childDepartments = getAllChildDepartments(nodePd);
					break;
				}
			}
			for(PageData childPd : childDepartments){
				if(childPd.containsKey("type")&&childPd.get("type").toString().equals("9")){
					positionIdList.add(childPd.getString("id").toString());
				}
			}
			childDepartments.clear();
			userIdList = sysUserService.getUserIdByPositionList(positionIdList);
    	}catch(Exception e){
    		
    	}
    	return userIdList;
    }
    
    /**
     *计算项目总台量后重新放入项目集合中 
     */
    public List<PageData> setItemPdList(List<PageData> list){
    	List<PageData> itemPdList = new ArrayList<PageData>();
    	try{
    		Integer count = 0;
    		for(PageData itemPd : list){
				String elevatorInfo = itemService.findElevatorInfoById(itemPd.get("item_id").toString());
				JSONArray obj = JSONArray.fromObject(elevatorInfo);
				if(elevatorInfo!=null){
					Iterator<Object> it = obj.iterator();
					while(it.hasNext()){
						JSONObject jsonObj = (JSONObject)it.next();
						Map<Object, Object> data = (Map)jsonObj;
						count += Integer.parseInt(data.get("elevatorNum").toString());
					}
				}
				itemPd.put("count", count);
				itemPdList.add(itemPd);
				count=0;
			}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return itemPdList;
    }
    
    /**
     *根据当前登录人角色获取本月指标 
     */
    public PageData findQuotaByRoleId(){
    	String monthNo = new SimpleDateFormat("yyyyMM").format(new Date());
    	String quota = "";
    	PageData quotaPd = new PageData();
    	try{
    		PageData pd = new PageData();
    		String USER_ID = getUser().getUSER_ID();
    		pd.put("USER_ID", USER_ID);
    		pd.put("month_no", monthNo);
    		quota = forecastService.findMonthQuotaByUserAndMonth(pd);
    		quotaPd.put("month_quota", quota);
    		pd.put("month_no", new SimpleDateFormat("yyyyMM").format((getNextDate(new Date()))));
    		quota = forecastService.findMonthQuotaByUserAndMonth(pd);
    		quotaPd.put("quota_next", quota);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return quotaPd;
    }
    
    /**
     * 根据当前系统时间和登录人查询上月预测
     */
    public List<PageData> getFrontMonthForecast(){
    	List<PageData> pdList = new ArrayList<PageData>();
    	try{
        	PageData pd = new PageData();
    		String USER_ID = getUser().getUSER_ID();
    		String monthNo = new SimpleDateFormat("yyyyMM").format(getLastDate(new Date()));
    		List<String> userList = new ArrayList<String>();
    		userList.add(USER_ID);
    		pd.put("userList", userList);
    		pd.put("month_no", monthNo);
    		pdList = forecastService.findForecastListByUserIdAndMonthNo(pd);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return pdList;
    }
	
    
    /**
     *获取上个月 
     */
    public Date getLastDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, -1);
        return cal.getTime();
    }
    /**
     *获取下个月 
     */
    public Date getNextDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, +1);
        return cal.getTime();
    }
    
    //列表指标设置
    @RequestMapping(value="listQuota")
    public ModelAndView listQuota(Page page){
    	ModelAndView mv = new ModelAndView();
    	try{
    		List<PageData> quotaList = forecastService.findQuotaList(page);
    		mv.addObject("quotaList", quotaList);
    		mv.setViewName("system/forecast/forecast_quota");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *跳转到指标树形菜单
     */
    @RequestMapping(value="treeListQuota")
    public ModelAndView treeListQuota(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		List<PageData> pdList = forecastService.findQuotaTreeList();
        	if (pdList.size() > 0) {
	            //构建多叉数
	            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	            MultipleTree tree = new MultipleTree();
                HashMap skins = new HashMap();
                skins.put("0","leafSkin");
                for(int i =1;i<15;i++){
                    skins.put(i+"","parentSkin");
                }
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin3(pdList,skins);
	            /*dataList = ConvertPageDataToList.makeWithType(pdList);*/
	            Node node = tree.makeTreeWithOderNo(dataList, 1);
	            mv.addObject("quotas", node);
	        	/*JSONArray obj = JSONArray.fromObject(organizes);
	        	mv.addObject("organizes", obj);*/
        	}
        	mv.setViewName("system/forecast/forecast_quota");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *跳转到设置指标页面 
     */
    @RequestMapping(value="goSetQuota")
    @ResponseBody
    public Object goSetQuota(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		String USER_ID = pd.get("id").toString();
    		List<PageData> quotaList = forecastService.findQuotaByUserId(USER_ID);
    		map.put("quotaList", quotaList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
	
    /**
     *跳转到新增指标 
     */
    @RequestMapping(value="goAddQuota")
    public ModelAndView goAddQuota(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		mv.addObject("pd", pd);
    		mv.addObject("msg","saveQuota");
    		mv.addObject("operateType","add");
    		mv.setViewName("system/forecast/quota_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *跳转到修改指标 
     */
    @RequestMapping(value="goEditQuota")
    public ModelAndView goEditQuota(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		pd = forecastService.findQuotaById(pd.get("id").toString());
    		String month_no = pd.get("month_no").toString();
    		pd.put("year", month_no.substring(0,4));
    		pd.put("month",  month_no.substring(4));
    		mv.addObject("pd", pd);
    		mv.addObject("msg","editQuota");
    		mv.addObject("operateType","edit");
    		mv.setViewName("system/forecast/quota_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *保存新增 
     */
    @RequestMapping(value="saveQuota")
    public ModelAndView saveQuota(){
    	ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		forecastService.saveQuota(pd);
    		mv.addObject("msg", "success");
    		mv.addObject("id", "setQuota");
    		mv.addObject("form", "quotaForm");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *保存修改
     */
    @RequestMapping(value="editQuota")
    public ModelAndView editQuota(){
    	ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		forecastService.editQuota(pd);
    		mv.addObject("msg", "success");
    		mv.addObject("id", "setQuota");
    		mv.addObject("form", "quotaForm");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    @RequestMapping(value="getMonthNoByYear")
    @ResponseBody
    public Object getMonthNoByYear(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		List<String> monthList = forecastService.findMonthNoByYear(pd);
    		map.put("msg", "success");
    		map.put("monthList", monthList);
    	}catch(Exception e){
    		map.put("msg", "error");
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
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    /* ===============================用户================================== */

}
