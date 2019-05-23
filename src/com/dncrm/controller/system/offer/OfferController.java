package com.dncrm.controller.system.offer;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.consignee.ConsigneeService;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.elevatorCascade.ElevatorCascadeService;
import com.dncrm.service.system.elevatorConfig.ElevatorConfigService;
import com.dncrm.service.system.elevatorInfo.ElevatorInfoService;
import com.dncrm.service.system.elevatorParameter.ElevatorParameterService;
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.modelsInfo.ModelsInfoService;
import com.dncrm.service.system.offer.OfferService;
import com.dncrm.service.system.product.ProductService;
import com.dncrm.service.system.productInfo.ProductInfoService;
import com.dncrm.service.system.production.ProductionService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Arith;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.SelectByRole;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.dncrm.service.system.sysUser.sysUserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/offer")
public class OfferController extends BaseController{
	
	@Resource(name = "offerService")
	private OfferService offerService;
	
	@Resource(name = "productInfoService")
	private ProductInfoService productInfoService;
	
	@Resource(name = "productService")
	private ProductService productService;
	
	@Resource(name = "itemService")
	private ItemService itemService;
	
	@Resource(name = "modelsService")
	private ModelsService modelsService;
	
	@Resource(name = "sysUserService")
	private sysUserService sysUserService;
	
	@Resource(name = "elevatorParameterService")
	private ElevatorParameterService elevatorParameterService;
	
	@Resource(name = "elevatorCascadeService")
	private ElevatorCascadeService elevatorCascadeService;
	
	@Resource(name = "elevatorConfigService")
	private ElevatorConfigService elevatorConfigService;
	
	@Resource(name = "modelsInfoService")
	private ModelsInfoService modelsInfoService;
	
	@Resource(name = "elevatorInfoService")
	private ElevatorInfoService elevatorInfoService;
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@Resource(name="consigneeService")
	private ConsigneeService consigneeService;
	
	@Resource(name="elevatorService")
	private ElevatorService elevatorService;
	
	@Resource(name="productionService")
	private ProductionService productionService;
	
