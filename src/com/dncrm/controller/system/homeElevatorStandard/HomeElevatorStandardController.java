package com.dncrm.controller.system.homeElevatorStandard;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.homeElevatorStandard.HomeElevatorStandardService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.PageData;



@Controller
@RequestMapping(value = "/homeElevatorStandard")
public class HomeElevatorStandardController extends BaseController{

	@Resource(name = "homeElevatorStandardService")
	private HomeElevatorStandardService homeElevatorStandardService;
	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	
	
	
	/**
	 * 家用电梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "homeElevatorStandardList")
	public ModelAndView homeElevatorStandardList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		//家用电梯标准价格
		List<PageData> homeElevatorStandardList = homeElevatorStandardService.listPageHomeElevatorStandard(page);
		mv.addObject("home_standard_name", pd.get("home_standard_name"));
		mv.addObject("pd",pd);
		mv.addObject("homeElevatorStandardList", homeElevatorStandardList);
		mv.setViewName("system/homeElevatorStandard/homeElevatorStandard");
		return mv;
	}
	
	/**
	 * 跳转到家用电梯标准价格添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddHomeElevatorStandard")
	public ModelAndView goAddHomeElevatorStandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", "addHomeElevatorStandard");
		mv.setViewName("system/homeElevatorStandard/homeElevatorStandard_edit");
		return mv;
	}
	
	/**
	 * 家用电梯标准价格保存
	 * @return
	 */
	@RequestMapping(value = "addHomeElevatorStandard")
	public ModelAndView addHomeElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			homeElevatorStandardService.homeElevatorStandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddHomeElevatorStandard");
		mv.addObject("from", "homeElevatorStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到家用电梯标准价格编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditHomeElevatorStandard")
	public ModelAndView goEditHomeElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			
			pd = homeElevatorStandardService.findHomeElevatorStandardById(pd);
			mv.addObject("msg", "editHomeElevatorStandard");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.setViewName("system/homeElevatorStandard/homeElevatorStandard_edit");
		return mv;
	}
	
	/**
	 * 编辑家用电梯标准价格
	 * @return
	 */
	@RequestMapping(value = "editHomeElevatorStandard")
	public ModelAndView editHomeElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			homeElevatorStandardService.homeElevatorStandardEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditHomeElevatorStandard");
		mv.addObject("form", "homeElevatorStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除家用电梯标准价格
	 * @return
	 */
	@RequestMapping(value = "delHomeElevatorStandard")
	public void delHomeElevatorStandard(PrintWriter out){
		PageData pd = this.getPageData();
		
		try {
			homeElevatorStandardService.homeElevatorStandardDeleteById(pd);
			out.write("success");
			out.flush();
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
	}
	
	/**
	 * 批量删除家用电梯标准价格
	 * @return\
	 */
	@RequestMapping(value = "/homeElevatorStandardDeleteAll")
	@ResponseBody
	public Object homeElevatorStandardDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					homeElevatorStandardService.homeElevatorStandardDeleteAll(ArrayDATA_IDS);
					pd.put("msg", "ok");
					pdList.add(pd);
					map.put("list", pdList);
				
			}else{
				pd.put("msg", "no");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}	
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 电梯标准价格名称是否存在
	 * @return
	 *//*
	@RequestMapping(value = "existsElevatorStandardName")
	@ResponseBody
	public Object existsElevatorStandardName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorStandardService.existsElevatorStandardName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯标准价格名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	*//**
	 * 根据速度参数ID查找楼层
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value = "findStoreyBySpeedId")
	@ResponseBody
	public Object findStoreyBySpeedId() throws Exception{
		PageData pd = this.getPageData();
		String elevator_standard_id = pd.getString("elevator_standard_id");//标准价格ID
		//电梯楼层集合
		List<PageData> elevatorStoreyList = elevatorParameterService.findElevatorStoreyListById(pd);
		
		String jsonStr="[";
		//加载电梯楼层参数
		for(PageData elevatorStorey:elevatorStoreyList){
			jsonStr +="{";
			jsonStr +="\"elevator_storey_id\":"+elevatorStorey.get("elevator_storey_id")+",";
			jsonStr +="\"elevator_storey_name\":\""+elevatorStorey.get("elevator_storey_name")+"\",";
			jsonStr +="\"elevator_speed_id\":"+elevatorStorey.get("elevator_speed_id")+",";
			jsonStr = jsonStr.substring(0, jsonStr.length()-1);
			jsonStr += "},";
		}
		if(jsonStr.indexOf(",")>-1){
			jsonStr = jsonStr.substring(0, jsonStr.length()-1);
		}
	
		jsonStr += "]";
		
		
		//加载电梯标准楼层外键
		String jsonStr2 = "[";
		if(elevator_standard_id!=null && !"".equals(elevator_standard_id)){
			List<PageData> elevhomeElevatorStandard = elevatorStandardService.findElevatorStandardListById(pd);
			for(PageData elevatorStandard:elevatorStandardList){
				jsonStr2 += "{";
				jsonStr2 += "\"elevator_storey_id\":"+elevatorStandard.get("elevator_storey_id")+",";
				jsonStr2 = jsonStr2.substring(0, jsonStr2.length()-1);
				jsonStr2 += "},";
			}
			if(jsonStr2.indexOf(",")>-1){
				jsonStr2 = jsonStr2.substring(0, jsonStr2.length()-1);
			}
		}
		jsonStr2 += "]";
		
		Map<String,String> map = new HashMap<>();
		map.put("elevatorStoreyList", jsonStr);
		map.put("elevatorStandardList", jsonStr2);
		return map;
	}*/
}
