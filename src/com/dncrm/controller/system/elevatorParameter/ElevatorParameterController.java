package com.dncrm.controller.system.elevatorParameter;

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
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.util.Const;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/elevatorParameter")
public class ElevatorParameterController extends BaseController{

	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	@Resource(name = "elevatorService")
	private ElevatorService elevatorService;
	
	/**
	 * 电梯速度参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorSpeedList")
	public ModelAndView elevatorSpeedList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		page.setFormNo(0);
		//电梯速度参数
		List<PageData> elevatorSpeedList = elevatorParameterService.listPageElevatorSpeed(page);
		pd.put("isActive1", "1");
		mv.addObject("elevator_speed_name", pd.get("elevator_speed_name"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.setViewName("system/elevatorParameter/elevatorParameter");
		return mv;
	}
	
	/**
	 * 跳转到电梯速度参数添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorSpeed")
	public ModelAndView goAddElevatorSpeed() throws Exception{
		ModelAndView mv = new ModelAndView();
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
    	mv.addObject("elevatorList", elevatorList);
		mv.addObject("msg", "addElevatorSpeed");
		mv.setViewName("system/elevatorParameter/elevatorSpeed_edit");
		return mv;
	}
	
	/**
	 * 电梯速度参数保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorSpeed")
	public ModelAndView addElevatorSpeed(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorSpeedAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorSpeed");
		mv.addObject("from", "elevatorSpeedForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯速度参数编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorSpeed")
	public ModelAndView goEditElevatorSpeed(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//电梯类型集合
	    	List<PageData> elevatorList = elevatorService.findAllElevator();
	    	mv.addObject("elevatorList", elevatorList);
			pd = elevatorParameterService.findElevatorSpeedById(pd);
			mv.addObject("msg", "editElevatorSpeed");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorParameter/elevatorSpeed_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯速度参数
	 * @return
	 */
	@RequestMapping(value = "editElevatorSpeed")
	public ModelAndView editElevatorSpeed(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorSpeedEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorSpeed");
		mv.addObject("form", "elevatorSpeedForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯速度参数
	 * @return
	 */
	@RequestMapping(value = "delElevatorSpeed")
	@ResponseBody
	public Object delElevatorSpeed(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorParameterService.elevatorSpeedDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
		}
		
		return result;
	}
	
	/**
	 * 电梯速度参数名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorSpeedName")
	@ResponseBody
	public Object existsElevatorSpeedName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorParameterService.existsElevatorSpeedName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯速度参数名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	
	//********************************电梯重量参数*************************************
	/**
	 * 电梯重量参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorWeightList")
	public ModelAndView elevatorWeightList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		page.setFormNo(1);
		//电梯速度参数
		List<PageData> elevatorWeightList = elevatorParameterService.listPageElevatorWeight(page);
		pd.put("isActive2", "1");
		mv.addObject("elevator_weight_name", pd.get("elevator_weight_name"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.setViewName("system/elevatorParameter/elevatorParameter");
		return mv;
	}
	
	/**
	 * 跳转到电梯重量参数添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorWeight")
	public ModelAndView goAddElevatorWeight() throws Exception{
		ModelAndView mv = new ModelAndView();
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
    	mv.addObject("elevatorList", elevatorList);
		mv.addObject("msg", "addElevatorWeight");
		mv.setViewName("system/elevatorParameter/elevatorWeight_edit");
		return mv;
	}
	
	/**
	 * 电梯重量参数保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorWeight")
	public ModelAndView addElevatorWeight(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorWeightAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorWeight");
		mv.addObject("from", "elevatorWeightForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯重量参数编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorWeight")
	public ModelAndView goEditElevatorWeight(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//电梯类型集合
	    	List<PageData> elevatorList = elevatorService.findAllElevator();
	    	mv.addObject("elevatorList", elevatorList);
			pd = elevatorParameterService.findElevatorWeightById(pd);
			mv.addObject("msg", "editElevatorWeight");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorParameter/elevatorWeight_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯重量参数
	 * @return
	 */
	@RequestMapping(value = "editElevatorWeight")
	public ModelAndView editElevatorWeight(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorWeightEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorWeight");
		mv.addObject("form", "elevatorWeightForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯重量参数
	 * @return
	 */
	@RequestMapping(value = "delElevatorWeight")
	@ResponseBody
	public Object delElevatorWeight(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorParameterService.elevatorWeightDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
		}
		
		return result;
	}
	
	/**
	 * 电梯重量参数名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorWeightName")
	@ResponseBody
	public Object existsElevatorWeightName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorParameterService.existsElevatorWeightName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯重量参数名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	
	//********************************电梯楼层参数*************************************
	/**
	 * 电梯楼层参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorStoreyList")
	public ModelAndView elevatorStoreyList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		page.setPd(pd);
		page.setFormNo(2);
		//电梯楼层参数
		List<PageData> elevatorStoreyList = elevatorParameterService.listPageElevatorStorey(page);
		//电梯速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		
		pd.put("isActive3", "1");
		mv.addObject("elevator_storey_name", pd.get("elevator_storey_name"));
		mv.addObject("elevator_speed_id",pd.get("elevator_speed_id"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorStoreyList", elevatorStoreyList);
		mv.setViewName("system/elevatorParameter/elevatorParameter");
		return mv;
	}
	
	/**
	 * 跳转到电梯楼层参数添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorStorey")
	public ModelAndView goAddElevatorStorey() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
    	mv.addObject("elevatorList", elevatorList);
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("msg", "addElevatorStorey");
		mv.setViewName("system/elevatorParameter/elevatorStorey_edit");
		return mv;
	}
	
	/**
	 * 电梯楼层参数保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorStorey")
	public ModelAndView addElevatorStorey(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorStoreyAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorStorey");
		mv.addObject("from", "elevatorStoreyForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯楼层参数编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorStorey")
	public ModelAndView goEditElevatorStorey(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		List<PageData> elevatorSpeedList=null;
		try {
			//电梯速度集合
			elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pd);
			pd = elevatorParameterService.findElevatorStoreyById(pd);
			//电梯类型集合
	    	List<PageData> elevatorList = elevatorService.findAllElevator();
	    	mv.addObject("elevatorList", elevatorList);
			mv.addObject("msg", "editElevatorStorey");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("elevatorSpeedList",elevatorSpeedList);
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorParameter/elevatorStorey_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯楼层参数
	 * @return
	 */
	@RequestMapping(value = "editElevatorStorey")
	public ModelAndView editElevatorStorey(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorStoreyEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorStorey");
		mv.addObject("form", "elevatorStoreyForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯楼层参数
	 * @return
	 */
	@RequestMapping(value = "delElevatorStorey")
	@ResponseBody
	public Object delElevatorStorey(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorParameterService.elevatorStoreyDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
		}
		
		return result;
	}
	
	/**
	 * 电梯楼层参数名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorStoreyName")
	@ResponseBody
	public Object existsElevatorStoreyName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorParameterService.existsElevatorStoreyName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "电梯楼层参数名称已重复,请从新输入");
			}else{
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}
	
	
	//********************************井道总高(含顶层和底坑)，高度增加一米（RMB）*************************************
	
	/**
	 * 井道总高列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorHeightList")
	public ModelAndView elevatorHeightList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		page.setPd(pd);
		page.setFormNo(3);
		//井道总高集合
		List<PageData> elevatorHeightList = elevatorParameterService.listPageElevatorHeight(page);
		//电梯速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//电梯重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		
		pd.put("isActive4", "1");
		mv.addObject("elevator_height_money", pd.get("elevator_height_money"));
		mv.addObject("elevator_speed_id",pd.get("elevator_speed_id"));
		mv.addObject("elevator_weight_id",pd.get("elevator_weight_id"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorHeightList", elevatorHeightList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.setViewName("system/elevatorParameter/elevatorParameter");
		return mv;
	}
	
	/**
	 * 跳转到电梯井道总高参数添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorHeight")
	public ModelAndView goAddElevatorHeight() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		//电梯速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//电梯重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		//电梯类型集合
    	List<PageData> elevatorList = elevatorService.findAllElevator();
    	mv.addObject("elevatorList", elevatorList);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("msg", "addElevatorHeight");
		mv.setViewName("system/elevatorParameter/elevatorHeight_edit");
		return mv;
	}
	
	/**
	 * 电梯井道总高参数保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorHeight")
	public ModelAndView addElevatorHeight(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorHeightAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorHeight");
		mv.addObject("from", "elevatorHeightForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯井道总高参数编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorHeight")
	public ModelAndView goEditElevatorHeight(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		List<PageData> elevatorSpeedList=null;
		List<PageData> elevatorWeightList=null;
		try {
			//电梯速度集合
			elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pd);
			//电梯重量集合
			elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pd);
			//电梯类型集合
	    	List<PageData> elevatorList = elevatorService.findAllElevator();
	    	mv.addObject("elevatorList", elevatorList);
			pd = elevatorParameterService.findElevatorHeightById(pd);
			mv.addObject("msg", "editElevatorHeight");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorSpeedList",elevatorSpeedList);
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorParameter/elevatorHeight_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯井道总高参数
	 * @return
	 */
	@RequestMapping(value = "editElevatorHeight")
	public ModelAndView editElevatorHeight(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorParameterService.elevatorHeightEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorHeight");
		mv.addObject("form", "elevatorHeightForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯井道总高参数
	 * @return
	 */
	@RequestMapping(value = "delElevatorHeight")
	@ResponseBody
	public Object delElevatorHeight(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			elevatorParameterService.elevatorHeightDeleteById(pd);
			result.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", "删除失败");
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
			//电梯速度参数导出
			if(pd.get("type").equals("1")){
				titles.add("电梯速度参数ID");
				titles.add("电梯速度参数(m/s)");
				titles.add("电梯类型");
				dataMap.put("titles", titles);
				List<PageData> itemList = elevatorParameterService.findElevatorSpeedListById(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).get("elevator_speed_id").toString());
					vpd.put("var2", itemList.get(i).getString("elevator_speed_name"));
					vpd.put("var3", itemList.get(i).getString("elevator_name"));
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();
				mv = new ModelAndView(erv, dataMap);
			}else if(pd.get("type").equals("2")){
				//电梯重量参数导出
				titles.add("电梯重量参数id");
				titles.add("电梯重量参数(KG)");
				titles.add("电梯类型");
				dataMap.put("titles", titles);
				List<PageData> itemList = elevatorParameterService.findElevatorWeightListById(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).get("elevator_weight_id").toString());
					vpd.put("var2", itemList.get(i).get("elevator_weight_name"));
					vpd.put("var3", itemList.get(i).getString("elevator_name"));
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();
				mv = new ModelAndView(erv, dataMap);
			}else if(pd.get("type").equals("3")){
				//电梯楼层参数导出
				titles.add("id");
				titles.add("楼层参数");
				titles.add("标准提升高度");
				titles.add("速度参数");
				titles.add("电梯类型");
				dataMap.put("titles", titles);
				List<PageData> itemList = elevatorParameterService.findElevatorStoreyListById(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).get("elevator_storey_id").toString());
					vpd.put("var2", itemList.get(i).get("elevator_storey_name"));
					vpd.put("var3", itemList.get(i).getString("elevator_height_name"));
					vpd.put("var4", itemList.get(i).get("elevator_speed_name").toString());
					vpd.put("var5", itemList.get(i).getString("elevator_name"));
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
								pds.put("elevator_id", "1");//
							}
							else if(elevator_id.equals("家用梯"))
							{
								pds.put("elevator_id", "2");//
							}
							else if(elevator_id.equals("特种梯"))
							{
								pds.put("elevator_id", "3");//
							}
							else if(elevator_id.equals("扶梯"))
							{
								pds.put("elevator_id", "4");//
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
							pds.put("elevator_weight_name", listPd.get(i).getString("var0"));
							String elevator_id=listPd.get(i).getString("var1");
							if(elevator_id.equals("常规梯"))
							{
								pds.put("elevator_id", "1");//
							}
							else if(elevator_id.equals("家用梯"))
							{
								pds.put("elevator_id", "2");//
							}
							else if(elevator_id.equals("特种梯"))
							{
								pds.put("elevator_id", "3");//
							}
							else if(elevator_id.equals("扶梯"))
							{
								pds.put("elevator_id", "4");//
							}
							else 
							{
								map.put("msg2", "error");
				        		map.remove("msg");
				        		map.put("error", "在第"+(i+1)+"行，存在错误。");
				        		break;
							}
							//保存重量参数至数据库
							elevatorParameterService.elevatorWeightAdd(pds);
							map.put("success", true);
						}
					}
				}else if(pd.get("type").equals("3")){
					for(int i = 0;i<listPd.size();i++){
						if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals(""))
						{
							String elevator_speed_id=listPd.get(i).getString("var2");//电梯速度参数
							PageData speedPd=new PageData();
							speedPd.put("elevator_speed_id", elevator_speed_id);
							PageData speed=elevatorParameterService.findSpeedByName(speedPd);
							if(speed!=null)
							{
								pds.put("elevator_storey_name", listPd.get(i).getString("var0"));
								pds.put("elevator_height_name", listPd.get(i).getString("var1"));
								pds.put("elevator_speed_id", speed.getString("elevator_speed_id"));
								String elevator_id=listPd.get(i).getString("var3");
								if(elevator_id.equals("常规梯"))
								{
									pds.put("elevator_id", "1");//
								}
								else if(elevator_id.equals("家用梯"))
								{
									pds.put("elevator_id", "2");//
								}
								else if(elevator_id.equals("特种梯"))
								{
									pds.put("elevator_id", "3");//
								}
								else if(elevator_id.equals("扶梯"))
								{
									pds.put("elevator_id", "4");//
								}
								else 
								{
									map.put("msg2", "error");
					        		map.remove("msg");
					        		map.put("error", "在第"+(i+1)+"行，存在错误。");
					        		break;
								}
								//保存楼层至数据库
								elevatorParameterService.elevatorStoreyAdd(pds);
								map.put("success", true);
							}
							else
							{
								map.put("msg2", "error");
				        		map.remove("msg");
				        		map.put("error", "在第"+(i+1)+"行，存在错误。");
				        		break;
							}
							
						}
					}
				}
				
	    	}else{
	    		map.put("errorMsg", "上传失败");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
}
