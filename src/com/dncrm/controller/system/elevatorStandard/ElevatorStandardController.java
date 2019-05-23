package com.dncrm.controller.system.elevatorStandard;

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
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.elevatorStandard.ElevatorStandardService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Const;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/elevatorStandard")
public class ElevatorStandardController extends BaseController{

	@Resource(name = "elevatorStandardService")
	private ElevatorStandardService elevatorStandardService;
	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	
	
	
	/**
	 * 电梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorStandardList")
	public ModelAndView elevatorStandardList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		page.setPd(pd);
		
		//电梯标准价格
		List<PageData> elevatorStandardList = elevatorStandardService.listPageElevatorStandard(page);
		//电梯速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//电梯重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		//电梯楼层参数集合
		List<PageData> elevatorStoreyList = elevatorParameterService.findElevatorStoreyListById(pds);
		
		
		mv.addObject("elevator_standard_name", pd.get("elevator_standard_name"));
		mv.addObject("elevator_speed_id",pd.get("elevator_speed_id"));
		mv.addObject("elevator_weight_id", pd.get("elevator_weight_id"));
		mv.addObject("elevator_storey_id", pd.get("elevator_storey_id"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorStoreyList", elevatorStoreyList);
		mv.addObject("elevatorStandardList", elevatorStandardList);
		mv.setViewName("system/elevatorStandard/elevatorStandard");
		return mv;
	}
	
	/**
	 * 跳转到电梯标准价格添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorStandard")
	public ModelAndView goAddElevatorStandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		//电梯速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//电梯重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("msg", "addElevatorStandard");
		mv.setViewName("system/elevatorStandard/elevatorStandard_edit");
		return mv;
	}
	
	/**
	 * 电梯标准价格保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorStandard")
	public ModelAndView addElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorStandardService.elevatorStandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorStandard");
		mv.addObject("from", "elevatorStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到电梯标准价格编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorStandard")
	public ModelAndView goEditElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		List<PageData> elevatorSpeedList=null;
		List<PageData> elevatorWeightList=null;
		try {
			//电梯速度集合
			elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pd);
			//电梯重量参数集合
			elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pd);
			pd = elevatorStandardService.findElevatorStandardById(pd);
			mv.addObject("msg", "editElevatorStandard");
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorSpeedList",elevatorSpeedList);
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorStandard/elevatorStandard_edit");
		return mv;
	}
	
	/**
	 * 编辑电梯标准价格
	 * @return
	 */
	@RequestMapping(value = "editElevatorStandard")
	public ModelAndView editElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorStandardService.elevatorStandardEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorStandard");
		mv.addObject("form", "elevatorStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除电梯标准价格
	 * @return
	 */
	@RequestMapping(value = "delElevatorStandard")
	public void delElevatorStandard(PrintWriter out){
		PageData pd = this.getPageData();
		
		try {
			elevatorStandardService.elevatorStandardDeleteById(pd);
			out.write("success");
			out.flush();
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
	}
	
	/**
	 * 批量删除电梯标准价格
	 * @return\
	 */
	@RequestMapping(value = "/elevatorStandardDeleteAll")
	@ResponseBody
	public Object elevatorStandardDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					elevatorStandardService.elevatorStandardDeleteAll(ArrayDATA_IDS);
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
	 */
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
	
	/**
	 * 根据速度参数ID查找楼层
	 * @return
	 * @throws Exception
	 */
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
			List<PageData> elevatorStandardList = elevatorStandardService.findElevatorStandardListById(pd);
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
				titles.add("电梯标准价格id");
				titles.add("电梯标准价格名称");
				titles.add("电梯速度参数ID");
				titles.add("电梯重量参数ID");
				titles.add("电梯楼层参数ID");
				titles.add("电梯标准价格");
				titles.add("描述");
				dataMap.put("titles", titles);
				List<PageData> itemList = elevatorStandardService.findElevatorStandardListById(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).get("elevator_standard_id").toString());
					vpd.put("var2", itemList.get(i).getString("elevator_standard_name"));
					vpd.put("var3", itemList.get(i).get("elevator_speed_id").toString());
					vpd.put("var4", itemList.get(i).get("elevator_weight_id").toString());
					vpd.put("var5", itemList.get(i).get("elevator_storey_id").toString());
					vpd.put("var6", itemList.get(i).get("elevator_standard_price").toString());
					vpd.put("var7", itemList.get(i).getString("elevator_standard_description"));
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
			PageData pd = this.getPageData();
			try{
				if(file!=null && !file.isEmpty()){
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					PageData pds = new PageData();
					//速度参数导入
					
					for(int i = 0;i<listPd.size();i++){
						if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals("")){
							pds.put("elevator_standard_name", listPd.get(i).getString("var0"));//
							pds.put("elevator_speed_id", listPd.get(i).getString("var1"));//
							pds.put("elevator_weight_id", listPd.get(i).getString("var2"));//
							pds.put("elevator_storey_id", listPd.get(i).getString("var3"));//
							pds.put("elevator_standard_price", listPd.get(i).getString("var4"));//
							pds.put("elevator_standard_description", listPd.get(i).getString("var5"));//
							//保存速度参数至数据库
							elevatorStandardService.elevatorStandardAdd(pds);
						}
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
