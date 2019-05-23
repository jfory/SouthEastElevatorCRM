package com.dncrm.controller.system.contractNew;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.newInvoice.NewInvoiceService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
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

@RequestMapping("/newInvoice")
@Controller
public class NewInvoiceController extends BaseController {
	
	@Resource(name = "newInvoiceService")
	private NewInvoiceService newInvoiceService;
	
    @Resource(name = "sysUserService")
    private com.dncrm.service.system.sysUser.sysUserService sysUserService;

	
	/**
	 * 开票信息列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/invoiceList")
	public ModelAndView invoiceList(Page page) {
		ModelAndView mv =new ModelAndView();
		try 
		{
			List<PageData> list = newInvoiceService.list();
			mv.addObject("list", list);
			mv.setViewName("system/newInvoice/newinvoice_list");
		}
		catch(Exception e)
		{
		  logger.error(e.getMessage(), e);	
		}
		return mv;
	}
	
	@RequestMapping("/invoice_add")
	public ModelAndView contract_sel(Page page) {
		ModelAndView mv =new ModelAndView();
		try {
			
			//查询合同信息列表

			List<PageData> contractList = newInvoiceService.findContractList();
			mv.addObject("contractList", contractList);
			mv.setViewName("system/newInvoice/newcontract_sellist");		
			
		}catch(Exception e){
		logger.error(e.getMessage(), e);	
		}
		
		return mv;
	}
	
	
	
	
	@RequestMapping("/invoiceInfo")
	public ModelAndView invoiceInfo() {
		ModelAndView mv =new ModelAndView();
		PageData pd = new PageData();
		try {
		pd = this.getPageData();
		//查询开票新增页面头信息
		PageData headInfoPd = newInvoiceService.findHeadInfo(pd);
		PageData kpPd = newInvoiceService.findKP(pd);
		//根据合同id查询应收款
		List<PageData> yskList = newInvoiceService.findYskListByContract(pd);
		//根据合同id查询电梯信息
		List<PageData> dtList = newInvoiceService.findDtInfoListByContract(pd);
		PageData itpd=newInvoiceService.findCustomerInfoByItemId(pd);
		mv.addObject("yskList", yskList);
		mv.addObject("dtList", dtList);
		mv.addObject("headInfo", headInfoPd);
		mv.addObject("kpPd", kpPd);
		mv.addObject("pd", itpd);
		mv.addObject("msg", "saveInvoice");
		mv.setViewName("system/newInvoice/newinvoice_draft");	
		}catch(Exception e){
			logger.error(e.getMessage(), e);		
		}
		return mv;
	}	
	
	/**

	 *保存 

	 */
	@RequestMapping("/saveInvoice")
	public ModelAndView saveInvoice(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			//保存时判断发起人是分公司还是股份公司
			//--目前组织结构中没有股份公司选项,默认分子公司
			String flag = "1";
			String key_ = "";
			if(flag.equals("1")){
				//分子公司
				key_ = "SubInvoice";
			}else if(flag.equals("2")){
				//股份公司
				key_ = "JscInvoice";
			}
			//---------------start
			//合同审核流程 key
		      String processDefinitionKey=key_;
		      pd.put("KEY", processDefinitionKey);
		      //查询流程是否存在
		      List<PageData> SoContractList = newInvoiceService.SelAct_Key(pd);
		      if(SoContractList!=null)
		      {
			//------------------end
				pd = this.getPageData();
				String invUUID = this.get32UUID();
				pd.put("input_user", this.getUser().getUSER_ID());
				pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
				pd.put("id", invUUID);
				//-------------start
		        pd.put("act_key", processDefinitionKey);//流程key
		        pd.put("act_status", "1");//流程状态  1 新建
				//-------------end
				newInvoiceService.saveInvoice(pd);
				String invInfoJson = pd.getString("invInfoJson");
				JSONArray jsonArray = JSONArray.fromObject(invInfoJson);
				for(int i =0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					PageData invInfoPd = new PageData();
					invInfoPd.put("id", this.get32UUID());
					invInfoPd.put("inv_id", invUUID);
					invInfoPd.put("ysk_id", jsonObj.getString("yskUUID_"));
					invInfoPd.put("elev_models", jsonObj.getString("xh_"));
					invInfoPd.put("elev_num", jsonObj.getString("ts_"));
					invInfoPd.put("inv_type", jsonObj.getString("lx_"));
					invInfoPd.put("tax_rate", jsonObj.getString("sl_"));
					invInfoPd.put("inv_price", jsonObj.getString("kpje_"));
					invInfoPd.put("unit_price", jsonObj.getString("dj_"));
					invInfoPd.put("proportion", jsonObj.getString("bl_"));
					invInfoPd.put("price_type", jsonObj.getString("kx_"));
					newInvoiceService.saveInvoiceInfo(invInfoPd);
				}
				mv.addObject("id", "EditCollect");
				mv.addObject("form", "invoiceListForm");
				mv.addObject("msg", "success");
				mv.setViewName("save_result");
				//----start
		      }else
		      {
		          mv.addObject("msg", "流程不存在");
		        }
		    //-----生成流程实例
		      WorkFlow workFlow=new WorkFlow();
		      IdentityService identityService=workFlow.getIdentityService();
		      identityService.setAuthenticatedUserId(this.getUser().getUSER_ID());
		      Object uuId=pd.get("id");
		      String businessKey="tb_invoice.id."+uuId;
		      Map<String,Object> variables = new HashMap<String,Object>();
		      variables.put("user_id", this.getUser().getUSER_ID());
		      ProcessInstance proessInstance=null; //存放生成的流程实例id
		      if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
		      {
		        proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
		      }
		      if(proessInstance!=null)
		      {
		        PageData aPd=new PageData();
		        aPd.put("act_key", proessInstance.getId());
		        aPd.put("id", pd.get("id").toString());
		        //修改报价信息  （流程的key该为流程实例id）
		        newInvoiceService.editActKey(aPd);
		        
		        mv.addObject("msg", "success");
		      }
		      else
		      {
		        //没有流程实例删除录入的数据
		        mv.addObject("msg", "failed");
		        mv.addObject("err", "没有生成流程实例");
		      }
		      //----end
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	@RequestMapping("/invoice_examine")
	public ModelAndView invoice_examine() {
		ModelAndView mv =new ModelAndView();
		PageData pd;
		try {
			pd = this.getPageData();
			mv.setViewName("system/newInvoice/newinvoice_examine");	
		}catch(Exception e){
			logger.error(e.getMessage(), e);		
		}
		
		return mv;
	}
	
	/**

	 *删除开票信息 

	 */
	@RequestMapping("/deleteInvoice")
	@ResponseBody
	public Object deleteInvoice(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			newInvoiceService.deleteInvoice(pd);
			newInvoiceService.deleteInvoiceInfo(pd);
			map.put("msg", "success");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *编辑开票 
	 */
	@RequestMapping(value="goEdit")
	public ModelAndView goEdit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			PageData invPd = newInvoiceService.findInvoice(pd);
			//查询开票新增页面头信息
			PageData headInfoPd = newInvoiceService.findHeadInfo(invPd);
			PageData kpPd = newInvoiceService.findKP(invPd);
			//根据合同id查询应收款
			List<PageData> yskList = newInvoiceService.findYskListByContract(invPd);
			//根据合同id查询电梯信息
			List<PageData> dtList = newInvoiceService.findDtInfoListByContract(invPd);
			//根据开票id查询发票明细
			List<PageData> invoiceInfoList = newInvoiceService.findInvoiceInfo(invPd);
			mv.addObject("yskList", yskList);
			mv.addObject("dtList", dtList);
			mv.addObject("invoiceInfoList", invoiceInfoList);
			mv.addObject("headInfo", headInfoPd);
			mv.addObject("kpPd", kpPd);
			mv.addObject("operateType",pd.getString("type"));
			mv.addObject("pd", invPd);
			mv.addObject("msg", "editInvoice");
			mv.setViewName("system/newInvoice/newinvoice_draft");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	@RequestMapping(value="goView")
	public ModelAndView goView(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			PageData invPd = newInvoiceService.findInvoice(pd);
			//查询开票新增页面头信息
			PageData headInfoPd = newInvoiceService.findHeadInfo(invPd);
			PageData kpPd = newInvoiceService.findKP(invPd);
			//根据合同id查询应收款
			List<PageData> yskList = newInvoiceService.findYskListByContract(invPd);
			//根据合同id查询电梯信息
			List<PageData> dtList = newInvoiceService.findDtInfoListByContract(invPd);
			//根据开票id查询发票明细
			List<PageData> invoiceInfoList = newInvoiceService.findInvoiceInfo(invPd);
			mv.addObject("yskList", yskList);
			mv.addObject("dtList", dtList);
			mv.addObject("invoiceInfoList", invoiceInfoList);
			mv.addObject("headInfo", headInfoPd);
			mv.addObject("kpPd", kpPd);
			mv.addObject("pd", invPd);
			mv.addObject("msg", "view");
			mv.setViewName("system/newInvoice/newinvoice_draft");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	/**
	 *编辑开票信息 
	 */
	@RequestMapping(value="editInvoice")
	public ModelAndView editInvoice(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		List<String> deleteIds = new ArrayList<String>();
		try{
			pd = this.getPageData();
			//编辑开票
			newInvoiceService.editInvoice(pd);
			String invInfoJson = pd.getString("invInfoJson");
			if(invInfoJson.equals("]")){
				deleteIds.add("");
				//编辑前删除多余信息
				PageData deletePd = new PageData();
				deletePd.put("list", deleteIds);
				deletePd.put("inv_id", pd.getString("id"));
				newInvoiceService.deleteInvoiceInfoAfterEdit(deletePd);
			}else{
				JSONArray jsonArray = JSONArray.fromObject(invInfoJson);
				for(int i =0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					if(jsonObj.containsKey("id")&&!"".equals(jsonObj.getString("id"))){
						deleteIds.add(jsonObj.getString("id"));
					}
				}
				deleteIds.add("");
				//编辑前删除多余信息
				PageData deletePd = new PageData();
				deletePd.put("list", deleteIds);
				deletePd.put("inv_id", pd.getString("id"));
				newInvoiceService.deleteInvoiceInfoAfterEdit(deletePd);
				for(int i =0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					PageData invInfoPd = new PageData();
					if(jsonObj.containsKey("id")&&!"".equals(jsonObj.getString("id"))){
						//修改
						invInfoPd.put("id", jsonObj.getString("id"));
						invInfoPd.put("inv_id", pd.getString("id"));
						invInfoPd.put("ysk_id", jsonObj.getString("yskUUID_"));
						invInfoPd.put("elev_models", jsonObj.getString("xh_"));
						invInfoPd.put("elev_num", jsonObj.getString("ts_"));
						invInfoPd.put("inv_type", jsonObj.getString("lx_"));
						invInfoPd.put("tax_rate", jsonObj.getString("sl_"));
						invInfoPd.put("inv_price", jsonObj.getString("kpje_"));
						invInfoPd.put("unit_price", jsonObj.getString("dj_"));
						invInfoPd.put("proportion", jsonObj.getString("bl_"));
						invInfoPd.put("price_type", jsonObj.getString("kx_"));
						newInvoiceService.editInvoiceInfo(invInfoPd);
					}else{
						//新增
						invInfoPd.put("id", this.get32UUID());
						invInfoPd.put("inv_id", pd.getString("id"));
						invInfoPd.put("ysk_id", jsonObj.getString("yskUUID_"));
						invInfoPd.put("elev_models", jsonObj.getString("xh_"));
						invInfoPd.put("elev_num", jsonObj.getString("ts_"));
						invInfoPd.put("inv_type", jsonObj.getString("lx_"));
						invInfoPd.put("tax_rate", jsonObj.getString("sl_"));
						invInfoPd.put("inv_price", jsonObj.getString("kpje_"));
						invInfoPd.put("unit_price", jsonObj.getString("dj_"));
						invInfoPd.put("proportion", jsonObj.getString("bl_"));
						invInfoPd.put("price_type", jsonObj.getString("kx_"));
						newInvoiceService.saveInvoiceInfo(invInfoPd);
					}
				}
			}
			mv.addObject("id", "EditCollect");
			mv.addObject("form", "invoiceListForm");
			mv.addObject("msg", "success");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/* ===============================流程相关================================== */
	  
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
	        //shiro管理的session
	            Subject currentUser = SecurityUtils.getSubject();
	            Session session = currentUser.getSession();
	            PageData pds = new PageData();
	            pds = (PageData) session.getAttribute("userpds");
	            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
	            String ACT_KEY = pd.getString("act_key");         //流程实例id
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
	              pd.put("act_status", 2);   //流程状态  2代表流程启动,等待审核
	              //更新流程状态
	              newInvoiceService.editActStatus(pd);
	              workFlow.getTaskService().complete(task.getId());
	              //获取下一个任务的信息
	                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
	                map.put("task_name",tasks.getName());
	                map.put("status", "1");
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
	              mv.setViewName("system/newInvoice/contractNew_Audit");
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
	              /* List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().active().list();
	                  List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);*/
	              	  List<Task> sub_toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().active().list();
	              	  List<Task> jsc_toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("JscInvoice").orderByTaskCreateTime().desc().active().list();
	              	  List<Task> toHandleListCount = new ArrayList<Task>();
	              	  toHandleListCount.addAll(sub_toHandleListCount);
	              	  toHandleListCount.addAll(jsc_toHandleListCount);
	              	  
	              	  List<Task> sub_toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
	              	  List<Task> jsc_toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("JscInvoice").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
	              	  List<Task> toHandleList = new ArrayList<Task>();
	              	  toHandleList.addAll(sub_toHandleList);
	              	  toHandleList.addAll(jsc_toHandleList);
	                  for (Task task : toHandleList) {
	                  PageData e_offer = new PageData();
	                  String processInstanceId = task.getProcessInstanceId();
	                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
	                  String businessKey = processInstance.getBusinessKey();
	                  if (!StringUtils.isEmpty(businessKey))
	                  {
	                      //leave.leaveId.
	                      String[] info = businessKey.split("\\.");
	                      e_offer.put(info[1],info[2]);
	                      //根据uuiid查询信息
	                      e_offer=newInvoiceService.findInvoice(e_offer);
	                      if(e_offer!=null && e_offer.size()>0){
		                      e_offer.put("task_name",task.getName());
		                      e_offer.put("task_id",task.getId());
		                      if(task.getAssignee()!=null){
		                        e_offer.put("type","1");//待处理
		                      }else{
		                        e_offer.put("type","0");//待签收
		                      }
		                      ContractList.add(e_offer);
	                      }
	                     
	                  }
	                 
	              }
	                 
	              //设置分页数据
	              int totalResult = toHandleListCount.size();
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
	        WorkFlow workFlow = new WorkFlow();
	        //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");

            String task_id=pd.getString("task_id");
            
            pd.put("task_id",task_id);
            pd.put("audit_name",pds.getString("NAME"));
            
            Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
	        
            /*usertask4  会计 *///
            System.out.println(task.getTaskDefinitionKey());
            if(task.getTaskDefinitionKey().equals("usertask4")) {
            	mv.addObject("kuaiji","kuaiji");
            }else {
            	mv.addObject("kuaiji","feikuaiji");
            }
            
            if(task.getTaskDefinitionKey().equals("EndTask")) {
            	mv.addObject("EndTask","EndTask");
            }else {
            	mv.addObject("EndTask","feiEndTask");
            }
            
            mv.addObject("historys",getViewHistory(task.getProcessInstanceId()));
            
	        PageData invPd = newInvoiceService.findInvoice(pd);
			//查询开票新增页面头信息
			PageData headInfoPd = newInvoiceService.findHeadInfo(invPd);
			PageData kpPd = newInvoiceService.findKP(invPd);
			//根据合同id查询应收款
			List<PageData> yskList = newInvoiceService.findYskListByContract(invPd);
			//根据合同id查询电梯信息
			List<PageData> dtList = newInvoiceService.findDtInfoListByContract(invPd);
			//根据开票id查询发票明细
			List<PageData> invoiceInfoList = newInvoiceService.findInvoiceInfo(invPd);
			
			
			
			mv.addObject("yskList", yskList);
			mv.addObject("dtList", dtList);
			mv.addObject("invoiceInfoList", invoiceInfoList);
			mv.addObject("headInfo", headInfoPd);
			mv.addObject("kpPd", kpPd);
			mv.addObject("pd", pd);
			mv.addObject("operateType","CK");
			mv.addObject("pd1", invPd);
			
			mv.addObject("pd", pd);
			mv.addObject("msg", "view");
	        mv.setViewName("system/newInvoice/contractNew_Handle");
	       
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
	                
	                if (task.getTaskDefinitionKey().equals("usertask4")) {
	                	newInvoiceService.editFph(pd);  //修改发票号和快递单号
	                }
	                
	                if (task.getTaskDefinitionKey().equals("EndTask"))
	                {
	                   status = 2;    //已完成
	                     pd.put("act_status",4);             //流程状态   4.已通过
	                     variables.put("approved", true);
	                     isApproved=true;
	                     isEnd=true;
	                     newInvoiceService.editActStatus(pd);  //修改流程状态
	                }
	                else
	                {
	                  status = 2;    //已完成
	                    pd.put("act_status",3);             //流程状态  3.审核中
	                    variables.put("approved", true);
	                    isApproved=true;
	                    newInvoiceService.editActStatus(pd);  //修改流程状态
	                }
	            }else if(action.equals("reject")) {
	                status = 4;   
	                pd.put("act_status",5);             //流程状态  5代表 被驳回
	                variables.put("approved", false);
	                newInvoiceService.editActStatus(pd);  //修改流程状态
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
	          pd.put("act_status", 2); //流程状态 2.待审核
	          newInvoiceService.editActStatus(pd);  //修改流程状态
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
	            mv.setViewName("system/newInvoice/contractNew_Audit");
	            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
	            WorkFlow workFlow = new WorkFlow();
	            // 已处理的任务集合
	            List<PageData> ContractList = new ArrayList<>();
	            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
	            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
	            
	            //获取已处理的任务
	            /*List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().list();*/
	            List<HistoricTaskInstance> sub_historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().list();
	            List<HistoricTaskInstance> jsc_historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("JscInvoice").orderByTaskCreateTime().desc().list();
	            List<HistoricTaskInstance> historicTaskInstances = new ArrayList<HistoricTaskInstance>();
	            historicTaskInstances.addAll(sub_historicTaskInstances);
	            historicTaskInstances.addAll(jsc_historicTaskInstances);
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
	            int listCount =(list.size()<=maxResults?list.size():maxResults);
	            //从分页参数开始
	            for (int i = firstResult; i <listCount ; i++) {
	                HistoricTaskInstance historicTaskInstance = list.get(i);
	                PageData stra = new PageData();
	                String processInstanceId = historicTaskInstance.getProcessInstanceId();
	                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
	                String businessKey = historicProcessInstance.getBusinessKey();
	                if (!StringUtils.isEmpty(businessKey))
	                {
	                    //leave.leaveId.
	                    String[] info = businessKey.split("\\.");
	                    stra.put(info[1],info[2]);
	                    
	                    stra=newInvoiceService.findInvoice(stra);
	                    //检查申请者是否是本人,如果是,跳过
	                    if (stra==null||stra.getString("input_user").equals(USER_ID))
	                    continue;
	                    //查询当前流程是否还存在
	                    List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
	                    if (stra!=null) {
	                      if (runing==null||runing.size()<=0){
	                        stra.put("isRuning",0);
	                        }else{
	                          stra.put("isRuning",1);
	                            //正在运行,查询当前的任务信息
	                            Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
	                            stra.put("task_name",task.getName());
	                            stra.put("task_id",task.getId());
	                        }
	          }
	                    ContractList.add(stra);
	                   
	                        
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
	            page.setFormNo(2);
	            page.setPageStrForActiviti(page.getPageStrForActiviti());
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
    /* ===============================用户================================== */
    
    
    
    
    private List<Map> getViewHistory(String processInstanceId) throws Exception{
        WorkFlow workFlow = new WorkFlow();
        //获取历史instance记录
        List<HistoricProcessInstance> historicProcessInstances = workFlow.getHistoryService().
                                                                    createHistoricProcessInstanceQuery().
                                                                    processInstanceId(processInstanceId).list();

        List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().
                                                            processInstanceId(processInstanceId).list();

        List<Map> list = new ArrayList<>();
        for (HistoricTaskInstance historicTaskInstance:historicTaskInstances
                ) {
            Map<String ,Object> map = new HashMap<String,Object>();
            map.put("task_name",historicTaskInstance.getName());

            String claim_time = Tools.date2Str(historicTaskInstance.getClaimTime(),"yyyy-MM-dd HH:mm:ss");
            String complete_time = Tools.date2Str(historicTaskInstance.getEndTime(),"yyyy-MM-dd HH:mm:ss");
            map.put("claim_time",claim_time);
            map.put("complete_time",complete_time);
            if (historicTaskInstance.getAssignee()!=null){
                //获取用户信息
                String user_id = historicTaskInstance.getAssignee();
                PageData tmp = new PageData();
                tmp.put("USER_ID",user_id);
                tmp = sysUserService.findByUiId(tmp);
                if (tmp!=null&&tmp.getString("NAME")!=null){
                    String user_name = tmp.getString("NAME");
                    map.put("user_name",user_name);
                }
            }
            //获取comment
            List<Comment> comments =  workFlow.getTaskService().getTaskComments(historicTaskInstance.getId());
            String comment = "";
            for (Comment msg :
                    comments) {
                comment = msg.getFullMessage();
            }
            map.put("comment",comment);
            //获取变量
            List<HistoricVariableInstance> historicVariableInstances = workFlow.getHistoryService().createHistoricVariableInstanceQuery().taskId(historicTaskInstance.getId()).list();
            String action ="";
            for (HistoricVariableInstance historicVariableInstance :historicVariableInstances
                    ) {
                if (historicVariableInstance.getVariableName().equals("action")){
                    action = (String) historicVariableInstance.getValue();
                }
            }
            map.put("action",action);
            list.add(map);

        }
        return list;
    }


}