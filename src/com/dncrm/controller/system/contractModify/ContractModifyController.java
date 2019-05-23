package com.dncrm.controller.system.contractModify;

import com.dncrm.common.WorkFlow;
import com.dncrm.common.getContractData;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.contract.ContractService;
import com.dncrm.service.system.contractModify.ContractModifyService;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.workflow.WorkflowTraceService;
import com.dncrm.util.Const;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping(value = "/contractModify")
public class ContractModifyController extends BaseController{

	@Resource(name = "contractModifyService")
	private ContractModifyService contractModifyService;
	
	@Resource(name = "contractService")
	private ContractService contractService;

	@Resource(name = "contractNewService")
	private ContractNewService contractNewService;
	
	@Resource(name = "workflowTraceService")
	private WorkflowTraceService workflowTraceService;
	
	/**
	 *列表 
	 */
	@RequestMapping(value="list")
	public ModelAndView list(){
		PageData pd = new PageData();
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			List<PageData> pdList = contractModifyService.list(pd);
			PageData headMsg = contractModifyService.findHeadMsg(pd);
			mv.addObject("pd", pd);
			mv.addObject("contractModifyList", pdList);
			mv.addObject("headMsg", headMsg);
			mv.setViewName("system/contractModify/contractNewChangeInContract_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到变更协议新增页面 
	 */
	@RequestMapping(value="goAdd")
	public ModelAndView goAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			//加载项目id-合同id
			pd = this.getPageData();
			//加载页面默认带出头信息
			PageData headInfo = contractModifyService.findHeadInfo(pd);
			//加载电梯列表
			List<PageData> dtInfoList = contractModifyService.findDtinfoForAdd(pd);
			String previousModifyId = "";
			List<PageData> dtInfoPassList = contractModifyService.findContractModifyPassList(new PageData("contract_id", pd.getString("ht_uuid")));
			if(dtInfoPassList != null && dtInfoPassList.size() > 0) {
				previousModifyId = dtInfoPassList.get(0).getString("id");
			} else {
				previousModifyId = pd.getString("ht_uuid");
			}
			//加载付款列表
			List<PageData> fkfsList = contractModifyService.findFkfsForAdd(pd);
			//设置流水号
			PageData resultPd = contractModifyService.findSerialNumber();
			headInfo.put("serial_number", resultPd.get("serial_number").toString());
			headInfo.put("modify_number", resultPd.getString("modify_number"));
			mv.addObject("headInfo", headInfo);
			mv.addObject("dtInfoList", dtInfoList);
			mv.addObject("previousModifyId", previousModifyId);
			mv.addObject("fkfsList", fkfsList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "saveContractModify");
			mv.setViewName("system/contractModify/contractNewChangeTheAgreement_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *保存
	 */
	/*@RequestMapping(value="saveContractModify")
	public ModelAndView saveContractModify(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try{
			
			//保存合同变更
			String contractModifyId = this.get32UUID();
			pd.put("id", contractModifyId);
			pd.put("serial_number", "001");
			pd.put("modify_number", "cm001");
			pd.put("input_user", this.getUser().getUSERNAME());
			pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			contractModifyService.saveContractModify(pd);
			
			//保存电梯信息
			String dtInfoJson = pd.getString("dtInfoJson");
			JSONArray jsonArray = JSONArray.fromObject(dtInfoJson);
			for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				PageData cmElevPd = new PageData();
				cmElevPd.put("id", this.get32UUID());
				cmElevPd.put("so_dtinfo", jsonObj.get("dtInfoId").toString());
				cmElevPd.put("contract_modify_id", contractModifyId);
				cmElevPd.put("modify_sbdj", jsonObj.get("dtSbdj").toString());
				cmElevPd.put("modify_azdj", jsonObj.get("dtAzdj").toString());
				cmElevPd.put("modify_total", jsonObj.get("dtTotal").toString());
				contractModifyService.saveCmElev(cmElevPd);
			}
			
			//保存付款方式
			String fkfsJson = pd.getString("fkfsJson");
			JSONArray jsonArray2 = JSONArray.fromObject(fkfsJson);
			for(int i =0;i<jsonArray2.size();i++){
				JSONObject jsonObj = jsonArray2.getJSONObject(i);
				PageData cmFkfsPd = new PageData();
				cmFkfsPd.put("id", this.get32UUID());
				cmFkfsPd.put("so_fkfs", jsonObj.get("so_fkfs").toString());
				cmFkfsPd.put("contract_modify_id", contractModifyId);
				cmFkfsPd.put("period", jsonObj.get("period").toString());
				cmFkfsPd.put("stage", jsonObj.get("stage").toString());
				cmFkfsPd.put("date_devi", jsonObj.get("date_devi").toString());
				cmFkfsPd.put("pay_percent", jsonObj.get("pay_percent").toString());
				cmFkfsPd.put("price", jsonObj.get("price").toString());
				cmFkfsPd.put("remark", jsonObj.get("remark").toString());
				cmFkfsPd.put("type", jsonObj.get("type").toString());
				contractModifyService.saveCmFkfs(cmFkfsPd);
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}*/
	
	/**
	 *编辑 
	 */
	@RequestMapping(value="goEdit")
	public ModelAndView goEdit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String forwardMsg = pd.getString("forwardMsg");
			pd = contractModifyService.findContractModify(pd);
			pd.put("ht_uuid", pd.get("contract_id"));
			PageData headInfoPd = contractModifyService.findHeadInfo(pd);
			List<PageData> dtInfoList = new ArrayList<PageData>();
			if(StringUtils.isNoneBlank(pd.getString("previous_modify_id"))) {
				dtInfoList = contractModifyService.findCmElevForModifyId(pd);
			} else {
				dtInfoList = contractModifyService.findCmElevForEdit(pd);
			}
			List<PageData> fkfsList = contractModifyService.findCmFkfsForEdit(pd);
			mv.addObject("msg", "editContractModify");
			mv.addObject("headInfo", headInfoPd);
			mv.addObject("pd", pd);
			mv.addObject("dtInfoList", dtInfoList);
			mv.addObject("fkfsList", fkfsList);
			mv.addObject("forwardMsg", forwardMsg);
			mv.setViewName("system/contractModify/contractNewChangeTheAgreement_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存编辑 
	 */
	@Transactional
	@RequestMapping(value="editContractModify")
	public ModelAndView editContractModify(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			contractModifyService.updateContractModify(pd);
			
			
			//保存电梯信息
			String dtInfoJson = pd.getString("dtInfoJson");
			JSONArray jsonArray = JSONArray.fromObject(dtInfoJson);
			for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				PageData cmElevPd = new PageData();
				cmElevPd.put("id", jsonObj.get("id").toString());
				cmElevPd.put("so_dtinfo", jsonObj.get("dtInfoId").toString());
				cmElevPd.put("modify_sbdj", jsonObj.get("dtSbdj").toString());
				cmElevPd.put("modify_azdj", jsonObj.get("dtAzdj").toString());
				cmElevPd.put("modify_total", jsonObj.get("dtTotal").toString());
				contractModifyService.updateCmElev(cmElevPd);
			}

			contractModifyService.deleteCmFkfs(pd);
			//保存付款方式
			String fkfsJson = pd.getString("fkfsJson");
            JSONArray jsonArray2 = JSONArray.fromObject(fkfsJson);
            for(int i =0;i<jsonArray2.size();i++){
                JSONObject jsonObj = jsonArray2.getJSONObject(i);
                PageData cmFkfsPd = new PageData();
                cmFkfsPd.put("id", this.get32UUID());
                cmFkfsPd.put("so_fkfs", jsonObj.get("so_fkfs").toString());
                cmFkfsPd.put("contract_modify_id", pd.get("id").toString());
                cmFkfsPd.put("period", jsonObj.get("period").toString());
                cmFkfsPd.put("stage", jsonObj.get("stage").toString());
                cmFkfsPd.put("so_pdrq", jsonObj.get("so_pdrq").toString());
                cmFkfsPd.put("so_fkts", jsonObj.get("so_fkts").toString());
                cmFkfsPd.put("pay_percent", jsonObj.get("pay_percent").toString());
                cmFkfsPd.put("price", jsonObj.get("price").toString());
                cmFkfsPd.put("remark", jsonObj.get("remark").toString());
                cmFkfsPd.put("type", jsonObj.get("type").toString());
                contractModifyService.saveCmFkfs(cmFkfsPd);
            }
			/*JSONArray jsonArray2 = JSONArray.fromObject(fkfsJson);
			for(int i =0;i<jsonArray2.size();i++){
				JSONObject jsonObj = jsonArray2.getJSONObject(i);
				PageData cmFkfsPd = new PageData();
				cmFkfsPd.put("id",  jsonObj.get("id").toString());
				cmFkfsPd.put("so_fkfs", jsonObj.get("so_fkfs").toString());
				cmFkfsPd.put("period", jsonObj.get("period").toString());
				cmFkfsPd.put("stage", jsonObj.get("stage").toString());
				cmFkfsPd.put("date_devi", jsonObj.get("date_devi").toString());
				cmFkfsPd.put("pay_percent", jsonObj.get("pay_percent").toString());
				cmFkfsPd.put("price", jsonObj.get("price").toString());
				cmFkfsPd.put("remark", jsonObj.get("remark").toString());
				cmFkfsPd.put("type", jsonObj.get("type").toString());
				contractModifyService.updateCmFkfs(cmFkfsPd);
			}*/
            
            //判断如果是提交进来的 启动流程
			if("TJ".equals(pd.getString("type"))) {
				//PageData modifyPd = contractModifyService.findContractModify(pd);
				apply(pd.getString("id"), "");
			}
            
	      mv.addObject("id", "ChangeTheAgreement");
	      mv.addObject("form", "DeviceForm");
	      mv.addObject("msg", "success");
	      mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *删除 
	 */
	@RequestMapping(value="delete")
	@ResponseBody
	public Object delete(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			contractModifyService.deleteContractModify(pd);
			
			contractModifyService.deleteCmElev(pd);
			contractModifyService.deleteCmFkfs(pd);
			map.put("msg", "success");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	/* ===============================流程相关================================== */
	  
	  /**
	   * 启动流程
	   * @return
	   */
	    @RequestMapping("/apply")
	    @ResponseBody
	    public Object apply(String id, String act_key){
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
	            //String act_key = pd.getString("act_key");         //流程实例id
	            
	            PageData modifyPd = contractModifyService.findContractModify(new PageData("id", id));
	            act_key = modifyPd.getString("act_key");
	            String actStatus = modifyPd.getString("act_status");
	            // 如果流程的实例id存在，启动流程
	            if(act_key!=null && !"".equals(act_key)
	            		&& ("1".equals(actStatus) || "5".equals(actStatus))){
	              WorkFlow workFlow = new WorkFlow();
	              // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
	              workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
	              Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(act_key).singleResult();
	              Map<String,Object> variables = new HashMap<String,Object>();
	              //设置任务角色
	              workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
	              //签收任务
	              workFlow.getTaskService().claim(task.getId(), USER_ID);
	              //设置流程变量
	              variables.put("action", "提交申请");
	              if("5".equals(actStatus)) {
	            	  variables.put("action", "重新提交"); 
	              }
	              
	              workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
	              modifyPd.put("act_status", 2);   //流程状态  2代表流程启动,等待审核
	              //更新流程状态
	              contractModifyService.editActStatus(modifyPd);
	              workFlow.getTaskService().complete(task.getId());
	              //获取下一个任务的信息
	                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(act_key).singleResult();
	                map.put("task_name",tasks.getName());
	                map.put("status", "1");
	            }
	            if((act_key !=null && !"".equals(act_key))){
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
	              mv.setViewName("system/contractModify/contractNew_Audit");
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
	              List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractModify").orderByTaskCreateTime().desc().active().list();
	              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractModify").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
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
	                      e_offer=contractModifyService.findContractModify(e_offer);
	                     
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
	        
	        //String forwardMsg = pd.getString("forwardMsg");
	        PageData mpd = contractModifyService.findContractModify(pd);
	        mpd.put("ht_uuid", mpd.get("contract_id"));
			PageData headInfoPd = contractModifyService.findHeadInfo(mpd);
			List<PageData> dtInfoList = new ArrayList<PageData>();
			if(StringUtils.isNoneBlank(pd.getString("previous_modify_id"))) {
				dtInfoList = contractModifyService.findCmElevForModifyId(pd);
			} else {
				dtInfoList = contractModifyService.findCmElevForEdit(pd);
			}
			List<PageData> fkfsList = contractModifyService.findCmFkfsForEdit(mpd);
			mv.addObject("headInfo", headInfoPd);
			mv.addObject("dtInfoList", dtInfoList);
			mv.addObject("fkfsList", fkfsList);
			mv.addObject("forwardMsg", "view");
			if(pd != null) {
				pd.putAll(mpd);
			}
	        
	        mv.setViewName("system/contractModify/contractNew_Handle");
	        mv.addObject("pd", pd);
	        mv.addObject("historys", workflowTraceService.getViewHistory(mpd.getString("act_key")));
	        return mv;
	    }
	    
	    /**
	     * 办理任务
	     * @return
	     */
	    @RequestMapping("/handleAgent")
		@Transactional
	    public ModelAndView handleAgent() throws Exception{
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
	                if (task.getTaskDefinitionKey().equals("usertask5"))
	                {
						status = 2;    //已完成
						pd.put("act_status",4);             //流程状态   4.已通过
						variables.put("approved", true);
						isApproved=true;
						isEnd=true;
						contractModifyService.editActStatus(pd);  //修改流程状态
						contractModifyService.updateContractInfo(pd);
	                }
	                else
	                {
	                  status = 2;    //已完成
	                    pd.put("act_status",3);             //流程状态  3.审核中
	                    variables.put("approved", true);
	                    isApproved=true;
	                    contractModifyService.editActStatus(pd);  //修改流程状态
	                }
	            }else if(action.equals("reject")) {
	                status = 4;   
	                pd.put("act_status",5);             //流程状态  5代表 被驳回
	                variables.put("approved", false);
	                contractModifyService.editActStatus(pd);  //修改流程状态
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
	             throw  e;
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
	            
	            PageData modifyPd = contractModifyService.findContractModify(pd);
	            if(modifyPd != null && "5".equals(modifyPd.getString("act_status"))) {
	            	String actKey = modifyPd.getString("act_key");
		            String task_id = pd.getString("task_id");  //流程id
		            String user_id = pds.getString("USER_ID");
		            
		            List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(actKey).active().list();
          			if(task!=null&& task.size()>0){
          				for(Task task1:task){
          					task_id = task1.getId();
          				}
          			}
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
		            contractModifyService.editActStatus(pd);  //修改流程状态
	            }
	            
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
	            mv.setViewName("system/contractModify/contractNew_Audit");
	            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
	            WorkFlow workFlow = new WorkFlow();
	            // 已处理的任务集合
	            List<PageData> ContractList = new ArrayList<>();
	            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
	            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
	            
	            //获取已处理的任务
	            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("ContractModify").orderByTaskCreateTime().desc().list();
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
	                    
	                    stra=contractModifyService.findContractModify(stra);
	                    //检查申请者是否是本人,如果是,跳过
	                //    if (stra.getString("input_user").equals(USER_ID))
	                  //  continue;
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


	/**
	   *保存
	   */
	  @RequestMapping(value="saveContractModify")
	  public ModelAndView saveContractModify(){
	    ModelAndView mv = new ModelAndView();
	    PageData pd = this.getPageData();
	    try{
	      //合同审核流程 key
	      String processDefinitionKey="ContractModify";
	      pd.put("KEY", processDefinitionKey);
	      //查询流程是否存在
	      List<PageData> SoContractList = contractNewService.SelAct_Key(pd);
	      if(SoContractList!=null)
	      {
	        //保存合同变更
	        String contractModifyId = this.get32UUID();
	        pd.put("id", contractModifyId);
	        //设置流水号
	        PageData resultPd = contractModifyService.findSerialNumber();
	        pd.put("serial_number", resultPd.get("serial_number").toString());
	        pd.put("modify_number", resultPd.getString("modify_number"));
	        pd.put("act_key", processDefinitionKey);//流程key
	        pd.put("act_status", "1");//流程状态  1 新建
	        pd.put("input_user", this.getUser().getUSER_ID());
	        pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
	        contractModifyService.saveContractModify(pd);
	        
	        //保存电梯信息
	        String dtInfoJson = pd.getString("dtInfoJson");
	        JSONArray jsonArray = JSONArray.fromObject(dtInfoJson);
	        for(int i =0;i<jsonArray.size();i++){
	          JSONObject jsonObj = jsonArray.getJSONObject(i);
	          PageData cmElevPd = new PageData();
	          cmElevPd.put("id", this.get32UUID());
	          cmElevPd.put("so_dtinfo", jsonObj.get("dtInfoId").toString());
	          cmElevPd.put("contract_modify_id", contractModifyId);
	          cmElevPd.put("modify_sbdj", jsonObj.get("dtSbdj").toString());
	          cmElevPd.put("modify_azdj", jsonObj.get("dtAzdj").toString());
	          cmElevPd.put("modify_total", jsonObj.get("dtTotal").toString());
	          cmElevPd.put("previous_sbdj", jsonObj.get("dtPreSbdj").toString());
	          cmElevPd.put("previous_azdj", jsonObj.get("dtPreAzdj").toString());
	          cmElevPd.put("previous_total", jsonObj.get("dtPreTotal").toString());
	          contractModifyService.saveCmElev(cmElevPd);
	        }
	        
	        //保存付款方式
	        String fkfsJson = pd.getString("fkfsJson");
	        JSONArray jsonArray2 = JSONArray.fromObject(fkfsJson);
	        for(int i =0;i<jsonArray2.size();i++){
	          JSONObject jsonObj = jsonArray2.getJSONObject(i);
	          PageData cmFkfsPd = new PageData();
	          cmFkfsPd.put("id", this.get32UUID());
	          cmFkfsPd.put("so_fkfs", jsonObj.get("so_fkfs").toString());
	          cmFkfsPd.put("contract_modify_id", contractModifyId);
	          cmFkfsPd.put("period", jsonObj.get("period").toString());
	          cmFkfsPd.put("stage", jsonObj.get("stage").toString());
	          cmFkfsPd.put("so_pdrq", jsonObj.get("so_pdrq").toString());
	          cmFkfsPd.put("so_fkts", jsonObj.get("so_fkts").toString());
	          cmFkfsPd.put("pay_percent", jsonObj.get("pay_percent").toString());
	          cmFkfsPd.put("price", jsonObj.get("price").toString());
	          cmFkfsPd.put("remark", jsonObj.get("remark").toString());
	          cmFkfsPd.put("type", jsonObj.get("type").toString());
	          contractModifyService.saveCmFkfs(cmFkfsPd);
	        }
	      }
	      else
	      {
	        mv.addObject("msg", "流程不存在");
	      }
	      
	      //-----生成流程实例
	      WorkFlow workFlow=new WorkFlow();
	      IdentityService identityService=workFlow.getIdentityService();
	      identityService.setAuthenticatedUserId(this.getUser().getUSER_ID());
	      Object uuId=pd.get("id");
	      String businessKey="tb_contract_modify.id."+uuId;
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
	        contractModifyService.editActKey(aPd);
	        
	        //判断如果是提交进来的 启动流程
			if("TJ".equals(pd.getString("type"))) {
				//PageData modifyPd = contractModifyService.findContractModify(pd);
				apply(pd.getString("id"), "");
			}
	        
	        mv.addObject("msg", "success");
	      }
	      else
	      {
	        //没有流程实例删除录入的数据
	        mv.addObject("msg", "failed");
	        mv.addObject("err", "没有生成流程实例");
	      }
	      mv.addObject("id", "ChangeTheAgreement");
	      mv.addObject("form", "DeviceForm");
	      mv.setViewName("save_result");
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

    /**
	 * 输出变更协议
	 */
	@RequestMapping(value = "toContractModify")
	public ModelAndView toContractModify(Page page) throws Exception{
		SelectByRole sbr = new SelectByRole();
		PageData pd = this.getPageData();
		//将当前登录人添加至列表查询条件
		pd.put("input_user", getUser().getUSER_ID());
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
		pd.put("userList", userList);
//        page.setPd(pd);
		PageData kehu = new PageData();// 存放客户信息的 pd
        ModelAndView mv = null;
        try {
        		/*
	        	try{
	        		List<PageData> CMList = contractModifyService.printContractModify(page);
	        		if(CMList.size() > 0) {
	        			mv = getContractData.GetContractModify(CMList);
	        		}
	        }catch(Exception e){
	        		logger.error(e.getMessage(),e);
	        }
	        */
    		pd = contractModifyService.findContractModify(pd);// 获取合同信息
    		pd.put("ht_uuid", pd.get("contract_id"));
			PageData headInfoPd = contractModifyService.findHeadInfo(pd);
			pd.put("ht_so_qdrq", headInfoPd.getString("ht_qdrq"));
			pd.put("ht_no", headInfoPd.getString("ht_no"));
			pd.put("customer_name", headInfoPd.getString("customer_name"));
			pd.put("item_name", headInfoPd.getString("item_name"));
			List<PageData> dtInfoList = new ArrayList<PageData>();
			if(StringUtils.isNoneBlank(pd.getString("previous_modify_id"))) {
				dtInfoList = contractModifyService.findCmElevForModifyId(pd);
				List<PageData> prevContractModify = contractModifyService.findPrevContractModifyList(new PageData("id", pd.getString("previous_modify_id")));
				if(prevContractModify != null && prevContractModify.size() > 0) {
					PageData prevData = prevContractModify.get(0);
					pd.put("prev_ht_no", prevData.getString("modify_number"));
					pd.put("prev_squence", prevData.getString("squence"));
					pd.put("prev_content", prevData.getString("content"));
				}
			} else {
				dtInfoList = contractModifyService.findCmElevForEdit(pd);
			}
			
    		//PageData soCon = contractNewService.findSoConByUUid(new PageData("HT_UUID", pd.getString("contract_id")));
    		//PageData pdItem = new PageData();
			//pdItem = contractService.findByoffer_Id(new PageData("offer_id", soCon.getString("HT_OFFER_ID")));

			//pd.putAll(pdItem);
			//pd.putAll(soCon);
			
			mv = getContractData.GetContractModify(pd, dtInfoList);
			
        }catch(Exception ee) {
        		logger.error(ee.getMessage(),ee);
        }
		
        return mv;
	}
}
