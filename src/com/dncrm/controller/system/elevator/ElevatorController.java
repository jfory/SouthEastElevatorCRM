package com.dncrm.controller.system.elevator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.offer.OfferService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;


@Controller
@RequestMapping(value="elevator")
public class ElevatorController extends BaseController {
	
	@Resource(name="offerService")
	private OfferService offerService;
	
	
	/**
	 *导出tb_elevator 
	 */
	@RequestMapping(value="toExcelElevator")
	public ModelAndView toExcelElevator(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯id");
			titles.add("电梯名称");
			titles.add("电梯描述");
			titles.add("电梯状态");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorList = offerService.findElevatorList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorList.get(i).containsKey("elevator_id")?elevatorList.get(i).get("elevator_id").toString():"");
				vpd.put("var2", elevatorList.get(i).containsKey("elevator_name")?elevatorList.get(i).get("elevator_name").toString():"");
				vpd.put("var3", elevatorList.get(i).containsKey("elevator_descript")?elevatorList.get(i).get("elevator_descript").toString():"");
				vpd.put("var4", elevatorList.get(i).containsKey("elevator_status")?elevatorList.get(i).get("elevator_status").toString():"");
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
	 *导入tb_elevator 
	 */
	@RequestMapping(value="importExcelElevator")
	@ResponseBody
	public Object importExcelElevator(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("elevator_id", listPd.get(i).get("var0").toString());
    	        	pd.put("elevator_name", listPd.get(i).get("var1").toString());
    	        	pd.put("elevator_descript", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_status", listPd.get(i).get("var3").toString());
    	        	//保存至数据库
    	        	offerService.saveElevator(pd);
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
	 *导出tb_elevator_audit 
	 */
	@RequestMapping(value="toExcelElevatorAudit")
	public ModelAndView toExcelElevatorAudit(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("审查id");
			titles.add("电梯id");
			titles.add("电梯种类审核状态");
			titles.add("电梯种类流程实例id");
			titles.add("创建时间");
			titles.add("请求人id");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorAuditList = offerService.findElevatorAuditList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorAuditList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorAuditList.get(i).containsKey("elevator_approval_id")?elevatorAuditList.get(i).get("elevator_approval_id").toString():"");
				vpd.put("var2", elevatorAuditList.get(i).containsKey("id")?elevatorAuditList.get(i).get("id").toString():"");
				vpd.put("var3", elevatorAuditList.get(i).containsKey("elevator_approval")?elevatorAuditList.get(i).get("elevator_approval").toString():"");
				vpd.put("var4", elevatorAuditList.get(i).containsKey("elevator_instance_id")?elevatorAuditList.get(i).get("elevator_instance_id").toString():"");
				vpd.put("var5", elevatorAuditList.get(i).containsKey("create_time")?elevatorAuditList.get(i).get("create_time").toString():"");
				vpd.put("var6", elevatorAuditList.get(i).containsKey("requester_id")?elevatorAuditList.get(i).get("requester_id").toString():"");
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
	 *导入tb_elevator_audit 
	 */
	@RequestMapping(value="importExcelElevatorAudit")
	@ResponseBody
	public Object importExcelElevatorAudit(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("id", listPd.get(i).get("var1").toString());
    	        	pd.put("elevator_approval", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_instance_id", listPd.get(i).get("var3").toString());
    	        	pd.put("create_time", listPd.get(i).get("var4").toString());
    	        	pd.put("requester_id", listPd.get(i).get("var5").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorAudit(pd);
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
	 *导出tb_elevator_base
	 */
	@RequestMapping(value="toExcelElevatorBase")
	public ModelAndView toExcelElevatorBase(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("基础项配置id");
			titles.add("基础项配置名称");
			titles.add("说明");
			titles.add("电梯id");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorBaseList = offerService.findElevatorBaseList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorBaseList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorBaseList.get(i).containsKey("elevator_base_id")?elevatorBaseList.get(i).get("elevator_base_id").toString():"");
				vpd.put("var2", elevatorBaseList.get(i).containsKey("elevator_base_name")?elevatorBaseList.get(i).get("elevator_base_name").toString():"");
				vpd.put("var3", elevatorBaseList.get(i).containsKey("elevator_base_description")?elevatorBaseList.get(i).get("elevator_base_description").toString():"");
				vpd.put("var4", elevatorBaseList.get(i).containsKey("elevator_id")?elevatorBaseList.get(i).get("elevator_id").toString():"");
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
	 *导入tb_elevator_base 
	 */
	@RequestMapping(value="importExcelElevatorBase")
	@ResponseBody
	public Object importElevatorBase(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("elevator_base_id", listPd.get(i).get("var0").toString());
    	        	pd.put("elevator_base_name", listPd.get(i).get("var1").toString());
    	        	pd.put("elevator_base_description", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var3").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorBase(pd);
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
	 *导出tb_elevator_details(电梯信息)
	 */
	@RequestMapping(value="toExcelElevatorDetails")
	public ModelAndView toExcelElevatorDetails(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯id");
			titles.add("电梯编号");
			titles.add("项目id");
			titles.add("电梯类型id");
			titles.add("电梯所属产品线");
			titles.add("电梯型号id");
			titles.add("电梯总额");
			titles.add("标记");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorDetailsList = offerService.findElevatorDetailsList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorDetailsList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorDetailsList.get(i).containsKey("id")?elevatorDetailsList.get(i).get("id").toString():"");
				vpd.put("var2", elevatorDetailsList.get(i).containsKey("no")?elevatorDetailsList.get(i).get("no").toString():"");
				vpd.put("var3", elevatorDetailsList.get(i).containsKey("item_id")?elevatorDetailsList.get(i).get("item_id").toString():"");
				vpd.put("var4", elevatorDetailsList.get(i).containsKey("elevator_id")?elevatorDetailsList.get(i).get("elevator_id").toString():"");
				vpd.put("var5", elevatorDetailsList.get(i).containsKey("product_id")?elevatorDetailsList.get(i).get("product_id").toString():"");
				vpd.put("var6", elevatorDetailsList.get(i).containsKey("models_id")?elevatorDetailsList.get(i).get("models_id").toString():"");
				vpd.put("var7", elevatorDetailsList.get(i).containsKey("total")?elevatorDetailsList.get(i).get("total").toString():"");
				vpd.put("var8", elevatorDetailsList.get(i).containsKey("flag")?elevatorDetailsList.get(i).get("flag").toString():"");
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
	 *导入tb_elevator_details
	 */
	@RequestMapping(value="importExcelElevatorDetails")
	@ResponseBody
	public Object importExcelElevatorDetails(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("no", listPd.get(i).get("var1").toString());
    	        	pd.put("item_id", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var3").toString());
    	        	pd.put("models_id", listPd.get(i).get("var4").toString());
    	        	pd.put("total", listPd.get(i).get("var5").toString());
    	        	pd.put("flag", listPd.get(i).get("var6").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorDetails(pd);
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
	 *导出tb_elevator_hight 
	 */
	@RequestMapping(value="toExcelElevatorHeight")
	public ModelAndView toExcelElevatorHight(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("井道高度id");
			titles.add("金额");
			titles.add("电梯速度id");
			titles.add("电梯重量id");
			titles.add("电梯id");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorHeightList = offerService.findElevatorHeightList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorHeightList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorHeightList.get(i).containsKey("elevator_height_id")?elevatorHeightList.get(i).get("elevator_height_id").toString():"");
				vpd.put("var2", elevatorHeightList.get(i).containsKey("elevator_height_money")?elevatorHeightList.get(i).get("elevator_height_money").toString():"");
				vpd.put("var3", elevatorHeightList.get(i).containsKey("elevator_speed_id")?elevatorHeightList.get(i).get("elevator_speed_id").toString():"");
				vpd.put("var4", elevatorHeightList.get(i).containsKey("elevator_weight_id")?elevatorHeightList.get(i).get("elevator_weight_id").toString():"");
				vpd.put("var5", elevatorHeightList.get(i).containsKey("elevator_id")?elevatorHeightList.get(i).get("elevator_id").toString():"");
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
	 *导入tb_elevator_height 
	 */
	@RequestMapping(value="importExcelElevatorHeight")
	@ResponseBody
	public Object importExcelElevatorHeight(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("elevator_height_money", listPd.get(i).get("var1").toString());
    	        	pd.put("elevator_speed_id", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_weight_id", listPd.get(i).get("var3").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var4").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorHeight(pd);
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
	 * 导出tb_elevator_info
	 */
	@RequestMapping(value="toExcelElevatorInfo")
	public ModelAndView toExcelElevatorInfo(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯详情id");
			titles.add("项目id");
			titles.add("电梯id");
			titles.add("电梯型号id");
			titles.add("电梯数量");
			titles.add("电梯总价");
			titles.add("标记");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorInfoList = offerService.findElevatorInfoList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorInfoList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorInfoList.get(i).containsKey("id")?elevatorInfoList.get(i).get("id").toString():"");
				vpd.put("var2", elevatorInfoList.get(i).containsKey("item_id")?elevatorInfoList.get(i).get("item_id").toString():"");
				vpd.put("var3", elevatorInfoList.get(i).containsKey("elevator_id")?elevatorInfoList.get(i).get("elevator_id").toString():"");
				vpd.put("var4", elevatorInfoList.get(i).containsKey("models_id")?elevatorInfoList.get(i).get("models_id").toString():"");
				vpd.put("var5", elevatorInfoList.get(i).containsKey("num")?elevatorInfoList.get(i).get("num").toString():"");
				vpd.put("var6", elevatorInfoList.get(i).containsKey("total")?elevatorInfoList.get(i).get("total").toString():"");
				vpd.put("var7", elevatorInfoList.get(i).containsKey("flag")?elevatorInfoList.get(i).get("flag").toString():"");
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
	 *导入tb_elevator_info 
	 */
	@RequestMapping(value="importExcelElevatorInfo")
	@ResponseBody
	public Object importExcelElevatorInfo(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("item_id", listPd.get(i).get("var1").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var2").toString());
    	        	pd.put("models_id", listPd.get(i).get("var3").toString());
    	        	pd.put("num", listPd.get(i).get("var4").toString());
    	        	pd.put("total", listPd.get(i).get("var5").toString());
    	        	pd.put("flag", listPd.get(i).get("var6").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorInfo(pd);
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
	 *导出tb_elevator_nonstandard
	 */
	@RequestMapping(value="toExcelElevatorNonstandard")
	public ModelAndView toExcelElevatorNonstandard(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯非标配置id");
			titles.add("一级菜单");
			titles.add("二级菜单");
			titles.add("三级菜单");
			titles.add("四级菜单");
			titles.add("级联id");
			titles.add("电梯类型id");
			titles.add("电梯单位id");
			titles.add("非标项状态(1:启用;2:禁用;3:历史记录)");
			titles.add("交货期");
			titles.add("非标价格");
			titles.add("描述");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorNonstandardList = offerService.findElevatorNonstandardList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorNonstandardList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorNonstandardList.get(i).containsKey("elevator_nonstandard_id")?elevatorNonstandardList.get(i).get("elevator_nonstandard_id").toString():"");
				vpd.put("var2", elevatorNonstandardList.get(i).containsKey("one_menu_id")?elevatorNonstandardList.get(i).get("one_menu_id").toString():"");
				vpd.put("var3", elevatorNonstandardList.get(i).containsKey("two_menu_id")?elevatorNonstandardList.get(i).get("two_menu_id").toString():"");
				vpd.put("var4", elevatorNonstandardList.get(i).containsKey("three_menu_id")?elevatorNonstandardList.get(i).get("three_menu_id").toString():"");
				vpd.put("var5", elevatorNonstandardList.get(i).containsKey("four_menu_id")?elevatorNonstandardList.get(i).get("four_menu_id").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("id")?elevatorNonstandardList.get(i).get("id").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("elevator_id")?elevatorNonstandardList.get(i).get("elevator_id").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("elevator_unit_id")?elevatorNonstandardList.get(i).get("elevator_unit_id").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("elevator_nonstandard_state")?elevatorNonstandardList.get(i).get("elevator_nonstandard_state").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("elevator_nonstandard_delivery")?elevatorNonstandardList.get(i).get("elevator_nonstandard_delivery").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("elevator_nonstandard_price")?elevatorNonstandardList.get(i).get("elevator_nonstandard_price").toString():"");
				vpd.put("var6", elevatorNonstandardList.get(i).containsKey("elevator_nonstandard_description")?elevatorNonstandardList.get(i).get("elevator_nonstandard_description").toString():"");
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
	 *导入tb_elevator_nonstandard 
	 */
	@RequestMapping(value="importExcelElevatorNonstandard")
	@ResponseBody
	public Object importExcelElevatorNonstandard(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("one_menu_id", listPd.get(i).get("var1").toString());
    	        	pd.put("two_menu_id", listPd.get(i).get("var2").toString());
    	        	pd.put("three_menu_id", listPd.get(i).get("var3").toString());
    	        	pd.put("four_menu_id", listPd.get(i).get("var4").toString());
    	        	pd.put("id", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var6").toString());
    	        	pd.put("elevator_unit_id", listPd.get(i).get("var7").toString());
    	        	pd.put("elevator_nonstandard_state", listPd.get(i).get("var8").toString());
    	        	pd.put("elevator_nonstandard_delivery", listPd.get(i).get("var9").toString());
    	        	pd.put("elevator_nonstandard_price", listPd.get(i).get("var10").toString());
    	        	pd.put("elevator_nonstandard_description", listPd.get(i).get("var11").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorNonstandard(pd);
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
	 *导出tb_elevator_num 
	 */
	@RequestMapping(value="toExcelElevatorNum")
	public ModelAndView toExcelElevatorNum(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯订单数量id");
			titles.add("项目id");
			titles.add("电梯id");
			titles.add("电梯规格id");
			titles.add("数量");
			titles.add("总价");
			titles.add("电梯型号id");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorNumList = offerService.findElevatorNumList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorNumList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorNumList.get(i).containsKey("id")?elevatorNumList.get(i).get("id").toString():"");
				vpd.put("var2", elevatorNumList.get(i).containsKey("item_id")?elevatorNumList.get(i).get("item_id").toString():"");
				vpd.put("var3", elevatorNumList.get(i).containsKey("elevator_id")?elevatorNumList.get(i).get("elevator_id").toString():"");
				vpd.put("var4", elevatorNumList.get(i).containsKey("elevator_spec_id")?elevatorNumList.get(i).get("elevator_spec_id").toString():"");
				vpd.put("var5", elevatorNumList.get(i).containsKey("num")?elevatorNumList.get(i).get("num").toString():"");
				vpd.put("var6", elevatorNumList.get(i).containsKey("elevator_total_price")?elevatorNumList.get(i).get("elevator_total_price").toString():"");
				vpd.put("var6", elevatorNumList.get(i).containsKey("models_id")?elevatorNumList.get(i).get("models_id").toString():"");
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
	 *导入tb_elevator_num
	 */
	@RequestMapping(value="importExcelElevatorNum")
	@ResponseBody
	public Object importExcelElevatorNum(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("item_id", listPd.get(i).get("var1").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_spec_id", listPd.get(i).get("var3").toString());
    	        	pd.put("num", listPd.get(i).get("var4").toString());
    	        	pd.put("elevator_total_price", listPd.get(i).get("var5").toString());
    	        	pd.put("models_id", listPd.get(i).get("var6").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorNum(pd);
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
	 *导出tb_elevator_optional 
	 */
	@RequestMapping(value="toExcelElevatorOptional")
	public ModelAndView toExcelElevatorOptional(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯可选项id");
			titles.add("一级菜单");
			titles.add("二级菜单");
			titles.add("三级菜单");
			titles.add("四级菜单");
			titles.add("级联id");
			titles.add("可选项配置价格");
			titles.add("可选项配置类型id");
			titles.add("交货期");
			titles.add("描述");
			titles.add("电梯类型id");
			titles.add("可选项配置类型(1:正常计费;2:公式计费)");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorOptionalList = offerService.findElevatorOptionalList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorOptionalList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorOptionalList.get(i).containsKey("elevator_optional_id")?elevatorOptionalList.get(i).get("elevator_optional_id").toString():"");
				vpd.put("var2", elevatorOptionalList.get(i).containsKey("one_menu_id")?elevatorOptionalList.get(i).get("one_menu_id").toString():"");
				vpd.put("var3", elevatorOptionalList.get(i).containsKey("two_menu_id")?elevatorOptionalList.get(i).get("two_menu_id").toString():"");
				vpd.put("var4", elevatorOptionalList.get(i).containsKey("three_menu_id")?elevatorOptionalList.get(i).get("three_menu_id").toString():"");
				vpd.put("var5", elevatorOptionalList.get(i).containsKey("four_menu_id")?elevatorOptionalList.get(i).get("four_menu_id").toString():"");
				vpd.put("var6", elevatorOptionalList.get(i).containsKey("id")?elevatorOptionalList.get(i).get("id").toString():"");
				vpd.put("var7", elevatorOptionalList.get(i).containsKey("elevator_optional_price")?elevatorOptionalList.get(i).get("elevator_optional_price").toString():"");
				vpd.put("var8", elevatorOptionalList.get(i).containsKey("elevator_unit_id")?elevatorOptionalList.get(i).get("elevator_unit_id").toString():"");
				vpd.put("var9", elevatorOptionalList.get(i).containsKey("elevator_optional_delivery")?elevatorOptionalList.get(i).get("elevator_optional_delivery").toString():"");
				vpd.put("var10", elevatorOptionalList.get(i).containsKey("elevator_optional_description")?elevatorOptionalList.get(i).get("elevator_optional_description").toString():"");
				vpd.put("var11", elevatorOptionalList.get(i).containsKey("elevator_id")?elevatorOptionalList.get(i).get("elevator_id").toString():"");
				vpd.put("var12", elevatorOptionalList.get(i).containsKey("elevator_optional_type")?elevatorOptionalList.get(i).get("elevator_optional_type").toString():"");
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
	 *导入tb_elevator_optional 
	 */
	@RequestMapping(value="importExcelElevatorOptional")
	@ResponseBody
	public Object importExcelElevatorOptional(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("one_menu_id", listPd.get(i).get("var1").toString());
    	        	pd.put("two_menu_id", listPd.get(i).get("var2").toString());
    	        	pd.put("three_menu_id", listPd.get(i).get("var3").toString());
    	        	pd.put("four_menu_id", listPd.get(i).get("var4").toString());
    	        	pd.put("id", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_optional_price", listPd.get(i).get("var6").toString());
    	        	pd.put("elevator_unit_id", listPd.get(i).get("var7").toString());
    	        	pd.put("elevator_optional_delivery", listPd.get(i).get("var8").toString());
    	        	pd.put("elevator_optional_description", listPd.get(i).get("var9").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var10").toString());
    	        	pd.put("elevator_optional_type", listPd.get(i).get("var11").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorOptional(pd);
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
	 *导出tb_elevator_spec 
	 */
	@RequestMapping(value="toExcelElevatorSpec")
	public ModelAndView toExcelElevatorSpec(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯规格id");
			titles.add("电梯规格名称");
			titles.add("电梯规格描述");
			titles.add("电梯规格状态");
			dataMap.put("titles", titles);
			
			List<PageData> elevatorSpecList = offerService.findElevatorSpecList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < elevatorSpecList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", elevatorSpecList.get(i).containsKey("spec_id")?elevatorSpecList.get(i).get("spec_id").toString():"");
				vpd.put("var2", elevatorSpecList.get(i).containsKey("spec_name")?elevatorSpecList.get(i).get("spec_name").toString():"");
				vpd.put("var3", elevatorSpecList.get(i).containsKey("spec_descript")?elevatorSpecList.get(i).get("spec_descript").toString():"");
				vpd.put("var4", elevatorSpecList.get(i).containsKey("spec_status")?elevatorSpecList.get(i).get("spec_status").toString():"");
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
	 *导入tb_elevator_spec 
	 */
	@RequestMapping(value="importExcelElevatorSpec")
	@ResponseBody
	public Object importExcelElevatorSpec(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("spec_id", this.get32UUID());
    	        	pd.put("spec_name", listPd.get(i).get("var1").toString());
    	        	pd.put("spec_descript", listPd.get(i).get("var2").toString());
    	        	pd.put("spec_status", listPd.get(i).get("var3").toString());
    	        	//保存至数据库
    	        	offerService.saveElevatorSpec(pd);
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
	 *导出tb_models 
	 */
	@RequestMapping(value="toExcelModels")
	public ModelAndView toExcelModels(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯型号id");
			titles.add("型号名称");
			titles.add("型号描述");
			titles.add("型号类型id");
			titles.add("产品线id");
			titles.add("型号价格");
			titles.add("电梯速度id");
			titles.add("电梯重量id");
			titles.add("电梯楼层参数id");
			titles.add("电梯标准总价格");
			titles.add("电梯基础配置id");
			titles.add("电梯基础配置总价格");
			titles.add("选配项");
			titles.add("非标项");
			titles.add("电梯可选配置总价格");
			titles.add("电梯非标配置总价格");
			titles.add("井道提升");
			titles.add("井道提升金额");
			titles.add("导轨支架提升高度");
			titles.add("导轨支架顶层高度");
			titles.add("导轨支架底坑深度");
			titles.add("导轨支架crbsp");
			titles.add("导轨支架金额");
			titles.add("CCTV电缆提升高度");
			titles.add("CCTV电缆金额");
			dataMap.put("titles", titles);
			
			List<PageData> modelsList = offerService.findModelsList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < modelsList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", modelsList.get(i).containsKey("models_id")?modelsList.get(i).get("models_id").toString():"");
				vpd.put("var2", modelsList.get(i).containsKey("models_name")?modelsList.get(i).get("models_name").toString():"");
				vpd.put("var3", modelsList.get(i).containsKey("models_description")?modelsList.get(i).get("models_description").toString():"");
				vpd.put("var4", modelsList.get(i).containsKey("elevator_id")?modelsList.get(i).get("elevator_id").toString():"");
				vpd.put("var5", modelsList.get(i).containsKey("product_id")?modelsList.get(i).get("product_id").toString():"");
				vpd.put("var6", modelsList.get(i).containsKey("models_price")?modelsList.get(i).get("models_price").toString():"");
				vpd.put("var7", modelsList.get(i).containsKey("elevator_speed_id")?modelsList.get(i).get("elevator_speed_id").toString():"");
				vpd.put("var8", modelsList.get(i).containsKey("elevator_weight_id")?modelsList.get(i).get("elevator_weight_id").toString():"");
				vpd.put("var9", modelsList.get(i).containsKey("elevator_storey_id")?modelsList.get(i).get("elevator_storey_id").toString():"");
				vpd.put("var10", modelsList.get(i).containsKey("elevator_standard_price")?modelsList.get(i).get("elevator_standard_price").toString():"");
				vpd.put("var11", modelsList.get(i).containsKey("elevator_base_id")?modelsList.get(i).get("elevator_base_id").toString():"");
				vpd.put("var12", modelsList.get(i).containsKey("elevator_base_price")?modelsList.get(i).get("elevator_base_price").toString():"");
				vpd.put("var13", modelsList.get(i).containsKey("elevator_optional_json")?modelsList.get(i).get("elevator_optional_json").toString():"");
				vpd.put("var14", modelsList.get(i).containsKey("elevator_nonstandard_json")?modelsList.get(i).get("elevator_nonstandard_json").toString():"");
				vpd.put("var15", modelsList.get(i).containsKey("elevator_optinal_price")?modelsList.get(i).get("elevator_optinal_price").toString():"");
				vpd.put("var16", modelsList.get(i).containsKey("elevator_nonstandard_price")?modelsList.get(i).get("elevator_nonstandard_price").toString():"");
				vpd.put("var17", modelsList.get(i).containsKey("elevator_height_add")?modelsList.get(i).get("elevator_height_add").toString():"");
				vpd.put("var18", modelsList.get(i).containsKey("elevator_height_money")?modelsList.get(i).get("elevator_height_money").toString():"");
				vpd.put("var19", modelsList.get(i).containsKey("rise")?modelsList.get(i).get("rise").toString():"");
				vpd.put("var20", modelsList.get(i).containsKey("top_height")?modelsList.get(i).get("top_height").toString():"");
				vpd.put("var21", modelsList.get(i).containsKey("pit_depth")?modelsList.get(i).get("pit_depth").toString():"");
				vpd.put("var22", modelsList.get(i).containsKey("crbsp")?modelsList.get(i).get("crbsp").toString():"");
				vpd.put("var23", modelsList.get(i).containsKey("rail_bracket_price")?modelsList.get(i).get("rail_bracket_price").toString():"");
				vpd.put("var24", modelsList.get(i).containsKey("cable_height")?modelsList.get(i).get("cable_height").toString():"");
				vpd.put("var25", modelsList.get(i).containsKey("cable_price")?modelsList.get(i).get("cable_price").toString():"");
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
	 *导入tb_models 
	 */
	@RequestMapping(value="importExcelModels")
	@ResponseBody
	public Object importExcelModels(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("models_name", listPd.get(i).get("var1").toString());
    	        	pd.put("models_description", listPd.get(i).get("var2").toString());
    	        	pd.put("elevator_id", listPd.get(i).get("var3").toString());
    	        	pd.put("product_id", listPd.get(i).get("var4").toString());
    	        	pd.put("models_price", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_speed_id", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_weight_id", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_storey_id", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_standard_price", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_base_id", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_base_price", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_optional_json", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_nonstandard_json", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_optional_price", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_nonstandard_price", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_height_add", listPd.get(i).get("var5").toString());
    	        	pd.put("elevator_height_money", listPd.get(i).get("var5").toString());
    	        	pd.put("rise", listPd.get(i).get("var5").toString());
    	        	pd.put("top_height", listPd.get(i).get("var5").toString());
    	        	pd.put("pit_depth", listPd.get(i).get("var5").toString());
    	        	pd.put("crbsp", listPd.get(i).get("var5").toString());
    	        	pd.put("rail_bracket_price", listPd.get(i).get("var5").toString());
    	        	pd.put("cable_height", listPd.get(i).get("var5").toString());
    	        	pd.put("cable_price", listPd.get(i).get("var5").toString());
    	        	//保存至数据库
    	        	offerService.saveModels(pd);
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
	 *导出tb_product_info 
	 */
	@RequestMapping(value="toExcelProductInfo")
	public ModelAndView toExcelProductInfo(){
		ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("电梯产品信息id");
			titles.add("电梯型号id");
			titles.add("产品线id");
			titles.add("产品信息名称");
			titles.add("产品信息类型(1:基本项'2:选配想;3:非标项)");
			titles.add("产品信息金额");
			dataMap.put("titles", titles);
			
			List<PageData> productInfoList = offerService.findProductInfoList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < productInfoList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", productInfoList.get(i).containsKey("product_info_id")?productInfoList.get(i).get("product_info_id").toString():"");
				vpd.put("var2", productInfoList.get(i).containsKey("models_id")?productInfoList.get(i).get("models_id").toString():"");
				vpd.put("var3", productInfoList.get(i).containsKey("product_id")?productInfoList.get(i).get("product_id").toString():"");
				vpd.put("var4", productInfoList.get(i).containsKey("product_info_name")?productInfoList.get(i).get("product_info_name").toString():"");
				vpd.put("var5", productInfoList.get(i).containsKey("product_info_type")?productInfoList.get(i).get("product_info_type").toString():"");
				vpd.put("var6", productInfoList.get(i).containsKey("product_info_price")?productInfoList.get(i).get("product_info_price").toString():"");
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
	 *导入tb_product_info 
	 */
	@RequestMapping(value="importExcelProductInfo")
	@ResponseBody
	public Object importExcelProductInfo(@RequestParam(value="file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("models_id", listPd.get(i).get("var1").toString());
    	        	pd.put("product_id", listPd.get(i).get("var2").toString());
    	        	pd.put("product_info_name", listPd.get(i).get("var3").toString());
    	        	pd.put("product_info_type", listPd.get(i).get("var4").toString());
    	        	pd.put("product_info_price", listPd.get(i).get("var5").toString());
    	        	//保存至数据库
    	        	offerService.saveProductInfo(pd);
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
	
}
