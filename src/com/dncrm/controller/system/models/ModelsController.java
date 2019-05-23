package com.dncrm.controller.system.models;

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
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.product.ProductService;
import com.dncrm.service.system.regelevStandard.RegelevStandardService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/models")
public class ModelsController extends BaseController{

	@Resource(name = "modelsService")
	private ModelsService modelsService;
	@Resource(name = "elevatorService")
	private ElevatorService elevatorService;
	@Resource(name = "regelevStandardService")
	private RegelevStandardService regelevStandardService;
	@Resource(name = "productService")
	private ProductService productService;
	
	
	
	
	
	/**
	 * 型号列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/modelsList")
	public ModelAndView modelsList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> elevatorList = elevatorService.findAllElevator();
		List<PageData> modelsList = modelsService.listPageModels(page);
		mv.addObject("elevator_id",pd.get("elevator_id"));
		mv.addObject("models_name", pd.get("models_name"));
		mv.addObject("elevatorList",elevatorList);
		mv.addObject("modelsList", modelsList);
		mv.addObject("page", page);
		mv.setViewName("system/models/models");
		return mv;
	}
	
	/**
	 * 跳转型号新增页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toModelsAdd")
	public ModelAndView toModelsAdd() throws Exception{
		ModelAndView mv = new ModelAndView();
		List<PageData> regelevStandardList = regelevStandardService.listAllRegelevStandard();
		List<PageData> productList = productService.listAllProduct();
		mv.addObject("regelevStandardList", regelevStandardList);
		mv.addObject("productList", productList);
		mv.addObject("msg", "modelsAdd");
		mv.setViewName("system/models/models_edit");
		return mv;
	}

	/**
	 * 跳转型号编辑页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toModelsEdit")
	public ModelAndView toModelsEdit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		String elevator_id = pd.getString("elevator_id");
		PageData pds = new PageData();
		pds.put("parentId", "1");
		mv.addObject("pd", pd);
		mv.addObject("msg", "modelsEdit");
		mv.setViewName("system/models/models_edit");
		return mv;
	}
	
	/**
	 * 添加型号
	 * @return
	 */
	@RequestMapping(value = "/modelsAdd")
	public ModelAndView modelsAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		try {
			pd.put("models_id", this.get32UUID());
			modelsService.modelsAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("id", "AddModels");
		mv.addObject("form", "modelsForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 编辑型号
	 * @return
	 */
	@RequestMapping(value = "/modelsEdit")
	public ModelAndView modelsEdit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			modelsService.modelsUpdate(pd);
			mv.addObject("id", "EditModels");
			mv.addObject("form", "modelsForm");
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			e.printStackTrace();
		}
		
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除型号
	 * @param models_id
	 * @param out
	 */
	@RequestMapping(value = "/modelsDelete")
	public void modelsDelete(String models_id,PrintWriter out){
		
		PageData pd = this.getPageData();
		try {
			modelsService.modelsDelete(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 批量删除型号
	 * @return
	 */
	@RequestMapping(value = "/modelsDeleteAll")
	@ResponseBody
	public Object modelsDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					modelsService.modelsDeleteAll(ArrayDATA_IDS);
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
	
}
