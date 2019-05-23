package com.dncrm.controller.system.contractNew;

import com.dncrm.common.WorkFlow;
import com.dncrm.common.getContractData;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.contract.ContractService;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/*import com.dncrm.common.getContractData;*/


@Controller
@RequestMapping("/contractNewInstallation")
public class ContractNewController_Installation extends BaseController 
{
	@Resource(name = "contractService")
	private ContractService contractService;
	
	@Resource(name="contractNewAzService")
	private ContractNewAzService contractNewAzService;
	
	@Resource(name="contractNewService")
	private ContractNewService contractNewService;
	
	/**
	 * 安装合同 列表
	 */
	@RequestMapping("/contractNewInstallation")
	public ModelAndView listItem(Page page) throws Exception
	{
		ModelAndView mv = this.getModelAndView();
		SelectByRole sbr = new SelectByRole();
		PageData pd = this.getPageData();
		try 
		{
			//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
			page.setPd(pd);
			List<PageData> contractNewAzList=contractNewAzService.AzContractlistPage(page);
			if(!contractNewAzList.isEmpty()){
              	for(PageData con : contractNewAzList){
              		String ACT_KEY = con.getString("ACT_KEY");
              		if(ACT_KEY!=null && !"".equals(ACT_KEY)){
              			WorkFlow workFlow = new WorkFlow();
              			List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).active().list();
              			if(task!=null&& task.size()>0){
              				for(Task task1:task)
              				{
              				con.put("task_id",task1.getId());
              				con.put("task_name",task1.getName());
              				}
              			}
              		}
              	}
              }
			//跳转位置
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("contractNewAzList", contractNewAzList);
			mv.setViewName("system/contractNewInstallation/contractNewDeviceInstallation");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	/**
	 * 设备合同列表
	 */
	@RequestMapping(value="goSoContract")
	public ModelAndView goSoContract(Page page)
	{
		ModelAndView mv = this.getModelAndView();
		SelectByRole sbr = new SelectByRole();
		PageData pd = this.getPageData();
		try 
		{
			//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
			page.setPd(pd);
			List<PageData> contractNewList=contractNewAzService.SoContractlistPage(page);
			//跳转位置
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("contractNewList", contractNewList);
			mv.setViewName("system/contractNewInstallation/contractNewDevice");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return mv;
	}
	
	
	/**
	 * 请求跳转新增页面
	 */
	@RequestMapping(value="goSave")
	public ModelAndView goSava()
	{		
		ModelAndView mv = new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		// 获取年月日
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100); // 生成随机3位数字
		String AZ_NO = ("AZ" + time + number); // 拼接为合同编号
		try 
		{
			String item_id=pd.get("HT_ITEM_ID").toString();
			pd.put("item_id", item_id);
			String HT_UUID=pd.get("HT_UUID").toString();
			//项目信息
			pd=contractNewService.findItemById(pd);
			pd.put("HT_UUID", HT_UUID);
			//电梯信息
			List<PageData> dtxxlist=contractNewService.findDtInfoByHtId(pd);
			//电梯总数
			PageData dtnum= contractNewService.findElevByItemId(pd);
			//报价总金额
			PageData bjje=contractNewService.findOfferByItemId(pd);
			
			pd.put("AZ_NO", AZ_NO);
			pd.put("DT_NUM", dtnum.get("DTNUM").toString());//电梯总数
			pd.put("TOTAL", bjje.get("total").toString());//报价总金额
			pd.put("offer_id", bjje.get("offer_id").toString());//报价id
			mv.addObject("pd", pd);
			mv.addObject("dtxxlist", dtxxlist);
			mv.addObject("msg","save");
			mv.setViewName("system/contractNewInstallation/contractNewInformationInstallation_edit");
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return mv;
	}

	//保存安装 合同新增
	@RequestMapping("/save")
	public ModelAndView save() 
	{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		String df=DateUtil.getTime().toString(); //获取系统时间
		
		pd=this.getPageData();
		Subject currentUser=SecurityUtils.getSubject();
		Session session=currentUser.getSession();
		PageData pds=new PageData();
		pds=(PageData) session.getAttribute("userpds");
		String USER_ID=pds.getString("USER_ID");
		try 
		{
			//合同审核流程 key
			String processDefinitionKey="ContractNewAZ";
			pd.put("KEY", processDefinitionKey);
			//查询流程是否存在
			List<PageData> SoContractList = contractNewService.SelAct_Key(pd);
			if(SoContractList!=null)
			{
				pd.put("AZ_UUID", UUID.randomUUID().toString());
				pd.put("ACT_KEY", "");
				pd.put("ACT_STATUS", "1");
				pd.put("INPUT_USER", USER_ID);
				pd.put("INPUT_TIME", df);
				 
				//保存付款方式
				String jsonFkfs=pd.get("jsonFkfs").toString();
				PageData FkfsPd = new PageData();
				JSONArray jsonArray2 = JSONArray.fromObject(jsonFkfs);
				for(int i =0;i<jsonArray2.size();i++)
				{
					JSONObject jsonObj = jsonArray2.getJSONObject(i);
					
					FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
					FkfsPd.put("FKFS_QS", jsonObj.get("FKFS_QS").toString());
					FkfsPd.put("FKFS_KX", jsonObj.get("FKFS_KX").toString());
					FkfsPd.put("FKFS_PDRQ", jsonObj.get("FKFS_PDRQ").toString());
					FkfsPd.put("FKFS_PCRQ", jsonObj.get("FKFS_PCRQ").toString());
					FkfsPd.put("FKFS_FKBL", jsonObj.get("FKFS_FKBL").toString());
					FkfsPd.put("FKFS_JE", jsonObj.get("FKFS_JE").toString());
					FkfsPd.put("FKFS_BZ", jsonObj.get("FKFS_BZ").toString());
					FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
					FkfsPd.put("FKFS_HT_UUID", pd.get("AZ_UUID").toString());
					FkfsPd.put("FKFS_FKTS", jsonObj.get("FKFS_FKTS").toString());
					//保存付款方式
					contractNewService.saveFkfs(FkfsPd);
				}
				
				//保存合同信息
				contractNewAzService.save(pd);
				mv.addObject("msg", "success");
			}
			else
			{
				mv.addObject("msg", "流程不存在");
			}
			
			//-----生成流程实例
			WorkFlow workFlow=new WorkFlow();
			IdentityService identityService=workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId=pd.get("AZ_UUID");
			String businessKey="tb_az_contract.AZ_UUID."+uuId;
			Map<String,Object> variables = new HashMap<String,Object>();
			variables.put("user_id", USER_ID);
			ProcessInstance proessInstance=null; //存放生成的流程实例id
			if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
			{
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
			}
			if(proessInstance!=null)
			{
				PageData aPd=new PageData();
				aPd.put("ACT_KEY", proessInstance.getId());
				aPd.put("AZ_UUID", pd.get("AZ_UUID").toString());
				//修改报价信息  （流程的key该为流程实例id）
				contractNewAzService.editAct_Key(aPd);
				//判断如果是提交进来的 启动流程
				/*if("TJ".equals(pd.getString("type")))
				{
					//调用启动安装合同流程的方法
					applyTJAZ(proessInstance.getId(),aPd.get("AZ_UUID").toString());
				}*/
				mv.addObject("msg", "success");
			}
			else
			{
				//删除付款方式
				contractNewAzService.deleteFkfs(pd);
				//删除合同信息
				contractNewAzService.deleteContract(pd);
				mv.addObject("msg", "failed");
				mv.addObject("err", "没有生成流程实例");
			}
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		mv.addObject("id", "InformationHTML");
		mv.addObject("form", "ContractNewAzForm");
		mv.setViewName("save_result");
		return mv;
	}
	/**
 	 * 启动流程
 	 * @return
 	 */
     @RequestMapping("/applyTJAZ")
     @ResponseBody
     public Object applyTJAZ(String ACT_KEYTJ, String AZ_UUID){
     	PageData pd = new PageData();
     	/*pd = this.getPageData();*/
     	pd.put("AZ_UUID", AZ_UUID);
     	pd.put("ACT_KEY", ACT_KEYTJ);
     	Map<String,Object> map = new HashMap<>();
     	try{
     		//shiro管理的session
             Subject currentUser = SecurityUtils.getSubject();
             Session session = currentUser.getSession();
             PageData pds = new PageData();
             pds = (PageData) session.getAttribute("userpds");
             String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
             String ACT_KEY = pd.getString("ACT_KEY");       //流程实例id
             // 如果流程的实例id存在，启动流程
             if(ACT_KEY!=null && !"".equals(ACT_KEY)){
             	WorkFlow workFlow = new WorkFlow();
             	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
             	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
             	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
             	Map<String,Object> variables = new HashMap<String,Object>();
             	//设置任务角色
             	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
             	//签收任务
             	workFlow.getTaskService().claim(task.getId(), USER_ID);
             	//设置流程变量
             	variables.put("action", "提交申请");
             	
             	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
             	pd.put("ACT_STATUS", 2);   //流程状态  2代表流程启动,等待审核
             	//更新流程状态
             	contractNewAzService.editAct_Status(pd);
             	workFlow.getTaskService().complete(task.getId());
             	//获取下一个任务的信息
                 /*Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                 map.put("task_name",tasks.getName());
                 map.put("status", "1");*/
             }
             if((ACT_KEY !=null && !"".equals(ACT_KEY))){
             	map.put("status", "3");
             }
             map.put("msg", "success");
     	}catch(Exception e){
     		logger.error(e.toString(), e);
             map.put("msg", "failed");
             map.put("err", "系统错误");
     	}
     	return JSONObject.fromObject(map);
     }	
	/**
	 * 请求跳转 编辑页面
	 */
	@RequestMapping(value="goEdit")
	public ModelAndView goEdit()
	{		
		ModelAndView mv = new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		try 
		{
			//根据UUID获取合同信息
			pd=contractNewAzService.findAzConByUUid(pd);
			pd.put("item_id", pd.get("AZ_ITEM_ID").toString());
			//项目信息
			//PageData Itempd=contractNewService.findItemById(pd);
			PageData Itempd = contractNewService.findItemDetailForOfferId(new PageData("offer_id", pd.get("AZ_OFFER_ID")));
			//电梯信息
			List<PageData> dtxxlist=contractNewService.findDtInfoByHtId(pd);
			//付款方式
			List<PageData> dfkfslist=contractNewAzService.findFkfsByHtId(pd);
			
			//电梯总数
			//PageData dtnum= contractNewService.findElevByItemId(pd);
			PageData dtnum= contractNewService.findElevByOfferId(pd);
			//报价总金额
			//PageData bjje=contractNewService.findOfferByItemId(pd);
			
			pd.put("item_no", Itempd.get("item_no").toString());
			pd.put("item_name", Itempd.get("item_name").toString());
			pd.put("customer_name", Itempd.getString("customer_name"));
			pd.put("province_name", Itempd.get("province_name").toString());
			pd.put("city_name", Itempd.get("city_name").toString());
			pd.put("county_name", Itempd.get("county_name").toString());
			pd.put("address_info", Itempd.get("address_info").toString());
			
			pd.put("DT_NUM", dtnum.get("DTNUM").toString());//电梯总数
			pd.put("TOTAL", pd.get("TOTAL").toString());//报价总金额
			pd.put("offer_id", pd.get("AZ_OFFER_ID").toString());//报价id
			mv.addObject("pd", pd);
			mv.addObject("dtxxlist", dtxxlist);
			mv.addObject("dfkfslist", dfkfslist);
			mv.addObject("msg","edit");
			mv.setViewName("system/contractNewInstallation/contractNewInformationInstallation_edit");
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return mv;
	}
	
	//保存安装合同   编辑 
	@RequestMapping("/edit")
	public ModelAndView setContract() 
	{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		try 
		{
			//删除付款方式
			contractNewAzService.deleteFkfs(pd);
			//保存付款方式
			String jsonFkfs=pd.get("jsonFkfs").toString();
			PageData FkfsPd = new PageData();
			JSONArray jsonArray2 = JSONArray.fromObject(jsonFkfs);
			for(int i =0;i<jsonArray2.size();i++)
			{
				JSONObject jsonObj = jsonArray2.getJSONObject(i);
				
				FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
				FkfsPd.put("FKFS_QS", jsonObj.get("FKFS_QS").toString());
				FkfsPd.put("FKFS_KX", jsonObj.get("FKFS_KX").toString());
				FkfsPd.put("FKFS_PDRQ", jsonObj.get("FKFS_PDRQ").toString());
				FkfsPd.put("FKFS_PCRQ", jsonObj.get("FKFS_PCRQ").toString());
				FkfsPd.put("FKFS_FKBL", jsonObj.get("FKFS_FKBL").toString());
				FkfsPd.put("FKFS_JE", jsonObj.get("FKFS_JE").toString());
				FkfsPd.put("FKFS_BZ", jsonObj.get("FKFS_BZ").toString());
				FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
				FkfsPd.put("FKFS_HT_UUID", pd.get("AZ_UUID").toString());
				FkfsPd.put("FKFS_FKTS", jsonObj.get("FKFS_FKTS").toString());
				//保存付款方式
				contractNewService.saveFkfs(FkfsPd);
			}
			
			//编辑 合同信息
			contractNewAzService.edit(pd);
			
			//判断如果是提交进来的 启动流程
			if("TJ".equals(pd.getString("type")))
			{
				//调用启动安装合同流程的方法
				applyTJAZ(pd.getString("ACT_KEY"),pd.getString("AZ_UUID"));
			}
			
			
			mv.addObject("msg", "success");
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		mv.addObject("id", "InformationHTML");
		mv.addObject("form", "ContractNewAzForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 请求跳转 查看页面
	 */
	@RequestMapping(value="goView")
	public ModelAndView goView()
	{		
		ModelAndView mv = new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		try 
		{
			//根据UUID获取合同信息
			pd=contractNewAzService.findAzConByUUid(pd);
			pd.put("item_id", pd.get("AZ_ITEM_ID").toString());
			//项目信息
			//PageData Itempd=contractNewService.findItemById(pd);
			PageData Itempd = contractNewService.findItemDetailForOfferId(new PageData("offer_id", pd.get("AZ_OFFER_ID")));
			//电梯信息
			List<PageData> dtxxlist=contractNewService.findDtInfoByHtId(pd);
			//付款方式
			List<PageData> dfkfslist=contractNewAzService.findFkfsByHtId(pd);
			
			//电梯总数
			PageData dtnum= contractNewService.findElevByOfferId(pd);
			//报价总金额
			//PageData bjje=contractNewService.findOfferByItemId(pd);
			
			pd.put("item_no", Itempd.getString("item_no"));
			pd.put("item_name", Itempd.get("item_name").toString());
			pd.put("customer_name", Itempd.getString("customer_name"));
			pd.put("province_name", Itempd.get("province_name").toString());
			pd.put("city_name", Itempd.get("city_name").toString());
			pd.put("county_name", Itempd.get("county_name").toString());
			pd.put("address_info", Itempd.get("address_info").toString());
			
			pd.put("DT_NUM", dtnum.get("DTNUM").toString());//电梯总数
			pd.put("TOTAL", pd.get("TOTAL").toString());//报价总金额
			pd.put("offer_id", pd.get("AZ_OFFER_ID").toString());//报价id
			mv.addObject("pd", pd);
			mv.addObject("dtxxlist", dtxxlist);
			mv.addObject("dfkfslist", dfkfslist);
			mv.addObject("msg","view");
			mv.setViewName("system/contractNewInstallation/contractNewInformationInstallation_edit");
			
			Map<String, String> hc = getHC();
	        hc.put("cha", "1");
			mv.addObject(Const.SESSION_QX, hc); // 按钮权限
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return mv;
	}
	
	/**
	 * 删除数据
	 * @param
	 */
	@RequestMapping("/goDelAzCon")
	@ResponseBody
	public Object Delect() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//删除付款方式
			contractNewAzService.deleteFkfs(pd);
			//删除合同信息
			contractNewAzService.deleteContract(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 * 启动流程
	 * @return
	 */
    @RequestMapping("/apply")
    @ResponseBody
    public Object apply(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String,Object> map = new HashMap<>();
    	try{
     		//付款方式
			List<PageData> dfkfslist=contractNewAzService.findFkfsByHtId(pd);
			if(dfkfslist == null || dfkfslist.size() == 0) {
                map.put("msg", "failed");
                map.put("err", "请添加付款方式");
                return JSONObject.fromObject(map);
            }
    		
    		//shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            String ACT_KEY = pd.getString("ACT_KEY");       //流程实例id
            // 如果流程的实例id存在，启动流程
            if(ACT_KEY!=null && !"".equals(ACT_KEY)){
            	WorkFlow workFlow = new WorkFlow();
            	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
            	Map<String,Object> variables = new HashMap<String,Object>();
            	//设置任务角色
            	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
            	//设置流程变量
            	variables.put("action", "提交申请");
            	
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
            	pd.put("ACT_STATUS", 2);   //流程状态  2代表流程启动,等待审核
            	//更新流程状态
            	contractNewAzService.editAct_Status(pd);
            	workFlow.getTaskService().complete(task.getId());
            	//获取下一个任务的信息
                /*Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                map.put("task_name",tasks.getName());
                map.put("status", "1");*/
            }
            if((ACT_KEY !=null && !"".equals(ACT_KEY))){
            	map.put("status", "3");
            }
            map.put("msg", "success");
    	}catch(Exception e){
    		logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
    	}
    	return JSONObject.fromObject(map);
    }

    /**
     * 显示待我处理的
     * @param page
     * @return
     */
    @RequestMapping(value= "/ContractAudit")
    public ModelAndView listPendingContractor(Page page){
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
              mv.setViewName("system/contractNewInstallation/contractNew_Audit");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              //存放任务集合
              List<PageData> ContractList = new ArrayList<>();
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
              //List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractNewAZ").orderByTaskCreateTime().desc().active().list();
              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractNewAZ").orderByTaskCreateTime().desc().active().list();
                 for (Task task : toHandleList) {
                  PageData e_offer = new PageData();
                  String processInstanceId = task.getProcessInstanceId();
                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                  String businessKey = processInstance.getBusinessKey();
                  if (!StringUtils.isEmpty(businessKey)){
                      //leave.leaveId.
                      String[] info = businessKey.split("\\.");
                      e_offer.put(info[1],info[2]);
                      if(e_offer.get("AZ_UUID")!="" && e_offer.get("AZ_UUID")!=null)
                      {
                    	  //根据uuiid查询信息
                          e_offer=contractNewAzService.findAzConByUUid(e_offer);
                          if(e_offer==null) continue;
                          e_offer.put("task_name",task.getName());
                          e_offer.put("task_id",task.getId());
                          if(task.getAssignee()!=null){
                        	  e_offer.put("type","1");//待处理
                          }
                          else
                          {
                        	  e_offer.put("type","0");//待签收
                          }
                          ContractList.add(e_offer);
                      }
                      
                  }
                  
              }
                 
              //设置分页数据
              int totalResult = ContractList.size();
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
              page.setCurrentResult(ContractList.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(0);
              page.setPageStrForActiviti(page.getPageStrForActiviti());
              mv.addObject("page", null);
              //待处理任务的count
              pd.put("count",totalResult);
              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("ContractList", ContractList);
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
    @SuppressWarnings("unchecked")
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
     * 跳到办理任务页面
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandStra")
    public ModelAndView goHandleAgent() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        
        String task_id=pd.get("task_id").toString();
        //根据UUID获取合同信息
		pd=contractNewAzService.findAzConByUUid(pd);
		pd.put("item_id", pd.get("AZ_ITEM_ID").toString());
		//项目信息
		//PageData Itempd=contractNewService.findItemById(pd);
		PageData Itempd = contractNewService.findItemDetailForOfferId(new PageData("offer_id", pd.get("AZ_OFFER_ID")));
		//电梯信息
		List<PageData> dtxxlist=contractNewService.findDtInfoByHtId(pd);
		//付款方式
		List<PageData> dfkfslist=contractNewAzService.findFkfsByHtId(pd);
		
		//电梯总数
		//PageData dtnum= contractNewService.findElevByItemId(pd);
		PageData dtnum= contractNewService.findElevByOfferId(pd);
		//报价总金额
		//PageData bjje=contractNewService.findOfferByItemId(pd);
		
		pd.put("item_no", Itempd.get("item_no").toString());
		pd.put("item_name", Itempd.get("item_name").toString());
		pd.put("customer_name", Itempd.getString("customer_name"));
		pd.put("province_name", Itempd.get("province_name").toString());
		pd.put("city_name", Itempd.get("city_name").toString());
		pd.put("county_name", Itempd.get("county_name").toString());
		pd.put("address_info", Itempd.get("address_info").toString());
		
		pd.put("DT_NUM", dtnum.get("DTNUM").toString());//电梯总数
		pd.put("TOTAL", pd.get("TOTAL").toString());//报价总金额
		pd.put("offer_id", pd.getString("AZ_OFFER_ID"));//报价id
		pd.put("task_id", task_id);//
		mv.addObject("pd", pd);
		mv.addObject("dtxxlist", dtxxlist);
		mv.addObject("dfkfslist", dfkfslist);
		mv.addObject("msg","view");
        
        
        
        mv.setViewName("system/contractNewInstallation/contractNew_Handle");
        mv.addObject("pd", pd);
        
        Map<String, String> hc = getHC();
        hc.put("cha", "1");
		mv.addObject(Const.SESSION_QX, hc); // 按钮权限
        
        return mv;
    }
    
    /**
     * 办理任务
     * @return
     */
    @RequestMapping("/handleAgent")
    public ModelAndView handleAgent(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        PageData pdUUID = new PageData();
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
            boolean isEnd=false;
            String action = pd.getString("action");
            @SuppressWarnings("unused")
			int status;
            if (action.equals("approve")){
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
               
                	status = 2;    //已完成
                    pd.put("ACT_STATUS",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    isApproved=true;
                    contractNewAzService.editAct_StatusEnd(pd);  //修改流程状态并增加并行审核记录
                    
                    pdUUID=contractNewAzService.findAzConByUUid(pd);
                    
                    if(pdUUID.getString("act_parallel_type").equals("2")) {
                    	//status = 2;    //已完成
                        pd.put("ACT_STATUS",4);             //流程状态   4.已通过
                        //variables.put("approved", true);
                        //isApproved=true;
                        isEnd=true;
                        contractNewAzService.editAct_Status(pd);  //修改最终流程状态
                        
                        //流程审核通过生成应收款记录
                        setYSK(pd);
                    }
                    
                
            }else if(action.equals("reject")) {
                status = 4;   
                pd.put("ACT_STATUS",5);             //流程状态  5代表 被驳回
                variables.put("approved", false);
                contractNewAzService.editAct_StatusError(pd);  //修改流程状态并重置审核记录
            }
            String  comment = (String) pd.get("comment");
            if (isApproved){
                variables.put("action","批准");
            }else{
                variables.put("action","驳回");
            }
            if(isEnd)
            {
            	variables.put("action","通过,流程结束！");
            }
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
     * 根据付款方式 生成应收款
     * @param pd
     */
    public void setYSK(PageData pd)
    {
    	try 
    	{
    		PageData YskPd=new PageData();
			//根据id获取合同信息
    		pd=contractNewAzService.findAzConByUUid(pd);
    		//根据合同ID获取付款方式信息
			List<PageData> dfkfslist=contractNewAzService.findFkfsByHtId(pd);
			for(PageData fkfs : dfkfslist)
			{
				YskPd.put("YSK_UUID", UUID.randomUUID().toString());
				YskPd.put("YSK_HT_ID", fkfs.get("FKFS_HT_UUID").toString());
				YskPd.put("YSK_ITEM_ID", pd.get("AZ_ITEM_ID").toString());
				YskPd.put("YSK_FKFS_ID", fkfs.get("FKFS_UUID").toString());
				YskPd.put("YSK_QS", fkfs.get("FKFS_QS").toString());
				YskPd.put("YSK_KX", fkfs.get("FKFS_KX").toString());
				YskPd.put("YSK_YSJE", fkfs.get("FKFS_JE").toString());
				YskPd.put("YSK_YSRQ", fkfs.get("FKFS_PDRQ").toString());
				YskPd.put("YSK_PCTS", fkfs.get("FKFS_PCRQ").toString());
				YskPd.put("YSK_KP_ID", "");
				YskPd.put("YSK_LK_ID", "");
				YskPd.put("YSK_BZ", fkfs.get("FKFS_BZ").toString());
				YskPd.put("YSK_AZ_NO", pd.get("AZ_NO").toString());
				YskPd.put("item_name", pd.get("item_name").toString());
				contractNewAzService.saveYsk(YskPd);
				
			}
    		
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
    
    /**
     * 重新提交流程
     *
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/restartAgent")
    @ResponseBody
    public Object restartAgent() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
     		//付款方式
			List<PageData> dfkfslist=contractNewAzService.findFkfsByHtId(pd);
			if(dfkfslist == null || dfkfslist.size() == 0) {
                map.put("msg", "failed");
                map.put("err", "请添加付款方式");
                return JSONObject.fromObject(map);
            }
        	
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");  //流程id
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
        	pd.put("ACT_STATUS", 2); //流程状态 2.待审核
        	contractNewAzService.editAct_Status(pd);  //修改流程状态
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 显示我已经处理的任务
     *
     * @return
     */
    @RequestMapping("/listDoneOffer")
    public ModelAndView listDoneE_offer(Page page) {
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
            mv.setViewName("system/contractNewInstallation/contractNew_Audit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务集合
            List<PageData> ContractList = new ArrayList<>();
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            
            //获取已处理的任务
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("ContractNew").orderByTaskCreateTime().desc().list();
            //移除重复的
            for (HistoricTaskInstance instance:historicTaskInstances)
            {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }
            
            @SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()){
                @SuppressWarnings("rawtypes")
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
            //int listCount =(list.size()<=maxResults?list.size():maxResults);
            int listCount = list.size();
            //从分页参数开始
            for (int i = firstResult; i <listCount ; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData stra = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        stra.put(info[1],info[2]);
                        if(stra.get("AZ_UUID")!="" && stra.get("AZ_UUID")!=null)
                        {
                        	stra=contractNewAzService.findAzConByUUid(stra);
                        	 //检查申请者是否是本人,如果是,跳过
                            if (stra==null||stra.getString("INPUT_USER").equals(USER_ID))
                            continue;
                            //查询当前流程是否还存在
                            List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                            if (stra!=null) {
                            	if (runing==null||runing.size()<=0){
                            		stra.put("isRuning",0);
                                }else{
                                	stra.put("isRuning",1);
                                    //正在运行,查询当前的任务信息
									//正在运行,查询当前的任务信息
									List <Task>lista= workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).list();
									if(lista!=null&&lista.size()>1){
										Task task=lista.get(0);
										stra.put("task_name",task.getName());
										stra.put("task_id",task.getId());
									}else {
										Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
										stra.put("task_name",task.getName());
										stra.put("task_id",task.getId());
									}
                                }
    						}
                            ContractList.add(stra);
                        }
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
            page.setCurrentResult(ContractList.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            mv.addObject("page", null);
            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count1",ContractList.size());
            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("ContractList", ContractList);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
	
    /**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("合同编号");
			titles.add("设备合同编号");
			titles.add("项目名称");
			titles.add("报价编号");
			titles.add("报价版本");
			titles.add("客户名称");
			titles.add("客户编号");
			titles.add("最终用户");
			titles.add("业务员");
			titles.add("电梯台数");
			titles.add("报价总额");
			titles.add("合同总价格");
			titles.add("状态");
			titles.add("安装地址");
			titles.add("合同签订日期");
			titles.add("免保期限(年)");
			titles.add("交货方式");
			titles.add("联系人");
			titles.add("联系电话");
			titles.add("预计发货日期");
			titles.add("预计开工日期");
			titles.add("预计施工周期(天)");
			titles.add("预计验收日期");
			titles.add("预计质保金收款日期");
			titles.add("备注");
			titles.add("录入人");
			titles.add("录入时间");
			
			dataMap.put("titles", titles);
			
			PageData pd = this.getPageData();
			//将当前登录人添加至列表查询条件
			pd.put("input_user", getUser().getUSER_ID());
			List<String> userList = new SelectByRole().findUserList(getUser().getUSER_ID());
			pd.put("userList", userList);
			/*List<PageData> itemList = itemService.findItemList();*/
			List<PageData> contractNewList=contractNewAzService.findContractNewAzExcel(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < contractNewList.size(); i++){
				PageData contractNew = contractNewList.get(i);
				PageData vpd = new PageData();
				vpd.put("var1", contractNew.getString("AZ_NO"));
				vpd.put("var2", contractNew.getString("HT_NO"));
				vpd.put("var3", contractNew.getString("item_name"));
				vpd.put("var4", contractNew.getString("offer_no"));
				vpd.put("var5", contractNew.getString("offer_version"));
				vpd.put("var6", contractNew.getString("customer_name2"));
				vpd.put("var7", contractNew.getString("customer_no"));
				vpd.put("var8", contractNew.getString("customer_name"));
				vpd.put("var9", contractNew.getString("USER_NAME"));
				vpd.put("var10", Long.valueOf(contractNew.getString("DT_NUM")));
				vpd.put("var11", Double.valueOf(contractNew.getString("TOTAL")));
				vpd.put("var12", Double.valueOf(contractNew.getString("PRICE")));
				String ACTSTATUS = contractNew.getString("ACT_STATUS");
				if("1".equals(ACTSTATUS)) {
					vpd.put("var13", "新建");
				} else if("2".equals(ACTSTATUS)) {
					vpd.put("var13", "待审核");
				} else if("3".equals(ACTSTATUS)) {
					vpd.put("var13", "审核中");
				} else if("4".equals(ACTSTATUS)) {
					vpd.put("var13", "已通过");
				} else if("5".equals(ACTSTATUS)) {
					vpd.put("var13", "不通过");
				}  else {
					vpd.put("var13", "");
				}
				vpd.put("var14", contractNew.getString("item_install_address_excel"));
				vpd.put("var15", contractNew.getString("AZ_QDRQ"));
				vpd.put("var16", StringUtils.isBlank(contractNew.getString("AZ_MBQX"))?"1":contractNew.getString("AZ_MBQX"));
				String HTJHFS = contractNew.getString("AZ_JHFS");
				if("1".equals(HTJHFS) || StringUtils.isBlank(HTJHFS)) {
					vpd.put("var17", "乙方代办运输");
				} else if("2".equals(HTJHFS)) {
					vpd.put("var17", "甲方自提");
				} else {
					vpd.put("var17", "");
				}
				vpd.put("var18", contractNew.getString("AZ_LXR"));
				vpd.put("var19", contractNew.getString("AZ_LXDH"));
				vpd.put("var20", contractNew.getString("AZ_YJFFRQ"));
				vpd.put("var21", contractNew.getString("AZ_YJKGRQ"));
				vpd.put("var22", contractNew.getString("AZ_YJSGZQ"));
				vpd.put("var23", contractNew.getString("AZ_YJYSRQ"));
				vpd.put("var24", contractNew.getString("AZ_YJZBJRQ"));
				vpd.put("var25", contractNew.getString("AZ_BZ"));
				vpd.put("var26", contractNew.getString("USER_NAME"));
				vpd.put("var27", contractNew.getString("INPUT_TIME"));
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
    
	/* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }
    public String getRoleType(){
    	Subject currentUser = SecurityUtils.getSubject();
    	Session session = currentUser.getSession();
    	return (String)session.getAttribute(Const.SESSION_ROLE_TYPE);
    }
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
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
	
	/**
	 * 输出安装合同
	 */
	@RequestMapping(value = "toContractInstallation")
	public ModelAndView toContractInstallation(Page page) throws Exception{
		SelectByRole sbr = new SelectByRole();
		PageData pd = this.getPageData();
		//将当前登录人添加至列表查询条件
		pd.put("input_user", getUser().getUSER_ID());
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
		pd.put("userList", userList);
//        page.setPd(pd);
		String item_id = pd.getString("item_id");
		PageData kehu = new PageData();// 存放客户信息的 pd
		PageData pdelev = new PageData(); // 电梯信息pd
		List<PageData> listelev = new ArrayList<>();
		List<PageData> listfkfs = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
        ModelAndView mv = null;
        try {
        		/*
	        	try{
	        		List<PageData> CIList = contractNewAzService.printContractInstallation(page);
	        		if(CIList.size() > 0) {
	        			mv = getContractData.GetContractInstallation(CIList);
	        		}
	        }catch(Exception e){
	        		logger.error(e.getMessage(),e);
	        }
	        */
        		pd = contractService.findAzContractById(pd);// 根据安装合同编号查询安装合同信息和项目信息
			PageData pdItem = new PageData();
			pdItem = contractService.findByoffer_Id(new PageData("offer_id", pd.get("AZ_OFFER_ID")));
			String type = pdItem.getString("customer_type"); // 客户类型
			String kehu_id = pdItem.getString("customer_id"); // 客户编号
			kehu.put("kehu_id", kehu_id); // 给pd客户的编号
			if (type.equals("Ordinary")) {
				kehu = contractService.findByOrdinary(kehu);
			} else if (type.equals("Merchant")) {
				kehu = contractService.findByMerchant(kehu);
			} else if (type.equals("Core")) {
				kehu = contractService.findByCore(kehu);
			}
			// 电梯信息
			pdelev.put("item_id", item_id);// 添加项目id
			pdelev.put("HT_UUID", pd.get("HT_UUID"));
			pdelev.put("AZ_UUID", pd.get("AZ_UUID"));
			//listelev = contractService.findByElev(pdelev);
			listelev = contractService.findByElevl(pdelev);
			
			listfkfs = contractService.findByAZFkfs(pdelev);
			
			
			mv = getContractData.GetContractInstallation(pd,kehu,listelev,listfkfs);
        }catch(Exception ee) {
        		logger.error(ee.getMessage(),ee);
        }
		
        return mv;
	}
}
