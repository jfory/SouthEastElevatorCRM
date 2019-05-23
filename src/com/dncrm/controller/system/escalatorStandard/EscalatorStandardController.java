package com.dncrm.controller.system.escalatorStandard;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.dncrm.entity.Page;
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.escalatorStandard.EscalatorStandardService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;



@Controller
@RequestMapping(value = "/escalatorStandard")
public class EscalatorStandardController extends BaseController{

	@Resource(name = "escalatorStandardService")
	private EscalatorStandardService escalatorStandardService;
	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	
	
	
	/**
	 * 扶梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "escalatorStandardList")
	public ModelAndView escalatorStandardList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		//扶梯标准价格
		List<PageData> escalatorStandardList = escalatorStandardService.listPageEscalatorStandard(page);
		mv.addObject("home_standard_name", pd.get("home_standard_name"));
		mv.addObject("pd",pd);
		mv.addObject("escalatorStandardList", escalatorStandardList);
		mv.setViewName("system/escalatorStandard/escalatorStandard");
		return mv;
	}
	
	/**
	 * 跳转到扶梯标准价格添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddEscalatorStandard")
	public ModelAndView goAddEscalatorStandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", "addEscalatorStandard");
		mv.setViewName("system/escalatorStandard/escalatorStandard_edit");
		return mv;
	}
	
	/**
	 * 扶梯标准价格保存
	 * @return
	 */
	@RequestMapping(value = "addEscalatorStandard")
	public ModelAndView addEscalatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			escalatorStandardService.escalatorStandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddEscalatorStandard");
		mv.addObject("from", "escalatorStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到扶梯标准价格编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditEscalatorStandard")
	public ModelAndView goEditEscalatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			
			pd = escalatorStandardService.findEscalatorStandardById(pd);
			mv.addObject("msg", "editEscalatorStandard");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.setViewName("system/escalatorStandard/escalatorStandard_edit");
		return mv;
	}
	
	/**
	 * 编辑扶梯标准价格
	 * @return
	 */
	@RequestMapping(value = "editEscalatorStandard")
	public ModelAndView editEscalatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			escalatorStandardService.escalatorStandardEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditEscalatorStandard");
		mv.addObject("form", "escalatorStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除扶梯标准价格
	 * @return
	 */
	@RequestMapping(value = "delEscalatorStandard")
	public void delEscalatorStandard(PrintWriter out){
		PageData pd = this.getPageData();
		
		try {
			escalatorStandardService.escalatorStandardDeleteById(pd);
			out.write("success");
			out.flush();
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
	}
	
	/**
	 * 批量删除扶梯标准价格
	 * @return\
	 */
	@RequestMapping(value = "/escalatorStandardDeleteAll")
	@ResponseBody
	public Object escalatorStandardDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					escalatorStandardService.escalatorStandardDeleteAll(ArrayDATA_IDS);
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
	
	/**
	 *扶梯标准导出Excel
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("扶梯标准id");
			titles.add("型号");
			titles.add("规格");
			titles.add("宽度");
			titles.add("金额");
			titles.add("描述");
			dataMap.put("titles", titles);
			List<PageData> esList = escalatorStandardService.findEscalatorStandardList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < esList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", String.valueOf(esList.get(i).get("id")));
				vpd.put("var2", esList.get(i).getString("escalator_model_id"));
				vpd.put("var3", esList.get(i).getString("escalator_standard_id"));
				vpd.put("var4", esList.get(i).getString("escalator_width_id"));
				vpd.put("var5", esList.get(i).getString("escalator_standard_price"));
				vpd.put("var6", esList.get(i).getString("escalator_standard_description"));
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
	
	@RequestMapping(value="escalatorStandard")
	@ResponseBody
	public Object importExcel(@RequestParam(value = "file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
	            
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++){
		        	pd.put("escalator_model_id", listPd.get(i).getString("0"));
		        	pd.put("escalator_standard_id", listPd.get(i).getString("var1"));//项目名
		        	pd.put("escalator_width_id", listPd.get(i).getString("var2"));//安装地址
		        	pd.put("escalator_standard_price", listPd.get(i).getString("var3"));//最终用户
		        	pd.put("escalator_standard_description", listPd.get(i).getString("var4"));//用户编号
		        	//保存至数据库
		        	escalatorStandardService.saveEscalatorStandard(pd);
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
