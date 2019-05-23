package com.dncrm.controller.system.escalatorModels;

import java.io.PrintWriter;
import java.math.BigDecimal;
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
import com.dncrm.service.system.elevatorCascade.ElevatorCascadeService;
import com.dncrm.service.system.elevatorConfig.ElevatorConfigService;
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.elevatorStandard.ElevatorStandardService;
import com.dncrm.service.system.elevatorUnit.ElevatorUnitService;
import com.dncrm.service.system.escalatorStandard.EscalatorStandardService;
import com.dncrm.service.system.escalatorModels.EscalatorModelsService;
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.modelsInfo.ModelsInfoService;
import com.dncrm.service.system.product.ProductService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Arith;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/escalatorModels")
public class EscalatorModelsController extends BaseController{

	@Resource(name = "escalatorModelsService")
	private EscalatorModelsService escalatorModelsService;
	
	@Resource(name = "elevatorService")
	private ElevatorService elevatorService;
	
	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	@Resource(name = "elevatorCascadeService")
	private ElevatorCascadeService elevatorCascadeService;
	
	@Resource(name = "elevatorConfigService")
	private ElevatorConfigService elevatorConfigService;
	
	@Resource(name = "elevatorStandardService")
	private ElevatorStandardService elevatorStandardService;
	
	@Resource(name = "escalatorStandardService")
	private EscalatorStandardService escalatorStandardService;
	
	@Resource(name = "elevatorUnitService")
	private ElevatorUnitService elevatorUnitService;
	
	@Resource(name = "modelsInfoService")
	private ModelsInfoService modelsInfoService;
	
	@Resource(name = "productService")
	private ProductService productService;
	/**
	 * 扶梯型号列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/escalatorModelsList")
	public ModelAndView modelsList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		pd.put("elevator_id", "4");
		page.setPd(pd);
		List<PageData> modelsList = escalatorModelsService.listPageEscalatorModels(page);
		mv.addObject("models_name", pd.get("models_name"));
		mv.addObject("modelsList", modelsList);
		mv.addObject("page", page);
		mv.setViewName("system/escalatorModels/escalatorModels");
		return mv;
	}
	
	/**
	 *跳转型号新增页面(新版 
	 */
	@RequestMapping(value = "/toEscalatorConfigAdd")
	public ModelAndView toEscalatorConfigAdd() throws Exception{
		ModelAndView mv = new ModelAndView();

		List<PageData> productList = escalatorModelsService.findProductListById("4");
		mv.addObject("productList", productList);
		mv.addObject("msg", "configAdd");
		mv.setViewName("system/escalatorModels/escalatorConfig_edit");
		return mv;
	}
	
