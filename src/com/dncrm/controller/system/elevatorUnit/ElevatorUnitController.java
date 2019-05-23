package com.dncrm.controller.system.elevatorUnit;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.elevatorUnit.ElevatorUnitService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/elevatorUnit")
public class ElevatorUnitController extends BaseController{

	@Resource(name = "elevatorUnitService")
	private ElevatorUnitService elevatorUnitService;
	
	
	
	
	
	/**
	 * 单元列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "elevatorUnitList")
	public ModelAndView elevatorUnitList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		page.setPd(pd);
		
		//单元
		List<PageData> elevatorUnitList = elevatorUnitService.listPageElevatorUnit(page);
	
		
		mv.addObject("elevator_unit_name", pd.get("elevator_unit_name"));
		mv.addObject("pd",pd);
		mv.addObject("elevatorUnitList", elevatorUnitList);
		mv.setViewName("system/elevatorUnit/elevatorUnit");
		return mv;
	}
	
	/**
	 * 跳转到单元添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddElevatorUnit")
	public ModelAndView goAddElevatorUnit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		mv.addObject("msg", "addElevatorUnit");
		mv.setViewName("system/elevatorUnit/elevatorUnit_edit");
		return mv;
	}
	
	/**
	 * 单元保存
	 * @return
	 */
	@RequestMapping(value = "addElevatorUnit")
	public ModelAndView addElevatorUnit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorUnitService.elevatorUnitAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddElevatorUnit");
		mv.addObject("from", "elevatorUnitForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到单元编辑页面
	 * @return
	 */
	@RequestMapping(value = "goEditElevatorUnit")
	public ModelAndView goEditElevatorUnit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		try {
			
			pd = elevatorUnitService.findElevatorUnitById(pd);
			mv.addObject("msg", "editElevatorUnit");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mv.addObject("pd", pd);
		mv.setViewName("system/elevatorUnit/elevatorUnit_edit");
		return mv;
	}
	
	/**
	 * 编辑单元
	 * @return
	 */
	@RequestMapping(value = "editElevatorUnit")
	public ModelAndView editElevatorUnit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			elevatorUnitService.elevatorUnitEdit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg","failed");
			mv.addObject("err","更新失败");
		}
		mv.addObject("id", "EditElevatorUnit");
		mv.addObject("form", "elevatorUnitForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除单元
	 * @return
	 */
	@RequestMapping(value = "delElevatorUnit")
	public void delElevatorUnit(PrintWriter out){
		PageData pd = this.getPageData();
		
		try {
			elevatorUnitService.elevatorUnitDeleteById(pd);
			out.write("success");
			out.flush();
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
	}
	
	/**
	 * 批量删除单元
	 * @return\
	 */
	@RequestMapping(value = "/elevatorUnitDeleteAll")
	@ResponseBody
	public Object elevatorUnitDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					elevatorUnitService.elevatorUnitDeleteAll(ArrayDATA_IDS);
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
	 * 单元名称是否存在
	 * @return
	 */
	@RequestMapping(value = "existsElevatorUnitName")
	@ResponseBody
	public Object existsElevatorUnitName(){
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		try {
			pd = elevatorUnitService.existsElevatorUnitName(pd);
			if(pd!=null){
				result.put("success", false);
				result.put("errorMsg", "单元名称已重复,请从新输入");
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
			//电梯速度参数导出
			titles.add("电梯单位ID");
			titles.add("电梯单位名称");
			titles.add("备注");
			dataMap.put("titles", titles);
			List<PageData> itemList = elevatorUnitService.findElevatorUnitListById(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).get("elevator_unit_id").toString());
				vpd.put("var2", itemList.get(i).getString("elevator_unit_name"));
				vpd.put("var3", itemList.get(i).getString("elevator_unit_remark"));
				
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
						pds.put("elevator_unit_name", listPd.get(i).getString("var0"));//
						pds.put("elevator_unit_remark", listPd.get(i).getString("var1"));//
						
						//保存速度参数至数据库
						elevatorUnitService.elevatorUnitAdd(pds);
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
