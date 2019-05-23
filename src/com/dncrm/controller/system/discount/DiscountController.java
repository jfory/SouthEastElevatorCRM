package com.dncrm.controller.system.discount;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.engine.IdentityService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.discount.DiscountService;
import com.dncrm.service.system.elevatorInfo.ElevatorInfoService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;


/**
 *@类名称: DiscountController
 *@创建人: arisu
 *@创建时间: 2016/11/17 
 */

@Controller
@RequestMapping(value="/discount")
public class DiscountController extends BaseController {
	
	@Resource(name="itemService")
	private ItemService itemService;
	@Resource(name="discountService")
	private DiscountService discountService;
	@Resource(name="elevatorInfoService")
	private ElevatorInfoService elevatorInfoService;
	
	
	/**
	 *列表申请
	 */
	@RequestMapping(value="listItem")
	public ModelAndView listItem(){
		ModelAndView mv = new ModelAndView();
		try{
			String USER_ID = getUser().getUSER_ID();
			List<PageData> discountList = discountService.findDiscountApplyListByUserId(USER_ID);
			/*PageData selPd = new PageData();
			String USER_ID = getUser().getUSER_ID();
			selPd.put("USER_ID", USER_ID);
			selPd.put("item_status", "2");
			List<PageData> itemList = itemService.findItemListByInputUserAndStatus(selPd);
			mv.addObject("itemList", itemList);*/
			/*mv.addObject("discountList", discountList);*/
			mv.addObject("itemList", setItemList(discountList));
			mv.addObject("active", 1);
			mv.setViewName("system/discount/discount_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *显示待我处理 
	 */
	@RequestMapping(value="listPend")
	public ModelAndView listPend(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> discounts = new ArrayList<PageData>();
			PageData pd = new PageData();
			String USER_ID = getUser().getUSER_ID();
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
            /*List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountHouseHold").orderByTaskCreateTime().desc().active().list();
            List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountHouseHold").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);*/
            List<Task> toHandleList = getHandleList();
            for (Task task : toHandleList) {

                PageData discount = new PageData();
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                    String[] info = businessKey.split("\\.");
                    discount.put(info[1],info[2]);
                    /*discount = discountService.findApplyById(discount);*/
                    discount = discountService.findDiscountPend(discount);
                    discount.put("task_name",task.getName());
                    discount.put("task_id",task.getId());
                    if(task.getAssignee()!=null){
                    	discount.put("type","1");//待处理
                    }else{
                    	discount.put("type","0");//待签收
                    }
                }
                discounts.add(discount);
            }
            //设置分页数据
            /*int totalResult = toHandleListCount.size();*/
            int totalResult = getHandleListCount();
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
            page.setCurrentResult(discounts.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            //待处理任务的count
            /*pd.put("count",toHandleListCount.size());*/
            pd.put("count", totalResult);
            mv.addObject("pd",pd);
            mv.addObject("active", "2");
            /*mv.addObject("discounts", discounts);*/

            mv.addObject("itemApplyList", setItemList(discounts));
            mv.setViewName("system/discount/discount_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到新增折扣申请页面 
	 */
	@RequestMapping(value="goAddDiscount")
	public ModelAndView goAddDiscount(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		PageData selPd = new PageData();
		try{
			pd = this.getPageData();
			if(pd.containsKey("item_id")){			//从报价页面跳转
				String item_id = pd.get("item_id").toString();
				mv.addObject("item_id_menu", item_id);
			}
			String USER_ID = getUser().getUSER_ID();
			selPd.put("USER_ID", USER_ID);
			selPd.put("item_status", "2");
			List<PageData> itemList = itemService.findItemListByInputUserAndStatus(selPd);
			mv.addObject("itemList", itemList);
			mv.addObject("msg", "saveDiscount2");
			mv.setViewName("system/discount/discount_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存新增折扣申请 
	 */
	@RequestMapping(value="saveDiscount")
	public ModelAndView saveDiscount(){
		ModelAndView mv = new ModelAndView();
		PageData dataPd = new PageData();
		try{
			dataPd = this.getPageData();
			String elevatorIds = dataPd.get("elevatorIds").toString();
			String USER_ID = getUser().getUSER_ID();
			Float applyDiscount = Float.parseFloat(dataPd.get("discount").toString());
			Integer status = checkDiscount(USER_ID, applyDiscount);
			if(status==1){
				dataPd.put("status", "0");//0 新建申请,未提交
			}else{
				dataPd.put("status", "2");//2 销售人员符合折扣权限,通过审批流程
			}
			dataPd.put("USER_ID", USER_ID);
			if(elevatorIds.lastIndexOf(",")>-1){
				for(String id : elevatorIds.split(",")){
					dataPd.put("info_id", id);
					discountService.saveDiscountApply(dataPd);
				}
			}else{
				dataPd.put("info_id", elevatorIds);
				discountService.saveDiscountApply(dataPd);
			}
			mv.addObject("msg", "success");
			mv.addObject("id", "EditDiscount");
			mv.addObject("form", "DiscountForm1");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存新增折扣申请 
	 */
	@RequestMapping(value="saveDiscount2")
	public ModelAndView saveDiscount2(){
		ModelAndView mv = new ModelAndView();
		PageData dataPd;
		try{
			dataPd = this.getPageData();
			
			String discountJson = dataPd.get("discountJson").toString();
			JSONArray jsonArray = JSONArray.fromObject(discountJson);
			PageData pd = new PageData();
			for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				pd.put("item_id", dataPd.get("item_id").toString());
				pd.put("info_id", jsonObj.get("infoId").toString());
				pd.put("discount", Float.parseFloat(jsonObj.get("discount").toString()));
				pd.put("status", "0");//0 新建申请,未提交
				pd.put("USER_ID", getUser().getUSER_ID());
				pd.put("descript", dataPd.get("descript").toString());
				discountService.saveDiscountApply(pd);
			}
			mv.addObject("msg", "success");
			mv.addObject("id", "EditDiscount");
			mv.addObject("form", "DiscountForm1");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "error");
			logger.error(e.getMessage());
		}
		return mv;
	}
	
	/**
	 *提交启动流程 
	 */
	@RequestMapping(value="startApply")
	@ResponseBody
	public Object startApply(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData dataPd = new PageData();
		String processDefinitionKey = "";
		String USER_ID = getUser().getUSER_ID();
		try{
			dataPd = this.getPageData();
			String elevatorType = dataPd.get("elevator_id").toString();//电梯类型
			//获取符合的流程key
			processDefinitionKey = getInstanceKey(elevatorType);
			// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
    		WorkFlow workFlow = new WorkFlow();
    		IdentityService identityService = workFlow.getIdentityService();
    		identityService.setAuthenticatedUserId(USER_ID);
    		String id = dataPd.get("id").toString();
    		String businessKey = "tb_discount_apply.id."+id;
    		//设置变量
    		Map<String,Object> variables = new HashMap<String,Object>();
        	variables.put("action", "提交申请");
    		variables.put("user_id", USER_ID);
    		ProcessInstance proessInstance=null; 
    		if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
    			proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
    		}
    		if(proessInstance!=null){
    			Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(proessInstance.getId()).singleResult();
    			//设置任务角色
            	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
            	//设置流程变量
            	variables.put("action", "提交申请");
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
            	workFlow.getTaskService().complete(task.getId(),variables);
    			dataPd.put("discount_instance", proessInstance.getId());
    			dataPd.put("status", "1");// 1 销售人员提交申请
    		}
    		discountService.editDiscountInstance(dataPd);
    		map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *重新提交 
	 */
	@RequestMapping(value="restartApply")
	@ResponseBody
	public Object restartApply(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			PageData editPd = new PageData();
			pd = this.getPageData();
			PageData discountPd = discountService.findApplyById(pd);
			String elevator_id = discountPd.get("elevator_id").toString();
			String id = discountPd.get("id").toString();
			String instance_id = discountPd.get("discount_instance").toString();
			WorkFlow workFlow = new WorkFlow();
			String USER_ID = getUser().getUSER_ID();
			Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
			if("2".equals(elevator_id)){
				//家用梯
	    		
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
                Map<String,Object> variables = new HashMap<String,Object>();
            	//设置流程变量
            	variables.put("action", "重新提交");
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);

	            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
	            workFlow.getTaskService().setVariablesLocal(task.getId(),variables);
	            Authentication.setAuthenticatedUserId(USER_ID);
	            
            	workFlow.getTaskService().complete(task.getId(),variables);
            	editPd.put("id", id);
            	editPd.put("status", "1");// 1 销售人员提交申请
	    		discountService.editDiscountStatus(editPd);
	    		map.put("msg", "success");
			}
		}catch(Exception e){
			map.put("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	
	/**
	 *签收任务 
	 */
	@RequestMapping(value="claim")
	@ResponseBody
	public Object claim(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			WorkFlow workFlow = new WorkFlow();
			pd = this.getPageData();
			String USER_ID = getUser().getUSER_ID();
			String task_id = pd.get("task_id").toString();
            workFlow.getTaskService().claim(task_id,USER_ID);
            map.put("msg", "success");
		}catch(Exception e){
            map.put("msg", "faild");
            map.put("err", "签收失败");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转办理意见页面 
	 */
	@RequestMapping(value="goHandleTask")
	public ModelAndView goHandleTask(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("pd", pd);
			mv.setViewName("system/discount/discount_handle");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存办理意见 
	 */
	@RequestMapping(value="handleTask")
	public ModelAndView handelTask(){
		ModelAndView mv = new ModelAndView();
		try{
			WorkFlow workFlow = new WorkFlow();
            Map<String,Object> variables = new HashMap<String ,Object>();
			PageData pd = new PageData();
			pd = this.getPageData();
			String USER_ID = getUser().getUSER_ID();
			String id = pd.get("id").toString();
			String task_id = pd.get("task_id").toString();
			String action = pd.get("action").toString();
			String comment = pd.get("comment").toString();
			Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
			String flowName = task.getTaskDefinitionKey()+"Status";
			if("pass".equals(action)){//批准
				Float applyDiscount = Float.parseFloat(discountService.findApplyDiscountById(id));
				Integer status = checkDiscount(USER_ID, applyDiscount);
				if("companyTaskStatus".equals(flowName)){//股份公司领导审核批准,直接通过
					variables.put(flowName, 2);
				}else{
					if(status==1){//需要上报申请
						variables.put(flowName, 1);
			        	variables.put("action", "上报申请");
					}else{//折扣可以通过
						variables.put(flowName, 2);
			        	variables.put("action", "审核通过");
						pd.put("USER_ID", USER_ID);
						if("factoryTaskStatus".equals(flowName)){
							setDiscountUsed(pd);
						}
					}
				}
			}else if("reject".equals(action)){//驳回
				variables.put(flowName, 0);
	        	variables.put("action", "驳回");
				pd.put("status", "3"); // 3 申请被驳回
				discountService.editDiscountStatus(pd);
			}
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(USER_ID);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
			
			
			mv.addObject("msg", "success");
			mv.addObject("id", "HandleTask");
			mv.addObject("form", "DiscountForm2");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *根据项目id和折扣查询需要申请折扣的梯种信息 
	 */
	@RequestMapping(value="setDiscountInfo")
	@ResponseBody
	public Object setDiscountInfo(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData dataPd = new PageData();
		try{
			dataPd = this.getPageData();
			String item_id = dataPd.get("item_id").toString();
			String item_status = itemService.findItemStatusByItemId(item_id);
			List<PageData> discountList = elevatorInfoService.findElevatorInfoListByItemId(item_id);
			map.put("discountList", discountList);
			map.put("status", item_status);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *根据折扣判断是否需要上级审批 
	 */
	public Integer checkDiscount(String USER_ID,Float applyDiscount)throws Exception{
		Integer status = -1;//返回状态码
		PageData discountConfig = discountService.findDiscountConfigByUserId(USER_ID);
		if(discountConfig!=null){
			Float configDiscount = Float.parseFloat(discountConfig.get("discount").toString());
			if(applyDiscount>configDiscount){
				//需要申请折扣
				status=1;
			}else{
				//无需申请
				status=0;
			}
		}else{
			//此用户没有配置折扣优惠,需要上报申请
			status=1;
		}
		return status;
	}
	
	/**
	 *根据申请人id和梯种判断流程 
	 */
	private String getInstanceKey(String elevatorType){
		String processDefinitionKey = "";
		try{
			String USER_ID = getUser().getUSER_ID();
			if("1".equals(elevatorType)){//常规梯销售
				processDefinitionKey = "discountNormal";
			}else if("2".equals(elevatorType)){//家用梯小业主销售流程
				processDefinitionKey = "discountHouseHold";
			}else if("3".equals(elevatorType)){//特种梯销售
				processDefinitionKey = "discountSpecialN";
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return processDefinitionKey;
	}
	
	/**
	 *计算额度并向折扣额度记录表插入数据 
	 */
	public void setDiscountUsed(PageData pd){
		try{
			//查询申请表
			PageData discountPd = discountService.findApplyById(pd);
			//根据info_id查tb_elevator_info
			String id = discountPd.get("info_id").toString();
			//取到折扣申请的总价和折扣
			Integer total = Integer.parseInt(elevatorInfoService.findTotalById(id));
			Float discount = Float.parseFloat(discountPd.get("discount").toString());
			//计算消耗的折扣额度
			double limit_used = total-(total*(1-(discount/100)));
			String USER_ID = pd.get("USER_ID").toString();
			//年份编号
			String yearNo = new SimpleDateFormat("yyyy").format(new Date());
			//插入tb_discount_used
			PageData insertPd = new PageData();
			insertPd.put("USER_ID", USER_ID);
			insertPd.put("limit_used", limit_used);
			insertPd.put("year_no", yearNo);
			discountService.saveDiscountUsed(insertPd);
			//查询用户该年份限额
			PageData selPd = new PageData();
			selPd.put("USER_ID", USER_ID);
			selPd.put("year_no", yearNo);
			PageData discountConfig = discountService.findDiscountConfigByUserId(USER_ID);
			float configUsed = Float.parseFloat(discountConfig.get("limit_config").toString());
			//查询用户该年份已使用额度
			float countUsed = discountService.findCountUserdByUserIdAndYearNo(selPd);
			if(countUsed>configUsed){
				//提醒警告
				System.out.println("!===========warning==========!");
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 获取当前登录用户查询所有待审任务集合总数
	 */
	public Integer getHandleListCount(){
		Integer count = 0;
		try{
			String USER_ID = getUser().getUSER_ID();
			WorkFlow workFlow = new WorkFlow();
            List<Task> discountHouseHoldCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountHouseHold").orderByTaskCreateTime().desc().active().list();
            List<Task> discountNormalCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountNormal").orderByTaskCreateTime().desc().active().list();
            List<Task> discountSpecialNCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountSpecialN").orderByTaskCreateTime().desc().active().list();
            count = discountHouseHoldCount.size()+discountNormalCount.size()+discountSpecialNCount.size();
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return count;
	}
	
	/**
	 * 获取当前登录用户查询所有待审任务集合
	 */
	public List<Task> getHandleList(){
		List<Task> list = new ArrayList<Task>();
		try{
			String USER_ID = getUser().getUSER_ID();
			WorkFlow workFlow = new WorkFlow();
            List<Task> discountHouseHoldList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountHouseHold").orderByTaskCreateTime().desc().active().list();
            List<Task> discountNormalList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountNormal").orderByTaskCreateTime().desc().active().list();
            List<Task> discountSpecialNList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("discountSpecialN").orderByTaskCreateTime().desc().active().list();
            list.addAll(discountHouseHoldList);
            list.addAll(discountNormalList);
            list.addAll(discountSpecialNList);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return list;
	}
	
	/**
	 *将折扣列表包装入项目列表,并判断是否有权限 
	 */
	public List<PageData> setItemList(List<PageData> list){
		List<String> itemIdList = new ArrayList<String>();
		List<PageData>resultList = new ArrayList<PageData>();
		try{
			for(PageData discountPd : list){
				itemIdList.add(discountPd.get("item_id").toString());
			}
			if(itemIdList.size()>0){
				List<PageData>itemList = itemService.findItemListByIdArray(itemIdList);
				for(PageData itemPd : itemList){
					String item_id = itemPd.get("item_id").toString();
					List<PageData> resultDiscountList = new ArrayList<PageData>();
					List<PageData> discountList = discountService.findDiscountApplyByItemId(item_id);
					boolean flag  = false;
					String type = "";
					String task_id = "";
					String task_name = "";
					for(PageData discountPd : discountList){
						for(PageData discount : list){
							if(discountPd.get("id").toString().equals(discount.get("id").toString())){
								flag = true;
								type = discount.containsKey("type")?discount.get("type").toString():"";
								task_id = discount.containsKey("task_id")?discount.get("task_id").toString():"";
								task_name = discount.containsKey("task_name")?discount.get("task_name").toString():"";
							}
						}
						if(flag){
							discountPd.put("operateStatus", "1");
						}else{
							discountPd.put("operateStatus", "0");
						}
						discountPd.put("type", type);
						discountPd.put("task_id", task_id);
						discountPd.put("task_name", task_name);
						resultDiscountList.add(discountPd);
						flag = false;
						type="";
						task_id = "";
						task_name = "";
					}
					itemPd.put("resultDiscountList", resultDiscountList);
					resultList.add(itemPd);
				}
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return resultList;
	}
	
	
	/**
	 *折扣设置树 
	 */
	@RequestMapping(value="treeListDiscount")
	public ModelAndView treeListDiscount(){
		ModelAndView mv = new ModelAndView();
    	try{
    		List<PageData> pdList = discountService.findDiscountTreeList();
        	if (pdList.size() > 0) {
	            //构建多叉数
	            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	            MultipleTree tree = new MultipleTree();
                HashMap skins = new HashMap();
                skins.put("0","leafSkin");
                for(int i =1;i<15;i++){
                    skins.put(i+"","parentSkin");
                }
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin3(pdList,skins);
	            /*dataList = ConvertPageDataToList.makeWithType(pdList);*/
	            Node node = tree.makeTreeWithOderNo(dataList, 1);
	            mv.addObject("discount", node);
	        	/*JSONArray obj = JSONArray.fromObject(organizes);
	        	mv.addObject("organizes", obj);*/
        	}
        	mv.setViewName("system/discount/discount_config");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
	}
	
	/**
     *跳转到设置折扣页面 
     */
    @RequestMapping(value="goSetDiscountConfig")
    @ResponseBody
    public Object goSetDiscountConfig(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		String USER_ID = pd.get("id").toString();
    		PageData configPd = discountService.findDiscountConfigByUserId(USER_ID);
    		if(configPd!=null){
        		map.put("configPd", configPd);
        		map.put("canAdd", "0");
    		}else{
        		map.put("configPd", "");
        		map.put("canAdd", "1");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *跳转到新增折扣 
     */
    @RequestMapping(value="goAddDiscountConfig")
    public ModelAndView goAddDiscountConfig(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		mv.addObject("pd", pd);
    		mv.addObject("msg","saveDiscountConfig");
    		mv.addObject("operateType","add");
    		mv.setViewName("system/discount/config_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *跳转到修改折扣 
     */
    @RequestMapping(value="goEditDiscountConfig")
    public ModelAndView goEditDiscountConfig(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		pd = discountService.findDiscountConfigById((pd.get("id").toString()));
    		mv.addObject("pd", pd);
    		mv.addObject("msg","editDiscountConfig");
    		mv.addObject("operateType","edit");
    		mv.setViewName("system/discount/config_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *保存新增 
     */
    @RequestMapping(value="saveDiscountConfig")
    public ModelAndView saveDiscountConfig(){
    	ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		discountService.saveDiscountConfig(pd);
    		mv.addObject("msg", "success");
    		mv.addObject("id", "discountConfig");
    		mv.addObject("form", "discountConfigForm");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *保存修改
     */
    @RequestMapping(value="editDiscountConfig")
    public ModelAndView editDiscountConfig(){
    	ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		discountService.editDiscountConfig(pd);
    		mv.addObject("msg", "success");
    		mv.addObject("id", "discountConfig");
    		mv.addObject("form", "discountConfigForm");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *查询已使用额度 
     */
    @RequestMapping(value="usedQuery")
    public ModelAndView usedQuery(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
	
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================用户================================== */
	public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
}