	/**
	 * 报价列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/offerList")
	public ModelAndView offerList(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		SelectByRole sbr = new SelectByRole();
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
		pd.put("userList", userList);
		//将当前登录人添加至列表查询条件
		pd.put("item_status", "2");
		pd.put("input_user", getUser().getUSER_ID());
        page.setPd(pd);
        try{
			/*List<PageData> itemList = consigneeService.listPageAllItem(page);*/
        	List<PageData> itemList = consigneeService.listPageAllItemByRole(page);
			//判断项目是否报价完成,显示折扣按钮
			List<PageData> itemOfferList = new ArrayList<PageData>();
			for(PageData itemPd : itemList){
				String item_id = itemPd.get("item_id").toString();
				if(item_id!=null){//判断项目报价状态
					String item_status = offerService.findItemStatusByItemId(item_id);
					if("3".equals(item_status)){
						itemPd.put("offerState", "1");
					}else{
						itemPd.put("offerState", "0");
					}
				}
				itemOfferList.add(itemPd);
			}
			mv.setViewName("system/offer/offer");
			/*mv.addObject("itemList",itemList);*/
			mv.addObject("itemList", itemOfferList);
			mv.addObject("pd",pd);
			mv.addObject("page",page);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        }catch(Exception e){
        	logger.error(e.getMessage(),e);
        }
		return mv;
	}
	
	/**
	 * 跳转报价新增页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toOfferAdd")
	public ModelAndView toOfferAdd() throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		List<PageData> itemList = new ArrayList<PageData>();
		//加载用户信息-用于项目负责人
        List<PageData> userList = sysUserService.findUserInfo();
        mv.addObject("userList", userList);
		try {
			//项目信息
			itemList = itemService.findItemList();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mv.addObject("itemList",itemList);
		mv.addObject("msg", "offerAdd");
		mv.setViewName("system/offer/offer_edit");
		return mv;
	}
	
	/**
	 * 跳转报价编辑页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toOfferEdit")
	public ModelAndView toOfferEdit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData pds = new PageData();
		//加载项目报备信息
    	pd = itemService.findItemAndAddressById(pd);
		//加载客户信息-用于最终用户
        List<PageData> customerList = customerService.findCustomerInfo();
        mv.addObject("customerList",customerList);
        //获取项目报备详情
		PageData item = itemService.findItemById(pd);
		List<PageData> itemList = new ArrayList<>();
		try {
			//获取项目报备集合
			itemList = itemService.findItemList();
			//获取报价详情
			pds = offerService.findOfferById(pd);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*自动生成工号 测试 List<PageData> elevatorJobNo = offerService.createElevatorJobNo(pd);*/
		mv.addObject("item",item);
		mv.addObject("itemList",itemList);
		mv.addObject("pd", pd);
		mv.addObject("msg", "offerEdit");
		mv.setViewName("system/offer/offer_edit");
		return mv;
	}
	
	/**
	 * 添加报价
	 * @return
	 */
	@RequestMapping(value = "/offerAdd")
	public ModelAndView offerAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData item = new PageData();
		PageData pds = new PageData();
		try {
			pds = offerService.findOfferById(pd);
			if(pds!=null){
				mv.addObject("msg", "failed");
				mv.addObject("err", "添加失败,该项目已报价");
			}else{
				offerService.offerAdd(pd);
				itemService.updateItemOffer(pd);
				mv.addObject("msg", "success");
			}
			
			//更新项目状态为报价
			item = itemService.findItemById(pd);
			/*item.put("item_status", "2");
			itemService.editItem(item);*/
			
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("id", "AddOffer");
		mv.addObject("form", "offerForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 编辑报价
	 * @return
	 */
	@RequestMapping(value = "/offerEdit")
	public ModelAndView offerEdit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			//如果此项目没有报价记录,执行报价操作,如有,更新报价信息;tb_offer
			String item_id = pd.get("item_id").toString();
			boolean ifOffer = offerService.findOfferByItemId(item_id);
			if(ifOffer){
				offerService.offerUpdate(pd);
			}else{
				offerService.offerAdd(pd);
			}
			itemService.updateItemOffer(pd);
			mv.addObject("id", "EditOffer");
			mv.addObject("form", "offerForm");
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
	 * 删除报价
	 * @param offer_id
	 * @param out
	 */
	@RequestMapping(value = "/offerDelete")
	public void offerDelete(String offer_id,PrintWriter out){
		
		PageData pd = this.getPageData();
		try {
			offerService.offerDelete(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 批量删除报价
	 * @return
	 */
	@RequestMapping(value = "/offerDeleteAll")
	@ResponseBody
	public Object offerDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					offerService.offerDeleteAll(ArrayDATA_IDS);
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
	 * 电梯列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/elevatorList")
	@ResponseBody
	public JSONArray ElevatorList() throws Exception{
		PageData pd = this.getPageData();
		JSONArray jsonArray = new JSONArray();
		
		String elevator_total_price="";
		List<PageData> elevatorInfoList = elevatorInfoService.elevatorDetailsList(pd);
		for(PageData elevatorInfo:elevatorInfoList){
			JSONObject result = new JSONObject();
			result.put("id", elevatorInfo.get("id"));
			result.put("item_id", elevatorInfo.get("item_id"));
			result.put("elevator_id", elevatorInfo.get("elevator_id"));
			result.put("product_id", elevatorInfo.get("product_id"));
			result.put("models_id",  elevatorInfo.get("models_id"));
			/*BigDecimal bd = (BigDecimal) elevatorInfo.get("total");
			if(bd!=null){
				double price = bd.doubleValue();
				elevator_total_price = Arith.doubleForString(price);
			}else{
				elevator_total_price = "0.00";
			}*/
			result.put("total", elevatorInfo.get("total"));
			result.put("flag", elevatorInfo.get("flag"));
			result.put("elevator_name", elevatorInfo.get("elevator_name"));
			result.put("models_name", elevatorInfo.get("models_name"));
			
			//流程ID
			String elevator_instance_id = elevatorInfo.getString("elevator_instance_id");
			if(elevator_instance_id != null && !"".equals(elevator_instance_id)){
				WorkFlow workFlow = new WorkFlow();
    			Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(elevator_instance_id).active().singleResult();
    			if(task!=null){
    				result.put("task_id",task.getId());
    				result.put("task_name",task.getName());
    			}
			}
			result.put("elevator_instance_id", elevatorInfo.get("elevator_instance_id"));
			
			//流程状态
			String elevator_approval = elevatorInfo.getString("elevator_approval");
			if(elevator_approval == null ){
				elevator_approval = "无需审核";
			}else if(elevator_approval != null && elevator_approval.equals("0")){
				elevator_approval = "待审核";
			}else if(elevator_approval != null && elevator_approval.equals("1")){
				elevator_approval = "审核中"; 
			}else if(elevator_approval != null && elevator_approval.equals("2")){
				elevator_approval = "通过";
			}else if(elevator_approval != null && elevator_approval.equals("3")){
				elevator_approval = "取消";
			}else{
				elevator_approval = "被驳回";
			}
			result.put("elevator_approval", elevator_approval);
			jsonArray.add(result);
		}
		
		return jsonArray;
	}
	
	/**
	 * 报价设置
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/setFunction")
	public ModelAndView setFunction() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		//后台获取所有菜单
		List<PageData> parentMenuList = null;
		List<PageData> twoMenuList = null;
		List<PageData> threeMenuList = null;
		List<PageData> fourMenuList = null;
		String flag = pd.getString("flag");//1模板 ; 2 正常
		String id = pd.getString("id");
		String models_name = pd.getString("models_name");
		String elevator_id = pd.getString("elevator_id");//电梯类型
		String product_id = pd.getString("product_id");//生产线
		//型号模板
		if(flag.equals("1")){
			
			try {
				pd = modelsService.findModelsById(pd);
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
		//型号正式
			try {
				pd = modelsInfoService.findModelsInfoById(pd);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//获取选配项配置 JSON
		String jsonStr = pd.getString("elevator_optional_json");
		//封装所有菜单
		JSONArray mapJsonArray = new JSONArray();
		
		if(jsonStr != null && !"".equals(jsonStr)){
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
		
		//基础配置选中
		List<PageData> elevatorBaseCheckedId = new ArrayList<>();
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
				
		PageData pds = new PageData();
		pds.put("parentId", "1");
		//电梯类型集合
		List<PageData> elevatorList = elevatorService.findAllElevator();
		//速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		//基础项集合
		List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pds);
		//级联菜单
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pds);
		
		//非标配置初始化
		JSONArray nonstandardJsonArrays = new JSONArray();
		//获取非标项配置 JSON
		String nonstandardJson = pd.getString("elevator_nonstandard_json");
		
		if(nonstandardJson != null && !"".equals(nonstandardJson)){
			JSONArray nonstandardJsonArray = JSONArray.fromObject(nonstandardJson);
			if(nonstandardJsonArray.size()>0){
				for(int i=0;i<nonstandardJsonArray.size();i++){
					JSONObject jsonObject = nonstandardJsonArray.getJSONObject(i);
					String parentMenu = jsonObject.getString("parentMenu");
					String twoMenu = jsonObject.getString("twoMenu");
					String threeMenu = jsonObject.getString("threeMenu");
					PageData parent = new PageData();
					parent.put("parentId", "1");
					parent.put("elevator_id", elevator_id);
					PageData one = new PageData();
					PageData two = new PageData();
					PageData three = new PageData();
					
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
					nonstandardJsonArrays.add(temp);
					
				}
			}
			
		}
		
		//电梯
		mv.addObject("nonstandardJsonArrays", nonstandardJsonArrays);
		mv.addObject("mapJsonArray", mapJsonArray);
		mv.addObject("elevatorBaseCheckedId", elevatorBaseCheckedId);
		mv.addObject("elevatorCascadeList",elevatorCascadeList);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorBaseList", elevatorBaseList);
		mv.addObject("elevatorList", elevatorList);
		
		mv.addObject("pd",pd);
		mv.addObject("flag",flag);
		mv.addObject("id", id);
		mv.addObject("models_name", models_name);
		mv.addObject("product_id",product_id);
		mv.addObject("msg", "functionEnit");
		
		List<PageData> cascadeList = offerService.findCascadeListByElevator(elevator_id);
		if (cascadeList.size() > 0) {
            //构建多叉数
            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            MultipleTree tree = new MultipleTree();
            dataList = ConvertPageDataToList.make(cascadeList);
            Node node = tree.makeTreeWithOderNo(dataList, 1);
            mv.addObject("cascade", node);
		}
		
		if(elevator_id != null && elevator_id.equals("1")){
    		mv.setViewName("system/offer/function_set");
		}else if(elevator_id != null && elevator_id.equals("2")){
			mv.setViewName("system/offer/homeModels_set");
		}else if(elevator_id != null && elevator_id.equals("3")){
			mv.setViewName("system/offer/specialModels_set");
		}else if(elevator_id != null && elevator_id.equals("4")){
			/*mv.setViewName("system/offer/functionset");*/
			mv.setViewName("system/offer/escalatorModels_set");
		}
		return mv;
	}
	
	/**
	 * 电梯报价流程审核配置
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/elevatorHandleManage")
	public ModelAndView elevatorHandleManage() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		String flag = pd.getString("flag");//1模板 ; 2 正常
		String id = pd.getString("id");
		String state = pd.getString("state");
		String elevator_id = pd.getString("elevator_id");//电梯类型
		String item_id = pd.getString("item_id");
		String models_id = pd.getString("models_id");
		//型号模板
		if(flag.equals("1")){
			
			try {
				pd = modelsService.findModelsById(pd);
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
		//型号正式
			try {
				pd = modelsInfoService.findModelsInfoById(pd);
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//编辑时查询
		String elevator_nonstandard_info = modelsInfoService.findNonstandardJsonById(models_id);
		if(elevator_nonstandard_info!=null&&!elevator_nonstandard_info.equals("")){
    		JSONArray jsonArray = JSONArray.fromObject(elevator_nonstandard_info);
    		for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				String centreId = jsonObj.get("centre_id").toString();
				mv.addObject(centreId, jsonObj.toString().replaceAll("\"", "'"));
				System.out.println(jsonObj.toString());
			}
		}

		PageData pds = new PageData();
		pds.put("parentId", "1");
		//电梯类型集合
		List<PageData> elevatorList = elevatorService.findAllElevator();
		//速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		//基础项集合
		List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pds);
		//级联菜单
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pds);
		//加载非标项描述
		List<PageData> ncPdList = offerService.findNonstandardCentreByItemId(item_id);
		
		List<PageData> cascadeList = offerService.findCascadeListByElevator(elevator_id);
		if (cascadeList.size() > 0) {
            //构建多叉数
            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            MultipleTree tree = new MultipleTree();
            dataList = ConvertPageDataToList.make(cascadeList);
            Node node = tree.makeTreeWithOderNo(dataList, 1);
            mv.addObject("cascade", node);
		}
		
		//电梯
		mv.addObject("ncPdList", ncPdList);
		/*mv.addObject("nonstandardJsonArrays", nonstandardJsonArrays);
		mv.addObject("mapJsonArray", mapJsonArray);
		mv.addObject("elevatorBaseCheckedId", elevatorBaseCheckedId);*/
		mv.addObject("elevatorCascadeList",elevatorCascadeList);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorBaseList", elevatorBaseList);
		mv.addObject("elevatorList", elevatorList);
		
		mv.addObject("pd",pd);
		mv.addObject("flag",flag);
		mv.addObject("id", id);
		mv.addObject("state", state);
		mv.addObject("msg", "saveNonstandardJson");
		mv.setViewName("system/offer/elevator_handle");
		return mv;
	}
	
	/**
	 * 电梯报价流程审核配置
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/elevatorHandleManages")
	public ModelAndView elevatorHandleManages() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		//后台获取所有菜单
		List<PageData> parentMenuList = null;
		List<PageData> twoMenuList = null;
		List<PageData> threeMenuList = null;
		List<PageData> fourMenuList = null;
		String flag = pd.getString("flag");//1模板 ; 2 正常
		String id = pd.getString("id");
		String models_name = pd.getString("models_name");
		String elevator_id = pd.getString("elevator_id");//电梯类型
		//型号模板
		if(flag.equals("1")){
			
			try {
				pd = modelsService.findModelsById(pd);
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
		//型号正式
			try {
				pd = modelsInfoService.findModelsInfoById(pd);
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//获取选配项配置 JSON
		String jsonStr = pd.getString("elevator_optional_json");
		//封装所有菜单
		JSONArray mapJsonArray = new JSONArray();
		
		if(jsonStr != null && !"".equals(jsonStr)){
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
		
		//基础配置选中
		List<PageData> elevatorBaseCheckedId = new ArrayList<>();
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
				
		PageData pds = new PageData();
		pds.put("parentId", "1");
		//电梯类型集合
		List<PageData> elevatorList = elevatorService.findAllElevator();
		//速度参数集合
		List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
		//重量参数集合
		List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
		//基础项集合
		List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pds);
		//级联菜单
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pds);
		
		//非标配置初始化
		JSONArray nonstandardJsonArrays = new JSONArray();
		//获取非标项配置 JSON
		String nonstandardJson = pd.getString("elevator_nonstandard_json");
		
		if(nonstandardJson != null && !"".equals(nonstandardJson)){
			JSONArray nonstandardJsonArray = JSONArray.fromObject(nonstandardJson);
			if(nonstandardJsonArray.size()>0){
				for(int i=0;i<nonstandardJsonArray.size();i++){
					JSONObject jsonObject = nonstandardJsonArray.getJSONObject(i);
					String parentMenu = jsonObject.getString("parentMenu");
					String twoMenu = jsonObject.getString("twoMenu");
					String threeMenu = jsonObject.getString("threeMenu");
					PageData parent = new PageData();
					parent.put("parentId", "1");
					parent.put("elevator_id", elevator_id);
					PageData one = new PageData();
					PageData two = new PageData();
					PageData three = new PageData();
					
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
					nonstandardJsonArrays.add(temp);
					
				}
			}
			
		}
		
		//电梯
		mv.addObject("nonstandardJsonArrays", nonstandardJsonArrays);
		mv.addObject("mapJsonArray", mapJsonArray);
		mv.addObject("elevatorBaseCheckedId", elevatorBaseCheckedId);
		mv.addObject("elevatorCascadeList",elevatorCascadeList);
		mv.addObject("elevatorSpeedList", elevatorSpeedList);
		mv.addObject("elevatorWeightList", elevatorWeightList);
		mv.addObject("elevatorBaseList", elevatorBaseList);
		mv.addObject("elevatorList", elevatorList);
		
		mv.addObject("pd",pd);
		mv.addObject("flag",flag);
		mv.addObject("id", id);
		mv.addObject("models_name", models_name);
		mv.addObject("msg", "functionEnit");
		mv.setViewName("system/offer/elevator_handles");
		return mv;
	}
	
	/**
	 * 计算电梯价钱
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/offerCountTotalPrice")
	@ResponseBody
	public Object offerCountTotalPrice() throws Exception{
		PageData pd = this.getPageData();
		String str = pd.getString("str");
		JSONObject result = new JSONObject();
		double countPrice = 0.00;
		String price = "";
		if(str!=null && !"".equals(str)){
			String[] strArray = str.split(",");
			for(int i=0;i<strArray.length;i++){
				PageData pds = new PageData();
				pd.put("product_id", strArray[i]);
				pds = productService.findProductById(pd);
				BigDecimal bd = (BigDecimal) pds.get("product_price");
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
	 * 功能保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "functionEnit")
	@ResponseBody
	public ModelAndView functionEnit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		String processDefinitionKey = "";   //流程1
		String elevator_id = pd.getString("elevator_id");// 类型
		
		//shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData userId = new PageData();
		userId = (PageData) session.getAttribute("userpds");
		String USER_ID = userId.getString("USER_ID");
		
		//非标项配置单 
		String elevator_nonstandardform_json = pd.getString("elevator_nonstandardform_json");
		JSONArray nonstandardForm = null;
		if(elevator_nonstandardform_json != null && !"".equals(elevator_nonstandardform_json)){	//非标描述不为空
			nonstandardForm = JSONArray.fromObject(elevator_nonstandardform_json);
			modelsInfoService.nonstandardCentreDelete(pd);
			if(nonstandardForm.size()>0){
				for(int i=0;i<nonstandardForm.size();i++){
					JSONObject jsonObject = nonstandardForm.getJSONObject(i);
					PageData nonstandard = new PageData();
					nonstandard.put("id", pd.get("id"));
					nonstandard.put("elevator_no", jsonObject.get("elevator_no"));
					nonstandard.put("elevator_description", jsonObject.get("elevator_description"));
					//插入非标描述记录
					modelsInfoService.nonstandardCentreAdd(nonstandard);
					//添加了非标描述,将elevator_info订单表中flag改为2(型号为非标类型)
					elevatorInfoService.updateElevatorInfoFlag(pd.get("id").toString());
					
					jsonObject.put("centre_id", nonstandard.get("centre_id").toString());
				}
				pd.put("elevator_nonstandardform_json", nonstandardForm.toString().replaceAll("\"", "'"));
			}
			
			PageData elevatorAudit = new PageData(); 
			elevatorAudit = modelsInfoService.findElevatorAuditById(pd);
			if(elevatorAudit == null){
				try{
					if(elevator_id.equals("1") && nonstandardForm.size()>0){
						processDefinitionKey = "generalElevator";
					}
					if(elevator_id.equals("2") && nonstandardForm.size()>0){
						processDefinitionKey = "householdElevator";
					}
					if(elevator_id.equals("3") && nonstandardForm.size()>0){
						processDefinitionKey = "specialElevator";
					}
					
					
					// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
					WorkFlow workFlow = new WorkFlow();
					IdentityService identityService = workFlow.getIdentityService();
					identityService.setAuthenticatedUserId(USER_ID);
					Object id = pd.get("id");
					String businessKey = "tb_elevator_info.id."+id;
					
					//设置变量
					Map<String,Object> variables = new HashMap<String,Object>();
					variables.put("user_id", USER_ID);
					ProcessInstance proessInstance=null; //流程1
					if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
						proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
					}
					if(proessInstance !=null){
						pd.put("elevator_instance_id", proessInstance.getId());
					}else {
						/*sysAgentService.agentDeleteById(id);*/
						mv.addObject("msg", "failed");
						mv.addObject("err", "保存失败！");
					}
					modelsInfoService.elevatorAuditAdd(pd);
				}catch(Exception e){
					mv.addObject("msg", "failed");
					mv.addObject("err", "流程不存在！");
				}
			}
		}else{	//非标描述为空
			elevator_nonstandardform_json = null;
			//没有添加非标描述,将elevator_info订单表中flag改为1(型号为非非标类型)
			elevatorInfoService.resetElevatorInfoFlag(pd.get("id").toString());
			pd.put("elevator_nonstandardform_json", elevator_nonstandardform_json);
		}
		
		
		PageData modelsInfo = new PageData();
		PageData pds = new PageData();
		
		try {
			modelsInfo = modelsInfoService.findModelsInfoById(pd);
			if(modelsInfo!=null){
				modelsInfoService.modelsInfoUpdate(pd);
			}else{
				pd.remove("models_id");
				modelsInfoService.modelsInfoAdd(pd);
			}
			pds.put("id", pd.get("id"));
			pds.put("flag", "2");
			pds.put("models_id", pd.get("models_id"));
			pds.put("total", pd.get("models_price"));
			elevatorInfoService.elevatorDetailsToModelsUpdate(pds);
			
			
			mv.addObject("id", "SetFunction");
			mv.addObject("form", "functionSetForm");
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
	 * 统计项目总价
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "countProjectPrice")
	@ResponseBody
	public Object countProjectPrice() throws Exception{
		PageData pd = this.getPageData();
		JSONObject result = new JSONObject();
		List<PageData> elevatorInfoList = elevatorInfoService.findElevatorDetailsListById(pd);
		double price = 0;
		String item_total="";
		for(PageData page:elevatorInfoList){
			String total = page.getString("total");
			if(total!=null && !"".equals(total)){
				BigDecimal bd = new BigDecimal(total);
				Double elevator_total_price = bd.doubleValue();
				price = Arith.add(price, elevator_total_price);
			}
		}
		item_total = Arith.doubleForString(price);
		result.put("item_total", item_total);
		
		return result;
	}
	
	/**
	 * 跳转到电梯非标配置页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "elevatorNonstandard")
	public ModelAndView elevatorNonstandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData nonstandardCentre = new PageData();
		pd.put("elevator_nonstandard_state", "1");
		//加载非标集合
		List<PageData> elevatorNonstandardList =  elevatorConfigService.findElevatorNonstandardList(pd);
		//加载非标中心表
		nonstandardCentre =  modelsInfoService.findNonstandardCentreById(pd);
		mv.addObject("pd", pd);
		mv.addObject("nonstandardCentre", nonstandardCentre);
		mv.addObject("elevatorNonstandardList", elevatorNonstandardList);
		mv.addObject("msg", "elevatorNonstandardManager");
		mv.setViewName("system/offer/elevatorNonstandard_edit");
		return mv;
	}
	
	//非标配置管理
	@RequestMapping(value = "elevatorNonstandardManager")
	public ModelAndView elevatorNonstandardManager(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		List<PageData> nonstandardCentreList = new ArrayList<>();
		List<PageData> parentNonstandard = new ArrayList<>();
		
		try {
			
			modelsInfoService.nonstandardCentreUpadate(pd);
			nonstandardCentreList = modelsInfoService.findNonstandardCentreListById(pd);
			for(PageData pds:nonstandardCentreList){
				String elevator_nonstandard_id = pds.getString("elevator_nonstandard_id");
				if(elevator_nonstandard_id == null && "".equals(elevator_nonstandard_id)){
				}
				String parentId = pds.getString("elevator_nonstandard_id");
				pds.put("parentId", parentId);
				pds.remove("elevator_nonstandard_id");
				parentNonstandard.add(getAllParentNonstandard(pds));
			}
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "elevatorNonstandard");
		mv.addObject("from", "elevatorNonstandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 获取所有非标父类菜单
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getAllParentNonstandard(PageData pd) throws Exception{
		PageData parentNonstandard = new PageData();
		parentNonstandard  = elevatorCascadeService.findAllParentElevatorCascadeByParentId(pd);
		if(parentNonstandard!=null){
			getAllParentNonstandard(parentNonstandard);
		}
		
		return parentNonstandard;
	}

	
	
	/**
     * 启动流程
     * @return
     */
    @RequestMapping(value = "/apply")
    @ResponseBody
    public Object apply(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String,Object> map = new HashMap<>();
    	try{
    		//shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            
            
           
            String elevator_instance_id = pd.getString("elevator_instance_id");   //电梯流程
           
            //  如存在key启动电梯种类流程
            if(elevator_instance_id!=null && !"".equals(elevator_instance_id)){
            	WorkFlow workFlow = new WorkFlow();
            	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(elevator_instance_id).singleResult();
            	Map<String,Object> variables = new HashMap<String,Object>();
            	//设置任务角色
            	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
            	//设置流程变量
            	variables.put("action", "提交申请");
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
            	pd.put("elevator_approval", 1);
            	modelsInfoService.updateElevatorApproval(pd);
            	workFlow.getTaskService().complete(task.getId());
            	//获取下一个任务的信息
                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(elevator_instance_id).singleResult();
                map.put("task_name",tasks.getName());
                map.put("msg", "success");
            }
           
            
           
            
    	}catch(Exception e){
    		logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     * 显示待我处理的电梯类型
     * @param page
     * @return
     */
    @RequestMapping(value= "/listPendingElevator")
    public ModelAndView listPendingElevator(Page page){
    	  ModelAndView mv = this.getModelAndView();
          PageData pd = new PageData();
          pd = this.getPageData();
          
          try{
        	  //shiro管理的session
              Subject currentUser = SecurityUtils.getSubject();
              Session session = currentUser.getSession();

              PageData pds = new PageData();
              pds = (PageData) session.getAttribute("userpds");
              String USER_ID = pds.getString("USER_ID");
              page.setPd(pds);
              mv.setViewName("system/offer/offer_list");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              List<PageData> elevatorInfoList = new ArrayList<>();
              WorkFlow workFlow = new WorkFlow();
              // 等待处理的任务
              //设置分页数据
              int firstResult;//开始游标
              int maxResults;//结束游标
              int showCount = page.getShowCount();//默认为10
              int currentPage = page.getCurrentPage();//默认为0
              if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                  firstResult = currentPage;//从0开始
                  currentPage+=1;//当前为第一页
                  maxResults = showCount;
              }else{
                  firstResult = showCount*(currentPage-1);
                  maxResults = firstResult+showCount;
              }
              //设置分页数据
              int totalResult = 0;
              
              //常规梯
              List<Task> generalElevatorToHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("generalElevator").orderByTaskCreateTime().desc().active().list();
              //家用梯
              List<Task> householdElevatorToHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("householdElevator").orderByTaskCreateTime().desc().active().list();
              //特种梯
              List<Task> specialElevatorToHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("specialElevator").orderByTaskCreateTime().desc().active().list();
              List<Task> generalElevatorToHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("generalElevator").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
              List<Task> householdElevatorToHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("householdElevator").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
              List<Task> specialElevatorToHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("specialElevator").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
              
              if(generalElevatorToHandleList != null && generalElevatorToHandleList.size()>0){
            	  for (Task task : generalElevatorToHandleList) {
            		  
            		  PageData elevatorInfo = new PageData();
            		  String processInstanceId = task.getProcessInstanceId();
            		  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            		  String businessKey = processInstance.getBusinessKey();
            		  if (!StringUtils.isEmpty(businessKey)){
            			  //leave.leaveId.
            			  String[] info = businessKey.split("\\.");
            			  elevatorInfo.put(info[1],info[2]);
            			  elevatorInfo = modelsInfoService.findElevatorAuditHandleAllById(elevatorInfo);
            			  elevatorInfo.put("task_name",task.getName());
            			  elevatorInfo.put("task_id",task.getId());
            			  //判断是否签收
            			  if(task.getAssignee()!=null){
            				  elevatorInfo.put("type","1");//待处理
            			  }else{
            				  elevatorInfo.put("type","0");//待签收
            			  }
            			  //判断当前环节
            			  if(task.getTaskDefinitionKey().equals("GeneralElevatorTechnicalSupport")){
            				  //如果是工厂审核
            				  elevatorInfo.put("state", "2");
            			  }else if(task.getTaskDefinitionKey().equals("Finance")){
            				  //如果是财务审核
            				  elevatorInfo.put("state", "3");
            			  }
            		  }
            		  elevatorInfoList.add(elevatorInfo);
            	  }
              }else if(householdElevatorToHandleList !=null && householdElevatorToHandleList.size()>0){
            	  	for (Task task : householdElevatorToHandleList) {
            		  
            		  PageData elevatorInfo = new PageData();
            		  String processInstanceId = task.getProcessInstanceId();
            		  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            		  String businessKey = processInstance.getBusinessKey();
            		  if (!StringUtils.isEmpty(businessKey)){
            			  //leave.leaveId.
            			  String[] info = businessKey.split("\\.");
            			  elevatorInfo.put(info[1],info[2]);
            			  elevatorInfo = modelsInfoService.findElevatorAuditHandleAllById(elevatorInfo);
            			  elevatorInfo.put("task_name",task.getName());
            			  elevatorInfo.put("task_id",task.getId());
            			  if(task.getAssignee()!=null){
            				  elevatorInfo.put("type","1");//待处理
            			  }else{
            				  elevatorInfo.put("type","0");//待签收
            			  }
            		  }
            		  elevatorInfoList.add(elevatorInfo);
            	  }
              }else{
            	  	for (Task task : specialElevatorToHandleList) {
            		  
            		  PageData elevatorInfo = new PageData();
            		  String processInstanceId = task.getProcessInstanceId();
            		  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            		  String businessKey = processInstance.getBusinessKey();
            		  if (!StringUtils.isEmpty(businessKey)){
            			  //leave.leaveId.
            			  String[] info = businessKey.split("\\.");
            			  elevatorInfo.put(info[1],info[2]);
            			  elevatorInfo = modelsInfoService.findElevatorAuditHandleAllById(elevatorInfo);
            			  elevatorInfo.put("task_name",task.getName());
            			  elevatorInfo.put("task_id",task.getId());
            			  if(task.getAssignee()!=null){
            				  elevatorInfo.put("type","1");//待处理
            			  }else{
            				  elevatorInfo.put("type","0");//待签收
            			  }
            		  }
            		  elevatorInfoList.add(elevatorInfo);
            	  }
              }
              if(generalElevatorToHandleListCount.size()>0){
            	  //设置分页数据
            	  totalResult = generalElevatorToHandleListCount.size();
              }else if(householdElevatorToHandleListCount.size()>0){
            	  totalResult = householdElevatorToHandleListCount.size();
              }else{
            	  totalResult = specialElevatorToHandleListCount.size();
              }
              
              if (totalResult<=showCount) {
                  page.setTotalPage(1);
              }else{
                  int count = Integer.valueOf(totalResult/showCount);
                  int  mod= totalResult%showCount;
                  if (mod>0) {
                      count =count+1;
                  }
                  page.setTotalPage(count);
              }
              page.setTotalResult(totalResult);
              page.setCurrentResult(elevatorInfoList.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(1);
              page.setPageStrForActiviti(page.getPageStrForActiviti());

              //待处理任务的count
              pd.put("count",totalResult);

              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("elevatorInfoList", elevatorInfoList);
              mv.addObject("userpds", pds);
          }catch(Exception e){
        	  logger.error(e.toString(), e);
          }
          return mv;
    }
    
    /**
     * 签收任务
     *
     * @return
     */
    @RequestMapping("/claim")
    @ResponseBody
    public Object claim() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 签收任务
            List<PageData> agents = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","签收失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 跳到电梯类型办理任务页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandleElevator")
    public ModelAndView goHandleElevator() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("system/offer/offer_handle");
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 请求跳转电梯审核配置页面
     * @param agent_no
     * @return
     */
    @RequestMapping(value = "/toElevatorHandleView")
    public ModelAndView toElevatorHandleView(){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	//后台获取所有菜单
		List<PageData> parentMenuList = null;
		List<PageData> twoMenuList = null;
		List<PageData> threeMenuList = null;
		List<PageData> fourMenuList = null;
		String id = pd.getString("id");
		String elevator_id = "";//电梯类型
		String flag = "" ;//1模板 ; 2 正常
    	try {
    		//电梯信息
			PageData elevatorInfo = elevatorInfoService.findElevatorInfoId(pd);
			//型号信息
			pd = modelsInfoService.findModelsInfoById(elevatorInfo);
			elevator_id = elevatorInfo.getString("elevator_id");
			flag = elevatorInfo.getString("flag");//1模板 ; 2 正常
			//获取选配项配置 JSON
			String jsonStr = pd.getString("elevator_optional_json");
			//封装所有菜单
			JSONArray mapJsonArray = new JSONArray();
			
			if(jsonStr != null && !"".equals(jsonStr)){
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
			
			//基础配置选中
			List<PageData> elevatorBaseCheckedId = new ArrayList<>();
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
					
			PageData pds = new PageData();
			pds.put("parentId", "1");
			//电梯类型集合
			List<PageData> elevatorList = elevatorService.findAllElevator();
			//速度参数集合
			List<PageData> elevatorSpeedList = elevatorParameterService.findElevatorSpeedListById(pds);
			//重量参数集合
			List<PageData> elevatorWeightList = elevatorParameterService.findElevatorWeightListById(pds);
			//基础项集合
			List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pds);
			//级联菜单
			List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pds);
			
			//非标配置初始化
			JSONArray nonstandardJsonArrays = new JSONArray();
			//获取非标项配置 JSON
			String nonstandardJson = pd.getString("elevator_nonstandard_json");
			
			if(nonstandardJson != null && !"".equals(nonstandardJson)){
				JSONArray nonstandardJsonArray = JSONArray.fromObject(nonstandardJson);
				if(nonstandardJsonArray.size()>0){
					for(int i=0;i<nonstandardJsonArray.size();i++){
						JSONObject jsonObject = nonstandardJsonArray.getJSONObject(i);
						String parentMenu = jsonObject.getString("parentMenu");
						String twoMenu = jsonObject.getString("twoMenu");
						String threeMenu = jsonObject.getString("threeMenu");
						PageData parent = new PageData();
						parent.put("parentId", "1");
						parent.put("elevator_id", elevator_id);
						PageData one = new PageData();
						PageData two = new PageData();
						PageData three = new PageData();
						
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
						nonstandardJsonArrays.add(temp);
						
					}
				}
				
			}
			
			//电梯
			mv.addObject("nonstandardJsonArrays", nonstandardJsonArrays);
			mv.addObject("mapJsonArray", mapJsonArray);
			mv.addObject("elevatorBaseCheckedId", elevatorBaseCheckedId);
			mv.addObject("elevatorCascadeList",elevatorCascadeList);
			mv.addObject("elevatorSpeedList", elevatorSpeedList);
			mv.addObject("elevatorWeightList", elevatorWeightList);
			mv.addObject("elevatorBaseList", elevatorBaseList);
			mv.addObject("elevatorList", elevatorList);
			mv.addObject("pd", pd);
			mv.addObject("id", id);
			mv.addObject("flag", flag);
			mv.addObject("HasSameKey", "false");
	        mv.addObject("msg", "edit");
	        mv.setViewName("system/offer/elevatorHand_view");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 处理电梯类别非标任务
     * @return
     */
    @RequestMapping("/handleElevator")
    public ModelAndView handleAgent(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        
        try{
        	 //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 办理任务
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            Map<String,Object> variables = new HashMap<String ,Object>();
            boolean isApproved = false;
            String action = pd.getString("action");
            int status;
            if (action.equals("approve")){
                isApproved = true;
                //如果是hr审批
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
                if (task.getTaskDefinitionKey().equals("Finance")){
                    status = 2;//已完成
                    pd.put("elevator_approval",2);
                    modelsInfoService.updateElevatorApproval(pd);
                }
            }else if(action.equals("reject")) {
                status = 4;//被驳回
                pd.put("elevator_approval",4);
                modelsInfoService.updateElevatorApproval(pd);
            }
            String  comment = (String) pd.get("comment");
            if (isApproved){
                variables.put("action","批准");
            }else{
                variables.put("action","驳回");
            }
            variables.put("approved",isApproved);
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
            mv.addObject("msg", "success");
        }catch(Exception e){
        	 mv.addObject("msg", "failed");
             mv.addObject("err", "办理失败！");
             logger.error(e.toString(), e);
        }
        mv.addObject("id", "handleLeave");
        mv.addObject("form", "handleLeaveForm");
        mv.setViewName("save_result");
    	return mv;
    }
	
    
    /**
     * 显示我已经处理的电梯类型非标
     *
     * @return
     */
    @RequestMapping("/listDoneElevator")
    public ModelAndView listDoneElevator(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/offer/offer_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务
            List<PageData> dleaves = new ArrayList<>();
            List<HistoricTaskInstance> historicTaskGeneralElevator = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("generalElevator").orderByTaskCreateTime().desc().list();
            List<HistoricTaskInstance> historicTaskHouseholdElevator = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("householdElevator").orderByTaskCreateTime().desc().list();
            List<HistoricTaskInstance> historicTaskSpecialElevator = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("specialElevator").orderByTaskCreateTime().desc().list();
            //移除重复的
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            if(historicTaskGeneralElevator != null && historicTaskGeneralElevator.size()>0){
            	
            	for (HistoricTaskInstance instance:historicTaskGeneralElevator) {
            		String processInstanceId = instance.getProcessInstanceId();
            		HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            		String businessKey = historicProcessInstance.getBusinessKey();
            		map.put(businessKey,instance);
            	}
            }else if(historicTaskHouseholdElevator != null && historicTaskHouseholdElevator.size()>0){
            	for (HistoricTaskInstance instance:historicTaskHouseholdElevator) {
            		String processInstanceId = instance.getProcessInstanceId();
            		HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            		String businessKey = historicProcessInstance.getBusinessKey();
            		map.put(businessKey,instance);
            	}
            }else{
            	for (HistoricTaskInstance instance:historicTaskSpecialElevator) {
            		String processInstanceId = instance.getProcessInstanceId();
            		HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            		String businessKey = historicProcessInstance.getBusinessKey();
            		map.put(businessKey,instance);
            	}
            }
            Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()){
                Map.Entry entry = (Map.Entry) iter.next();
                list.add((HistoricTaskInstance)entry.getValue());
            }

            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage+=1;//当前为第一页
                maxResults = showCount;
            }else{
                firstResult = showCount*(currentPage-1);
                maxResults = firstResult+showCount;
            }
            int listCount =(list.size()<=maxResults?list.size():maxResults);
            //从分页参数开始
            for (int i = firstResult; i <listCount ; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData elevatorInfo = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        elevatorInfo.put(info[1],info[2]);
                        elevatorInfo = modelsInfoService.findElevatorAuditHandleAllById(elevatorInfo);
                        //检查申请者是否是本人,如果是,跳过
                        if (elevatorInfo.getString("requester_id").equals(USER_ID))
                            continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (runing==null||runing.size()<=0){
                        	elevatorInfo.put("isRuning",0);

                        }else{
                        	elevatorInfo.put("isRuning",1);
                            //正在运行,查询当前的任务信息
                            Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                            elevatorInfo.put("task_name",task.getName());
                            elevatorInfo.put("task_id",task.getId());
                        }
                        dleaves.add(elevatorInfo);
                }
            }

            //设置分页数据
            int totalResult = list.size();
            if (totalResult<=showCount) {
                page.setTotalPage(1);
            }else{
                int count = Integer.valueOf(totalResult/showCount);
                int  mod= totalResult%showCount;
                if (mod>0) {
                    count =count+1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(dleaves.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(2);
            page.setPageStrForActiviti(page.getPageStrForActiviti());

            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count",toHandleListCount.size());

            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("dleaves", dleaves);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 重新申请电梯类别非标
     *
     * @return
     */
    @RequestMapping("/restartElevator")
    @ResponseBody
    public Object restartElevator() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 签收任务
            List<PageData> agents = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);

            Map<String,Object> variables = new HashMap<String,Object>();
            variables.put("action","重新提交");
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id);
            
          
        	//更新业务数据的状态
        	pd.put("elevator_approval",1);
        	modelsInfoService.updateElevatorApproval(pd);;
            
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 请求跳转标准配置
     * @param agent_no
     * @return
     */
    @RequestMapping(value = "/toElevatorBaseView")
    public ModelAndView toElevatorBase(){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try {
			List<PageData> elevatorBaseList = elevatorConfigService.findElevatorBaseListById(pd);
			
			
			mv.addObject("HasSameKey", "false");
	        mv.addObject("msg", "edit");
	        mv.addObject("elevatorBaseList", elevatorBaseList);
	        mv.setViewName("system/offer/elevatorBase_view");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    
    /**
     *tb_offer导出excel 
     */
    @RequestMapping(value="toExcelOffer")
    public ModelAndView toExcelOffer(){
    	ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("报价id");
			titles.add("报价单名称");
			titles.add("项目id");
			titles.add("项目名称");
			titles.add("报价总金额");
			titles.add("创建时间");
			dataMap.put("titles", titles);
			
			List<PageData> offerList = offerService.findOfferList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < offerList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", offerList.get(i).get("offer_id").toString());
				vpd.put("var2", offerList.get(i).getString("offer_name"));
				vpd.put("var3", offerList.get(i).getString("item_id"));
				vpd.put("var4", offerList.get(i).getString("item_name"));
				vpd.put("var5", offerList.get(i).get("offer_total_price"));
				vpd.put("var6", offerList.get(i).get("create_time").toString());
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
     *导入Excel 
     */
    @RequestMapping(value="importExcelOffer")
    @ResponseBody
    public Object importExcelOffer(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    				// 获取系统时间
    				String df = DateUtil.getTime().toString();
    	        	pd.put("offer_name", listPd.get(i).getString("var1"));
    	        	pd.put("item_id", listPd.get(i).getString("var2"));
    	        	pd.put("item_name", listPd.get(i).getString("var3"));
    	        	pd.put("offer_total_price", listPd.get(i).getString("var4"));
    	        	pd.put("create_time", df);
    	        	//保存至数据库
    	        	offerService.saveOffer(pd);
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
     *跳转到工厂配置非标电梯页面 
     */
    @RequestMapping(value="goSetElevator")
    public ModelAndView goSetEelevator(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		PageData pd = this.getPageData();
    		String centre_id = pd.getString("centre_id");
    		String elevator_id = pd.getString("elevator_id");
    		String models_id = pd.getString("models_id");
    		String state = pd.getString("state");
    		
    		List<PageData> cascadeList = offerService.findCascadeListByElevator(elevator_id);
    		if (cascadeList.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.make(cascadeList);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("cascade", node);
    		}
    		
    		//编辑时查询
    		String elevator_nonstandard_info = modelsInfoService.findNonstandardJson(centre_id);
    		String jsonStr = "";
    		if(elevator_nonstandard_info!=null&&!elevator_nonstandard_info.equals("")){
        		JSONArray jsonArray = JSONArray.fromObject(elevator_nonstandard_info);
        		JSONArray nonstandardArray = new JSONArray();
        		for(int i =0;i<jsonArray.size();i++){
    				JSONObject jsonObj = jsonArray.getJSONObject(i);
    				String centreId = jsonObj.get("centre_id").toString();
    				if(centreId.equals(centre_id)){
    					nonstandardArray.add(jsonObj);
    				}
    			}
        		jsonStr = nonstandardArray.toString().replaceAll("\"", "'");
    		}
    		mv.setViewName("system/offer/set_elevator");
    		mv.addObject("msg", "saveElevatorSet");
    		mv.addObject("centre_id", centre_id);
    		mv.addObject("jsonStr", jsonStr);
    		mv.addObject("elevator_id", elevator_id);
    		mv.addObject("models_id", models_id);
    		mv.addObject("state", state);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveElevatorSet")
    public ModelAndView saveElevatorSet(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		PageData pd = this.getPageData();
    		String elevator_nonstandard_json = pd.get("elevator_nonstandard_json").toString().replaceAll("\"", "'");
    		String centre_id = pd.get("centre_id").toString();
    		String countsPrice = pd.get("countsPrice").toString();
    		
    		mv.setViewName("system/offer/save_result");
    		mv.addObject("id", "setElevator");
    		mv.addObject("centre_id", centre_id);
    		mv.addObject("countsPrice", countsPrice);
    		mv.addObject("elevator_nonstandard_json", elevator_nonstandard_json);
    	}catch(Exception e){
    		logger.error(e);
    	}
    	return mv;
    }
    
    /**
     *工厂配置完成,更新非标型号表数据 
     */
    @RequestMapping(value="saveNonstandardJson")
    public ModelAndView saveNonstandardJson(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		PageData pd = this.getPageData();
    		if(pd.containsKey("elevator_nonstandard_json")){
        		pd.put("elevator_nonstandard_json", pd.get("elevator_nonstandard_json").toString().replaceAll("\"", "'"));
    		}
    		modelsInfoService.updateNonstandardJson(pd);
    		mv.setViewName("save_result");
			mv.addObject("msg", "success");
			mv.addObject("id", "SetFunction");
			mv.addObject("form", "leaveForm2");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
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