	/**
	 *保存型号新增(新版扶梯 
	 */
	@RequestMapping(value = "/configAdd")
	public ModelAndView configAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//处理扶梯标准信息
			PageData stdPd  = new PageData();
			stdPd.put("escalator_model_id", pd.getString("elevator_speed_id"));
			stdPd.put("escalator_standard_id", pd.getString("elevator_weight_id"));
			stdPd.put("escalator_width_id", pd.getString("elevator_storey_id"));
			stdPd.put("escalator_standard_price", pd.getString("elevator_standard_price"));
			stdPd = escalatorModelsService.findEscalatorStandardId(stdPd);
			if(stdPd!=null){
				pd.put("ed_id", stdPd.get("id").toString());
			}else{
				stdPd  = new PageData();
				stdPd.put("escalator_model_id", pd.getString("elevator_speed_id"));
				stdPd.put("escalator_standard_id", pd.getString("elevator_weight_id"));
				stdPd.put("escalator_width_id", pd.getString("elevator_storey_id"));
				stdPd.put("escalator_standard_price", pd.getString("elevator_standard_price"));
				stdPd.put("escalator_standard_description", pd.getString("escalator_standard_description"));
				escalatorModelsService.saveEscalatorStandard(stdPd);
				pd.put("es_id", stdPd.get("id").toString());
			}
			pd.put("id", this.get32UUID());
			escalatorModelsService.configAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			e.printStackTrace();
		}
		mv.addObject("id", "AddModels");
		mv.addObject("form", "modelsForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**
	 * 跳转型号新增页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toEscalatorModelsAdd")
	public ModelAndView toEscalatorModelsAdd() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pds = new PageData();
		pds.put("parentId", "1");
		pds.put("elevator_id", "4");
		//产品线集合
		List<PageData> productList = productService.findProductByIdList(pds);
		
		//基础项集合
		List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pds);
		//级联菜单
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pds);
		//初始化选配配置
		JSONArray mapJsonArray = new JSONArray();
		//初始化非标配置
		JSONArray nonstandardJsonArrays = new JSONArray();
		mv.addObject("nonstandardJsonArrays", nonstandardJsonArrays);
		mv.addObject("mapJsonArray", mapJsonArray);
		mv.addObject("elevatorCascadeList",elevatorCascadeList);
		mv.addObject("elevatorBaseList", elevatorBaseList);
		mv.addObject("productList", productList);
		mv.addObject("msg", "escalatorModelsAdd");
		mv.setViewName("system/escalatorModels/escalatorModels_edit");
		return mv;
	}
	
	// 根据选择电梯类型加载可选配置信息列表
	@RequestMapping(value = "elevatorOptionalListByElevatorId")
	@ResponseBody
	public Object elevatorOptionalListByElevatorId(){
		PageData pd = this.getPageData();
		JSONArray result = new JSONArray();
		pd.put("parentId", "1");
		try {
			//级联菜单
			List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pd);
			result.addAll(elevatorCascadeList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 *跳转型号编辑页面(新版扶梯 
	 */
	@RequestMapping(value="/toEscalatorConfigEdit")
	public ModelAndView toEscalatorConfigEdit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData ecPd = escalatorModelsService.findModelsById(pd);
		
		String stdId = ecPd.getString("ES_ID");
		PageData stdPd = escalatorModelsService.findEscalatorStandard(stdId);
		//获取扶梯产品线列表
		List<PageData> productList = escalatorModelsService.findProductListById("4");
		
		mv.addObject("productList", productList);
		mv.addObject("stdPd", stdPd);
		mv.addObject("pd", ecPd);
		mv.addObject("msg", "configEdit");
		mv.setViewName("system/escalatorModels/escalatorConfig_edit");
		return mv;
	}
	
	/**
	 *保存编辑型号 
	 */
	@RequestMapping(value = "/configEdit")
	public ModelAndView configEdit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//处理扶梯标准信息
			PageData stdPd  = new PageData();
			stdPd.put("escalator_model_id", pd.getString("elevator_speed_id"));
			stdPd.put("escalator_standard_id", pd.getString("elevator_weight_id"));
			stdPd.put("escalator_width_id", pd.getString("elevator_storey_id"));
			stdPd.put("escalator_standard_price", pd.getString("elevator_standard_price"));
			stdPd = escalatorModelsService.findEscalatorStandardId(stdPd);
			if(stdPd!=null){
				pd.put("ed_id", stdPd.get("id").toString());
			}else{
				stdPd  = new PageData();
				stdPd.put("escalator_model_id", pd.getString("elevator_speed_id"));
				stdPd.put("escalator_standard_id", pd.getString("elevator_weight_id"));
				stdPd.put("escalator_width_id", pd.getString("elevator_storey_id"));
				stdPd.put("escalator_standard_price", pd.getString("elevator_standard_price"));
				stdPd.put("escalator_standard_description", pd.getString("escalator_standard_description"));
				escalatorModelsService.saveEscalatorStandard(stdPd);
				pd.put("es_id", stdPd.get("id").toString());
			}
			escalatorModelsService.configUpdate(pd);
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
	 * 跳转型号编辑页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toEscalatorModelsEdit")
	public ModelAndView toEscalatorModelsEdit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		String elevator_id = pd.getString("elevator_id");
		PageData pds = new PageData();
		pds.put("parentId", "1");
		pds.put("elevator_id", "4");
		//电梯类型集合
		List<PageData> elevatorList = elevatorService.findAllElevator();
		//产品线集合
		List<PageData> productList = productService.findProductByIdList(pds);
		//速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		//基础项集合
		List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pds);
		//基础配置选中
		List<PageData> elevatorBaseCheckedId = new ArrayList<>();
		//级联菜单
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pds);
		
		//后台获取所有菜单
		List<PageData> parentMenuList = null;
		List<PageData> twoMenuList = null;
		List<PageData> threeMenuList = null;
		List<PageData> fourMenuList = null;
		
		try {
			pd = escalatorModelsService.findModelsById(pd);
			
			//获取选配项配置 JSON
			String jsonStr = pd.getString("elevator_optional_json");
			
			JSONArray mapJsonArray = new JSONArray();
			
			if(jsonStr != null){
				JSONArray jsonArray = JSONArray.fromObject(jsonStr);
				if(jsonArray.size()>0){
					for(int i=0;i<jsonArray.size();i++){
						JSONObject jsonObject = jsonArray.getJSONObject(i);
						String parentMenu = jsonObject.getString("parentMenu");
						String twoMenu = jsonObject.getString("twoMenu");
						String threeMenu = jsonObject.getString("threeMenu");
						PageData parent = new PageData();
						PageData one = new PageData();
						PageData two = new PageData();
						PageData three = new PageData();
						parent.put("parentId", "1");
						parent.put("elevator_id", elevator_id);
						one.put("parentId", parentMenu);
						two.put("parentId", twoMenu);
						three.put("parentId", threeMenu);
						//父菜单
						parentMenuList = elevatorCascadeService.elevatorCascadeListByParentId(parent);
						//二级菜单
						twoMenuList = elevatorCascadeService.elevatorCascadeListByParentId(one);
						//三级菜单
						threeMenuList = elevatorCascadeService.elevatorCascadeListByParentId(two);
						//四级菜单
						fourMenuList = elevatorCascadeService.elevatorCascadeListByParentId(three);
						PageData temp = new PageData();
						temp.put("parentMenuList", parentMenuList);
						temp.put("twoMenuList", twoMenuList);
						temp.put("threeMenuList", threeMenuList);
						temp.put("fourMenuList", fourMenuList);
						mapJsonArray.add(temp);
						
					}
				}
				
			}
			mv.addObject("mapJsonArray", mapJsonArray);
			
			
			
			
				
			//获取非标项配置 JSON
			String nonstandardJson = pd.getString("elevator_nonstandard_json");
			
			JSONArray nonstandardJsonArrays = new JSONArray();
			
			if(nonstandardJson != null){
				JSONArray nonstandardJsonArray = JSONArray.fromObject(nonstandardJson);
				if(nonstandardJsonArray.size()>0){
					for(int i=0;i<nonstandardJsonArray.size();i++){
						JSONObject jsonObject = nonstandardJsonArray.getJSONObject(i);
						String parentMenu = jsonObject.getString("parentMenu");
						String twoMenu = jsonObject.getString("twoMenu");
						String threeMenu = jsonObject.getString("threeMenu");
						PageData one = new PageData();
						PageData two = new PageData();
						PageData three = new PageData();
						one.put("parentId", parentMenu);
						two.put("parentId", twoMenu);
						three.put("parentId", threeMenu);
						
						//二级菜单
						twoMenuList = elevatorCascadeService.elevatorCascadeListByParentId(one);
						//三级菜单
						threeMenuList = elevatorCascadeService.elevatorCascadeListByParentId(two);
						//四级菜单
						fourMenuList = elevatorCascadeService.elevatorCascadeListByParentId(three);
						PageData temp = new PageData();
						temp.put("twoMenuList", twoMenuList);
						temp.put("threeMenuList", threeMenuList);
						temp.put("fourMenuList", fourMenuList);
						nonstandardJsonArrays.add(temp);
						
					}
				}
				
			}
			mv.addObject("nonstandardJsonArrays", nonstandardJsonArrays);	
				
				
				
			
			
			
			//拼接选中基础项
			if(pd.getString("elevator_base_id")!=null && !"".equals(pd.getString("elevator_base_id"))){
				String baseId = pd.getString("elevator_base_id");
				String[] baseIds = baseId.split(",");
				for(String checkedBaseId : baseIds){
					PageData checkedBaseIdList = new PageData();
					checkedBaseIdList.put("elevator_base_id", checkedBaseId);
					elevatorBaseCheckedId.add(checkedBaseIdList);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.addObject("elevatorCascadeList", elevatorCascadeList);
		mv.addObject("elevatorBaseCheckedId", elevatorBaseCheckedId);
		mv.addObject("elevatorList", elevatorList);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorBaseList", elevatorBaseList);
		mv.addObject("productList", productList);
		mv.addObject("msg", "modelsEdit");
		mv.setViewName("system/escalatorModels/escalatorModels_edit");
		return mv;
	}
	
	/**
	 * 添加型号
	 * @return
	 */
	@RequestMapping(value = "/escalatorModelsAdd")
	public ModelAndView escalatorModelsAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		try {
			escalatorModelsService.modelsAdd(pd);
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
			escalatorModelsService.modelsUpdate(pd);
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
	 *删除型号(新版扶梯 
	 */
	@RequestMapping(value = "/configDelete")
	public void configDelete(String models_id,PrintWriter out){
		
		PageData pd = this.getPageData();
		try {
			escalatorModelsService.configDelete(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
			escalatorModelsService.modelsDelete(pd);
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
				
					escalatorModelsService.modelsDeleteAll(ArrayDATA_IDS);
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
	
	//加载 级联选配项配置
	@RequestMapping(value = "/addElevatorOptional")
	@ResponseBody
	public Map<String,Object> addElevatorOptional() throws Exception{
		Map<String,Object> result = new HashMap<>();
		PageData pd = this.getPageData();
		//电梯级联
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pd);
		String elevatorCascadeJson = "[";
		if(elevatorCascadeList.size()>0){
			for(PageData pds :elevatorCascadeList){
				elevatorCascadeJson += "{\"id\":\"" + pds.get("id") +"\",";
				elevatorCascadeJson += "\"name\":\"" + pds.get("name") +"\"},";
			}
			elevatorCascadeJson = elevatorCascadeJson.substring(0, elevatorCascadeJson.length()-1)+"]";
			result.put("elevatorCascadeList", elevatorCascadeList);
		}else{
			//获取电梯选配 基础参数  检查是否有该配置 
			String id = pd.getString("parentId");
			pd.put("id", id);
			PageData elevatorOptional = new PageData();
			//电梯选配配置
			elevatorOptional = elevatorConfigService.findElevatorOptionalById(pd);
			if(elevatorOptional != null){
				result.put("elevator_unit_id", elevatorOptional.get("elevator_unit_id"));
				result.put("elevator_optional_delivery", elevatorOptional.get("elevator_optional_delivery"));
				result.put("elevator_optional_price", elevatorOptional.get("elevator_optional_price"));
			}
			
		}
		
		//电梯单位
		String elevatorUnitJson = "[";
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pd);
		for(PageData pds :elevatorUnitList){
			elevatorUnitJson += "{\"elevator_unit_id\":\"" + pds.get("elevator_unit_id") +"\",";
			elevatorUnitJson += "\"elevator_unit_name\":\"" + pds.get("elevator_unit_name") +"\"},";
		}
		elevatorUnitJson = elevatorUnitJson.substring(0, elevatorUnitJson.length()-1)+"]";
		result.put("elevatorUnitList", elevatorUnitList);
		
		return result;
	}
	
	//加载 级联非标项配置
	@RequestMapping(value = "/addElevatorNonstandard")
	@ResponseBody
	public Map<String,Object> addElevatorNonstandard() throws Exception{
		Map<String,Object> result = new HashMap<>();
		PageData pd = this.getPageData();
		//电梯级联
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pd);
		String elevatorCascadeJson = "[";
		if(elevatorCascadeList.size()>0){
			for(PageData pds :elevatorCascadeList){
				elevatorCascadeJson += "{\"id\":\"" + pds.get("id") +"\",";
				elevatorCascadeJson += "\"name\":\"" + pds.get("name") +"\"},";
			}
			elevatorCascadeJson = elevatorCascadeJson.substring(0, elevatorCascadeJson.length()-1)+"]";
			result.put("elevatorCascadeList", elevatorCascadeList);
		}else{
			//获取电梯选配 基础参数  检查是否有该配置 
			String id = pd.getString("parentId");
			pd.put("id", id);
			PageData elevatorOptional = new PageData();
			//电梯选配配置
			elevatorOptional = elevatorConfigService.findElevatorNonstandardById(pd);
			if(elevatorOptional != null){
				result.put("elevator_unit_id", elevatorOptional.get("elevator_unit_id"));
				result.put("elevator_nonstandard_delivery", elevatorOptional.get("elevator_nonstandard_delivery"));
				result.put("elevator_nonstandard_price", elevatorOptional.get("elevator_nonstandard_price"));
			}
			
		}
		
		//电梯单位
		String elevatorUnitJson = "[";
		List<PageData> elevatorUnitList =  elevatorUnitService.findElevatorUnitListById(pd);
		for(PageData pds :elevatorUnitList){
			elevatorUnitJson += "{\"elevator_unit_id\":\"" + pds.get("elevator_unit_id") +"\",";
			elevatorUnitJson += "\"elevator_unit_name\":\"" + pds.get("elevator_unit_name") +"\"},";
		}
		elevatorUnitJson = elevatorUnitJson.substring(0, elevatorUnitJson.length()-1)+"]";
		result.put("elevatorUnitList", elevatorUnitList);
		
		return result;
	}
	
	/**
	 * 计算基础配置价格
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/baseCountTotalPrice")
	@ResponseBody
	public Object baseCountTotalPrice() throws Exception{
		PageData pd = this.getPageData();
		String str = pd.getString("str");
		JSONObject result = new JSONObject();
		double countPrice = 0.00;
		String price = "";
		if(str!=null && !"".equals(str)){
			String[] strArray = str.split(",");
			for(int i=0;i<strArray.length;i++){
				PageData pds = new PageData();
				pd.put("elevator_base_id", strArray[i]);
				pds = elevatorConfigService.findElevatorBaseById(pd);
				BigDecimal bd = (BigDecimal) pds.get("elevator_base_price");
				double v =  bd.doubleValue();
				countPrice = Arith.add(countPrice, v);
				
			}
			
			
//			PageData elevatorInfo = new PageData();//电梯信息
//			elevatorInfo = itemService.findElevatorNumById(pd);
//			String num = (String) elevatorInfo.get("num");
//			double elevatorNum = Double.parseDouble(num);
//			
//			countPrice = Arith.mul(countPrice, elevatorNum);
			price = Arith.doubleForString(countPrice);
			
		}
		result.put("success", true);
		result.put("countPrice", price);
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
		String models_id = pd.getString("models_id");//型号ID
		String flag = pd.getString("flag");//判断型号模板   1:模板 2:正式
		if(flag == null){
			flag = "";
		}
		//电梯楼层集合
		List<PageData> elevatorStoreyList = elevatorParameterService.findElevatorStoreyListById(pd);
		
		String jsonStr="[";
		//加载电梯楼层参数
		for(PageData elevatorStorey:elevatorStoreyList){
			jsonStr +="{";
			jsonStr +="\"elevator_storey_id\":"+elevatorStorey.get("elevator_storey_id")+",";
			jsonStr +="\"elevator_storey_name\":\""+elevatorStorey.get("elevator_storey_name")+"\",";
			jsonStr +="\"elevator_height_name\":\""+elevatorStorey.get("elevator_height_name")+"\",";
			jsonStr +="\"elevator_speed_id\":"+elevatorStorey.get("elevator_speed_id")+",";
			jsonStr = jsonStr.substring(0, jsonStr.length()-1);
			jsonStr += "},";
		}
		if(jsonStr.indexOf(",")>-1){
			jsonStr = jsonStr.substring(0, jsonStr.length()-1);
		}
	
		jsonStr += "]";
		
		
		//加载电梯型号楼层外键
		String jsonStr2 = "[";
		//1,查询型号模板
		if(models_id!=null && !"".equals(models_id) && (flag.equals("1")|| flag.equals(""))){
			List<PageData> modelsList = escalatorModelsService.findModelsByTypeList(pd);
			for(PageData models:modelsList){
				jsonStr2 += "{";
				jsonStr2 += "\"elevator_storey_id\":"+models.get("elevator_storey_id")+",";
				jsonStr2 += "\"elevator_standard_price\":"+models.get("elevator_standard_price")+",";
				jsonStr2 = jsonStr2.substring(0, jsonStr2.length()-1);
				jsonStr2 += "},";
			}
			if(jsonStr2.indexOf(",")>-1){
				jsonStr2 = jsonStr2.substring(0, jsonStr2.length()-1);
			}
		}else{
			//2,查询正式型号
			List<PageData> modelsList = modelsInfoService.findModelsInfoByTypeList(pd);
			for(PageData models:modelsList){
				jsonStr2 += "{";
				jsonStr2 += "\"elevator_storey_id\":"+models.get("elevator_storey_id")+",";
				jsonStr2 += "\"elevator_standard_price\":"+models.get("elevator_standard_price")+",";
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
		map.put("modelsList", jsonStr2);
		return map;
	}
	
	//根据井道提高获取金额
	@RequestMapping(value = "findHeightMoney")
	@ResponseBody
	public String findHeightMoney() throws Exception{
		PageData pd = this.getPageData();
		String price = "";
		PageData pds = elevatorParameterService.findElevatorHeightById(pd);
		if(pds != null && pds.get("elevator_height_money") != null){
			String elevator_height_money = pds.getString("elevator_height_money");
			String elevator_height_name = pd.getString("elevator_height_add");
			double v1 = Double.parseDouble(elevator_height_name);
			double v2 = Double.parseDouble(elevator_height_money);
			double count = Arith.mul(v1, v2);
			price  = Arith.doubleForString(count);
		}
		return price;
	}
	
	//根据楼层ID查询自身标准高度
	@RequestMapping(value = "findStoreyById")
	@ResponseBody
	public String findStoreyById() throws Exception{
		PageData pd = this.getPageData();
		String elevator_height_name = "";
		PageData pds = elevatorParameterService.findElevatorStoreyById(pd);
		if(pds != null && pds.get("elevator_height_name") != null){
			
			elevator_height_name = pds.getString("elevator_height_name");
		}
		
		return elevator_height_name;
	}
	
	//计算电梯标准价格
	@RequestMapping(value = "countEscalatorStandardPrice")
	@ResponseBody
	public Object countEscalatorStandardPrice() throws Exception{
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		pd = escalatorStandardService.countEscalatorStandardPrice(pd);
		if(pd!=null){
			if(pd.get("escalator_standard_price")!=null){
				result.put("success", true);
				result.put("elevator_standard_price", pd.get("escalator_standard_price"));
			}else{
				
				result.put("errorMsg", "标准价格未设置");
			}
		}else{
			result.put("errorMsg", "计算失败,请检查是否存有参数未设置!");
		}
		return result;
	}
	
	
	
	
	
}
