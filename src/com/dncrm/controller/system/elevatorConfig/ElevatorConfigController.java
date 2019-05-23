package com.dncrm.controller.system.elevatorConfig;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.elevatorCascade.ElevatorCascadeService;
import com.dncrm.service.system.elevatorConfig.ElevatorConfigService;
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.elevatorUnit.ElevatorUnitService;
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.service.system.models.ModelsService;
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

@Controller
@RequestMapping(value = "/elevatorConfig")
public class ElevatorConfigController extends BaseController{

	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	@Resource(name = "elevatorConfigService")
	private ElevatorConfigService elevatorConfigService;
	
	@Resource(name = "modelsService")
	private ModelsService modelsService;
	
	@Resource(name = "elevatorUnitService")
	private ElevatorUnitService elevatorUnitService;
	
	@Resource(name = "elevatorCascadeService")
	private ElevatorCascadeService elevatorCascadeService;
	
	@Resource(name = "elevatorService")
	private ElevatorService elevatorService;
	
	
	/**
	 * 电梯基础项配置列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorBaseList")
	public ModelAndView elevatorBaseList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		page.setFormNo(0);
		//电梯基础项配置
		List<PageData> elevatorBaseList = elevatorConfigService.listPageElevatorBase(page);
		
		pd.put("isActive1", "1");
		mv.addObject("elevator_base_name", pd.get("elevator_base_name"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorBaseList", elevatorBaseList);
		mv.setViewName("system/elevatorConfig/elevatorConfig");
		return mv;
	}
	
	/**
	 * 跳转到电梯基础项配置添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorBase")
	public ModelAndView goAddElevatorBase() throws Exception{
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", "addElevatorBase");
		mv.addObject("elevatorList",elevatorList);
		mv.setViewName("system/elevatorConfig/elevatorBase_edit");
		return mv;
	}
	
	/**
	 * 电梯基础项配置保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorBase")
	public ModelAndView addElevatorBase(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorConfigService.elevatorBaseAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorBase");
		mv.addObject("from", "elevatorBaseForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯基础项配置编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorBase")
	public ModelAndView goEditElevatorBase(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//电梯类型集合
	    	List<PageData> elevatorList = elevatorService.findAllElevator();
			pd = elevatorConfigService.findElevatorBaseById(pd);
			mv.addObject("elevatorList", elevatorList);
			mv.addObject("msg", "editElevatorBase");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//型号集合
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorConfig/elevatorBase_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯基础项配置
	 * @return
	 */
	@RequestMapping(value = "editElevatorBase")
	public ModelAndView editElevatorBase(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorConfigService.elevatorBaseEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorBase");
		mv.addObject("form", "elevatorBaseForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯基础项配置
	 * @return
	 */
	@RequestMapping(value = "delElevatorBase")
	@ResponseBody
	public Object delElevatorBase(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorConfigService.elevatorBaseDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
		}
		
		return result;
	}
	
	/**
	 * 电梯基础项配置名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorBaseName")
	@ResponseBody
	public Object existsElevatorBaseName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorConfigService.existsElevatorBaseName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯基础项配置名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	
	//********************************电梯可选配置*************************************
	/**
	 * 电梯可选配置列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorOptionalList")
	public ModelAndView elevatorOptionalList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		page.setPd(pd);
		page.setFormNo(1);
		//级联配置
		List<PageData> elevatorCascadeList = elevatorCascadeService.getElevatorCascadeListById(pds);
		
		//加载单位
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pds);
		
		//电梯可选项配置
		List<PageData> elevatorOptionalList = elevatorConfigService.listPageElevatorOptional(page);
		
		pd.put("isActive2", "1");
		mv.addObject("elevator_optional_name", pd.get("elevator_optional_name"));
		mv.addObject("elevator_id", pd.get("elevator_id"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.addObject("elevatorCascadeList", elevatorCascadeList);
		mv.addObject("elevatorOptionalList", elevatorOptionalList);
		
		mv.setViewName("system/elevatorConfig/elevatorConfig");
		return mv;
	}
	
	/**
	 * 跳转到电梯可选配置添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorOptional")
	public ModelAndView goAddElevatorOptional() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		PageData pd = new PageData();
		pd.put("elevator_id", "1");
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
		//加载单位
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pds);
		
		//加载级联功能
		List<PageData> elevatorCascadeList = elevatorCascadeService.listAllElevatorCascadeByElevatorId(pd);
		if(elevatorCascadeList.size()>0){
			List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
			MultipleTree tree = new MultipleTree();
			dataList = ConvertPageDataToList.make(elevatorCascadeList);
			Node node = tree.makeTreeWithOderNo(dataList, 1);
    		mv.addObject("elevatorCascadeList", node);
		}else{
			mv.addObject("elevatorCascadeList", elevatorCascadeList);
		}
		mv.addObject("elevatorList", elevatorList);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.addObject("msg", "addElevatorOptional");
		mv.setViewName("system/elevatorConfig/elevatorOptional_edit");
		return mv;
	}
	
	/**
	 * 根据选择楼梯类型加载可选配置信息列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("elevatorOptionalListByElevatorId")
	@ResponseBody
	public void elevatorOptionalListByElevatorId(HttpServletRequest request,HttpServletResponse response){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		Map<String,Object> map = new  HashMap<String, Object>();
		String str = "";
		try{
		//加载级联功能
		List<PageData> elevatorCascadeList = elevatorCascadeService.listAllElevatorCascadeByElevatorId(pd);
		if(elevatorCascadeList.size()>0){
			List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
			MultipleTree tree = new MultipleTree();
			dataList = ConvertPageDataToList.make(elevatorCascadeList);
			Node node = tree.makeTreeWithOderNo(dataList, 1);
			str = node.toString();
			result.put("elevatorCascadeList", node.toString());
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.print(str);
			out.flush();
			out.close();
		}
		}catch(Exception e){
			System.out.println(e.getMessage());
			logger.error(e.getMessage(), e);
		}
		
		
		
		
	}
	
	/**
	 * 电梯可选配置保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorOptional")
	public ModelAndView addElevatorOptional(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//获取当前子类的所有父类菜单
			pd = elevatorConfigService.findAllParentMenu(pd);
			elevatorConfigService.elevatorOptionalAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorOptional");
		mv.addObject("from", "elevatorOptionalForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯可选配置编辑页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goEditElevatorOptional")
	public ModelAndView goEditElevatorOptional() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
		//加载单位
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pds);
		//加载级联功能
		List<PageData> elevatorCascadeList = elevatorCascadeService.listAllElevatorCascade();
		if(elevatorCascadeList.size()>0){
			List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
			MultipleTree tree = new MultipleTree();
			dataList = ConvertPageDataToList.make(elevatorCascadeList);
			Node node = tree.makeTreeWithOderNo(dataList, 1);
    		mv.addObject("elevatorCascadeList", node);
		}else{
			mv.addObject("elevatorCascadeList", elevatorCascadeList);
		}
		
		try {
			pd = elevatorConfigService.findElevatorOptionalById(pd);
			mv.addObject("msg", "editElevatorOptional");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("elevatorList",elevatorList);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorConfig/elevatorOptional_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯可选配置
	 * @return
	 */
	@RequestMapping(value = "editElevatorOptional")
	public ModelAndView editElevatorOptional(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//获取当前子类的所有父类菜单
			pd = elevatorConfigService.findAllParentMenu(pd);
			elevatorConfigService.elevatorOptionalEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorOptional");
		mv.addObject("form", "elevatorOptionalForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯可选配置
	 * @return
	 */
	@RequestMapping(value = "delElevatorOptional")
	@ResponseBody
	public Object delElevatorOptional(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorConfigService.elevatorOptionalDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
		}
		
		return result;
	}
	
	/**
	 * 电梯可选配置名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorOptionalName")
	@ResponseBody
	public Object existsElevatorOptionalName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorConfigService.existsElevatorOptionalName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯可选配置名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	
	//********************************电梯非标配置*************************************
	/**
	 * 电梯非标配置列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorNonstandardList")
	public ModelAndView elevatorNonstandardList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		page.setPd(pd);
		page.setFormNo(2);
		
		//级联配置
		List<PageData> elevatorCascadeList = elevatorCascadeService.getElevatorCascadeListById(pds);
		
		//加载单位
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pds);
		
		//电梯非标配置
		List<PageData> elevatorNonstandardList = elevatorConfigService.listPageElevatorNonstandard(page);
		
		
		pd.put("isActive3", "1");
		mv.addObject("elevator_nonstandard_name", pd.get("elevator_nonstandard_name"));
		mv.addObject("elevator_nonstandard_state", pd.get("elevator_nonstandard_state"));
		
		mv.addObject("pd",pd);
		
		mv.addObject("elevatorCascadeList", elevatorCascadeList);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.addObject("elevatorNonstandardList", elevatorNonstandardList);
		mv.setViewName("system/elevatorConfig/elevatorConfig");
		return mv;
	}
	
	/**
	 * 跳转到电梯非标配置添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorNonstandard")
	public ModelAndView goAddElevatorNonstandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		
		//加载单位
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pds);
		
		//加载级联功能
		List<PageData> elevatorCascadeList = elevatorCascadeService.listAllElevatorCascade();
		
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
    	
		if(elevatorCascadeList.size()>0){
			List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
			MultipleTree tree = new MultipleTree();
			dataList = ConvertPageDataToList.make(elevatorCascadeList);
			Node node = tree.makeTreeWithOderNo(dataList, 1);
    		mv.addObject("elevatorCascadeList", node);
		}else{
			mv.addObject("elevatorCascadeList", elevatorCascadeList);
		}
		mv.addObject("elevatorList", elevatorList);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.addObject("msg", "addElevatorNonstandard");
		mv.setViewName("system/elevatorConfig/elevatorNonstandard_edit");
		return mv;
	}
	
	/**
	 * 电梯非标配置保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorNonstandard")
	public ModelAndView addElevatorNonstandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//获取当前子类的所有父类菜单
			pd = elevatorConfigService.findAllParentMenu(pd);
			elevatorConfigService.elevatorNonstandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorNonstandard");
		mv.addObject("from", "elevatorNonstandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯非标配置编辑页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goEditElevatorNonstandard")
	public ModelAndView goEditElevatorNonstandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		//加载单位
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pds);
		//加载级联功能
		List<PageData> elevatorCascadeList = elevatorCascadeService.listAllElevatorCascade();
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
		if(elevatorCascadeList.size()>0){
			List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
			MultipleTree tree = new MultipleTree();
			dataList = ConvertPageDataToList.make(elevatorCascadeList);
			Node node = tree.makeTreeWithOderNo(dataList, 1);
    		mv.addObject("elevatorCascadeList", node);
		}else{
			mv.addObject("elevatorCascadeList", elevatorCascadeList);
		}
		try {
			
			pd = elevatorConfigService.findElevatorNonstandardById(pd);
			mv.addObject("msg", "editElevatorNonstandard");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("elevatorList", elevatorList);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorConfig/elevatorNonstandard_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯非标配置
	 * @return
	 */
	@RequestMapping(value = "editElevatorNonstandard")
	public ModelAndView editElevatorNonstandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//获取当前子类的所有父类菜单
			pd = elevatorConfigService.findAllParentMenu(pd);
			elevatorConfigService.elevatorNonstandardEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorNonstandard");
		mv.addObject("form", "elevatorNonstandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯非标配置
	 * @return
	 */
	@RequestMapping(value = "delElevatorNonstandard")
	@ResponseBody
	public Object delElevatorNonstandard(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorConfigService.elevatorNonstandardDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
		}
		
		return result;
	}
	
	/**
	 * 电梯非标配置名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorNonstandardName")
	@ResponseBody
	public Object existsElevatorNonstandardName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorConfigService.existsElevatorNonstandardName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯非标配置名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	
	
	 /**
		 *导出到Excel 
		 */
		@RequestMapping(value="toExcel")
		public ModelAndView toExcel(){
			PageData pd = this.getPageData();
			ModelAndView mv = new ModelAndView();
			try{
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				//电梯基础配置
				if(pd.get("type").equals("1")){
					titles.add("基础配置编号");
					titles.add("基础配置名称");
					titles.add("基础配置描述");
					titles.add("所属电梯类型");
					dataMap.put("titles", titles);
					List<PageData> itemList = elevatorConfigService.findElevatorBaseListById(pd);
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).getString("elevator_base_id"));
						vpd.put("var2", itemList.get(i).getString("elevator_base_name"));
						vpd.put("var3", itemList.get(i).getString("elevator_base_description"));
						vpd.put("var4", itemList.get(i).getString("elevator_name"));
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}else if(pd.get("type").equals("2")){
					//电梯重量参数导出
					titles.add("一级菜单ID");
					titles.add("二级菜单ID");
					titles.add("三级菜单ID");
					titles.add("四级菜单ID");
					titles.add("级联菜单外键");
					titles.add("可选配置价格");
					titles.add("可选配置类型外键");
					titles.add("交货期");
					titles.add("描述");
					titles.add("楼梯类型外键");
					titles.add("收费类型");
					dataMap.put("titles", titles);
					List<PageData> itemList = elevatorConfigService.findElevatorOptionalListById(pd);
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).getString("one_menu_id"));
						vpd.put("var2", itemList.get(i).getString("two_menu_id"));
						vpd.put("var3", itemList.get(i).getString("three_menu_id"));
						vpd.put("var4", itemList.get(i).getString("four_menu_id"));
						vpd.put("var5", itemList.get(i).getString("id"));
						vpd.put("var6", itemList.get(i).getString("elevator_optional_price"));
						vpd.put("var7", itemList.get(i).get("elevator_unit_id").toString());
						vpd.put("var8", itemList.get(i).getString("elevator_optional_delivery"));
						vpd.put("var9", itemList.get(i).getString("elevator_optional_description"));
						vpd.put("var10", itemList.get(i).getString("elevator_id"));
						vpd.put("var11", itemList.get(i).getString("elevator_optional_type"));
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}else if(pd.get("type").equals("3")){
					//电梯楼层参数导出
					titles.add("楼层参数");
					titles.add("标准提升高度");
					titles.add("速度参数ID");
					titles.add("电梯类型ID");
					dataMap.put("titles", titles);
					List<PageData> itemList = elevatorParameterService.findElevatorStoreyListById(pd);
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).get("elevator_storey_name"));
						vpd.put("var2", itemList.get(i).getString("elevator_height_name"));
						vpd.put("var3", itemList.get(i).get("elevator_speed_id").toString());
						vpd.put("var4", itemList.get(i).getString("elevator_id"));
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}
				
				
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
			PageData pd = this.getPageData();
			try{
				if(file!=null && !file.isEmpty()){
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					PageData pds = new PageData();
					//速度参数导入
					if(pd.get("type").equals("1")){
						for(int i = 0;i<listPd.size();i++){
							if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals("")){
								pds.put("elevator_speed_name", listPd.get(i).getString("var0"));//
								String elevator_id=listPd.get(i).getString("var1");
								if(elevator_id.equals("常规梯"))
								{
									pds.put("elevator_id", "1");
								}
								else if(elevator_id.equals("家用梯"))
								{
									pds.put("elevator_id", "2");
								}
								else if(elevator_id.equals("特种梯"))
								{
									pds.put("elevator_id", "3");
								}
								else if(elevator_id.equals("扶梯"))
								{
									pds.put("elevator_id", "4");
								}
								else
								{
									map.put("msg2", "error");
					        		map.remove("msg");
					        		map.put("error", "在第"+(i+1)+"行，存在错误。");
					        		break;
								}
								//保存速度参数至数据库
								elevatorParameterService.elevatorSpeedAdd(pds);
								map.put("success", true);
							}
						}
					}else if(pd.get("type").equals("2")){
						for(int i = 0;i<listPd.size();i++){
							if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals("")){
								pds.put("elevator_weight_name", listPd.get(i).getString("var0"));//
								pds.put("elevator_id", listPd.get(i).getString("var1"));//
								//保存重量参数至数据库
								elevatorParameterService.elevatorWeightAdd(pds);
								map.put("success", true);
							}
						}
					}else if(pd.get("type").equals("3")){
						for(int i = 0;i<listPd.size();i++){
							if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals("")){
								pds.put("elevator_storey_name", listPd.get(i).getString("var0"));//
								pds.put("elevator_height_name", listPd.get(i).getString("var1"));//
								pds.put("elevator_speed_id", listPd.get(i).getString("var2"));//
								pds.put("elevator_id", listPd.get(i).getString("var3"));//
								//保存楼层至数据库
								elevatorParameterService.elevatorStoreyAdd(pds);
								map.put("success", true);
							}
						}
					}
					
		    	}else{
		    		map.put("errorMsg", "上传失败");
		    	}
			}catch(Exception e){
				map.put("errorMsg", "上传失败");
				logger.error(e.getMessage(), e);
			}
			return JSONObject.fromObject(map);
		}
	
	
	
}
