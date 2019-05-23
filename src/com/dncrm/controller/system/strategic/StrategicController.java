package com.dncrm.controller.system.strategic;

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
import com.dncrm.service.system.strategic.StrategicService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;


@RequestMapping("/strategic")
@Controller
public class StrategicController extends BaseController
{
	@Resource(name="strategicService")
    private StrategicService strategicService;
	
	/*
     * 显示全部协议信息
     * return
     */
    @RequestMapping("/strategic")
    public ModelAndView strategiclist(Page page)
    {
    	ModelAndView mv=this.getModelAndView();
    	PageData pd=this.getPageData();
    	 //shiro管理的session
 		Subject currentUser = SecurityUtils.getSubject();
 		Session session = currentUser.getSession();
 		PageData pds = new PageData();
 		pds = (PageData) session.getAttribute("userpds");
 		String USER_ID = pds.getString("USER_ID");
    	try 
    	{
    		List<String> userList = getRoleSelect();
    		String roleType = getRoleType();
    		pd.put("userList", userList);
    		pd.put("roleType", roleType);
    		page.setPd(pd);
    		List<PageData> strategiclist=strategicService.strategiclistPage(page);
    		 if(!strategiclist.isEmpty()){
              	for(PageData con : strategiclist){
              		String stra_strategy_key = con.getString("stra_strategy_key");
              		if(stra_strategy_key!=null && !"".equals(stra_strategy_key)){
              			WorkFlow workFlow = new WorkFlow();
              			List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(stra_strategy_key).active().list();
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
    		mv.setViewName("system/strategic/strategic");
    		mv.addObject("strategiclist",strategiclist);
    		mv.addObject("page", page);
    		mv.addObject("pd",pd);
    		mv.addObject("stra_name", pd.get("stra_name"));
            mv.addObject("description", pd.get("description"));
    		mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(),e);
		}
    	return mv;
    }
    /**
     * 请求跳转新增页面
     */
    @RequestMapping("/goAddS")
    public ModelAndView goAddS()
    {
    	ModelAndView mv=this.getModelAndView();
    	PageData pd=new PageData();
    	try {
    		List<PageData> customerlist=strategicService.customerlist(pd);
    		mv.addObject("customerlist",customerlist);
    	} catch (Exception e) {
			logger.error(e.toString(),e);
		}
    	mv.setViewName("system/strategic/strategic_edit");
    	mv.addObject("msg","saveS");
    	mv.addObject("pd",pd);
    	return mv;
    }
    /**
     * 请求跳转编辑页面
     */
    @RequestMapping("/goEditS")
    public ModelAndView goEditS()
    {
    	ModelAndView mv=this.getModelAndView();
    	PageData pd=new PageData();
    	pd=this.getPageData();
    	try 
    	{
    		//根据传入的协议编号查询协议信息
    		pd=strategicService.findById(pd);    
    		List<PageData> customerlist=strategicService.customerlist(pd);
    		mv.addObject("customerlist",customerlist);
    		mv.setViewName("system/strategic/strategic_edit");
        	mv.addObject("msg","editS");
        	mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(),e);
		}
    	return mv;
    }
    /**
     * 根据协议编号删除
     * @return
     */
    @RequestMapping("/delStra")
    @ResponseBody
    public Object delStra()
    {
    	PageData pd=this.getPageData();
    	Map<String,Object> map=new HashMap<String,Object>();
    	try 
    	{
			Page page=this.getPage();
			page.setPd(pd);
			strategicService.delfindById(pd);
			map.put("msg","success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
    	return JSONObject.fromObject(map);
    }
    /**
     * 根据协议id删除数据
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteAllS")
    @ResponseBody
    public Object delShops() throws Exception {
 		Map<String, Object> map = new HashMap<String, Object>();
 		PageData pd = this.getPageData();
 		Page page = this.getPage();
 		try {
 			page.setPd(pd);
 			String stra_nos = (String) pd.get("stra_nos");
 			for (String stra_no : stra_nos.split(",")) {
 				pd.put("stra_no", stra_no);
 				strategicService.delfindById(pd);
 			}
 			map.put("msg", "success");
 		} catch (Exception e) {
 			map.put("msg", "failed");
 		}
 		return JSONObject.fromObject(map);
 	}
    /**
     * 保存新增协议信息
     * @return
     */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		    Date dt=new Date();
		    SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
		    String time= matter1.format(dt);
		    int number=(int)((Math.random()*9+1)*100000);
		    String stra_no=("SO"+time+number);
			String df=DateUtil.getTime().toString(); //获取系统时间
			//--------流程相关
			Subject currentUser=SecurityUtils.getSubject();
			Session session=currentUser.getSession();
			PageData pds=new PageData();
			pds=(PageData) session.getAttribute("userpds");
			String USER_ID=pds.getString("USER_ID");
			String processDefinitionKey="";
		try {
			pd = this.getPageData();
			//查询流程是否存在
			List<PageData> straList = strategicService.stra_strategy_key(getPage());
			if(straList!=null)
			{
				pd.put("modified_time", df);  
				pd.put("stra_uuid", UUID.randomUUID().toString());
				pd.put("stra_approval", 0);                         //流程状态 0代表待启动
				pd.put("stra_strategy_key","StrategyContract");     //流程的key
				pd.put("requester_id", USER_ID);                    //录入信息请求启动的用户ID
				pd.put("stra_no", stra_no);
				strategicService.saveS(pd);                         //保存单元基本信息 
				mv.addObject("msg", "success");
			}
			else
			{
				mv.addObject("msg", "流程不存在");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败！");
            e.printStackTrace();
		}
		//-----流程相关
		try 
		{ 
			processDefinitionKey="StrategyContract";
			WorkFlow workFlow=new WorkFlow();
			IdentityService identityService=workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId=pd.get("stra_uuid");
			String businessKey="tb_strategic.stra_uuid."+uuId;
			Map<String,Object> variables = new HashMap<String,Object>();
			variables.put("user_id", USER_ID);
			ProcessInstance proessInstance=null; //流程1
			if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
			{
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
			}
			if(proessInstance!=null)
			{
				pd.put("stra_strategy_key", proessInstance.getId());
			}
			else
			{
				strategicService.delfindById(pd);//删除协议信息
				mv.addObject("msg", "failed");
    			mv.addObject("err", "保存失败！");
			}
			strategicService.editS(pd);//修改单元基本信息 
		} catch (Exception e) {
			mv.addObject("msg", "failed");
            mv.addObject("err", "流程不存在！");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 保存编辑
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editS")
    public ModelAndView editS() throws Exception
    {
    	ModelAndView mv=new ModelAndView();
    	PageData pd=new PageData();
    	String df=DateUtil.getTime().toString();
    	try 
    	{
		    pd=this.getPageData();
		    pd.put("modified_time",df);
		    strategicService.editS(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
    	mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
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
            String USER_ID = pds.getString("USER_ID");                  //当前登录用户的ID
            String stra_strategy_key = pd.getString("stra_strategy_key");   //流程Key
            //  如存在key启动常规合同评审流程
            if(stra_strategy_key!=null && !"".equals(stra_strategy_key)){
            	WorkFlow workFlow = new WorkFlow();
            	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(stra_strategy_key).singleResult();
            	Map<String,Object> variables = new HashMap<String,Object>();
            	//设置任务角色
            	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
            	//设置流程变量
            	variables.put("action", "提交申请");
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
            	pd.put("stra_approval", 1);   //流程状态  1代表流程启动,等待审核
            	strategicService.upStraApproval(pd);//更新流程状态
            	workFlow.getTaskService().complete(task.getId());
            	//获取下一个任务的信息
                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(stra_strategy_key).singleResult();
                map.put("task_name",tasks.getName());
                map.put("status", "1");
            }
            if((stra_strategy_key !=null && !"".equals(stra_strategy_key))){
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
     * 请求跳转查看页面
     * @param con_id
     * @return
     */
    @RequestMapping(value = "/toView")
    public ModelAndView toView(String agent_id){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try {
    		pd=strategicService.findById(pd);
    		List<PageData> customerlist=strategicService.customerlist(pd);
    		mv.addObject("customerlist",customerlist);
			mv.setViewName("system/strategic/strategic_view");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return mv;
    }
    /**
     * 显示待我处理的协议
     * @param page
     * @return
     */
    @RequestMapping(value= "/strategicAudit")
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
              mv.setViewName("system/strategic/strategic_list");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              List<PageData> stras = new ArrayList<>();
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
              List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("StrategyContract").orderByTaskCreateTime().desc().active().list();
              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("StrategyContract").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
                 for (Task task : toHandleList) {
                  PageData stra = new PageData();
                  String processInstanceId = task.getProcessInstanceId();
                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                  String businessKey = processInstance.getBusinessKey();
                  if (!StringUtils.isEmpty(businessKey)){
                      //leave.leaveId.
                      String[] info = businessKey.split("\\.");
                      stra.put(info[1],info[2]);
                      stra = strategicService.findByuuId(stra);
                      stra.put("task_name",task.getName());
                      stra.put("task_id",task.getId());
                      if(task.getAssignee()!=null){
                    	  stra.put("type","1");//待处理
                      }else{
                    	  stra.put("type","0");//待签收
                      }
                  }
                  stras.add(stra);
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
              page.setCurrentResult(stras.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(1);
              page.setPageStrForActiviti(page.getPageStrForActiviti());
              //待处理任务的count
              pd.put("count",toHandleListCount.size());
              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("stras", stras);
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
        mv.setViewName("system/strategic/strategic_handle");
        mv.addObject("pd", pd);
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
                if (task.getTaskDefinitionKey().equals("CreditControlDepartment"))   //信控部节点
                {
                	 status = 2;    //已完成
                     int type=1;
                     pd.put("stra_approval",2);             //流程状态  2代表流程结束
                     variables.put("approved", true);
                     variables.put("type", type);
                     isApproved=true;
                     isEnd=true;
                     strategicService.upStraApproval(pd);  //修改流程状态
                }
                else
                {
                	status = 2;    //已完成
                    int type=1;
                    pd.put("stra_approval",1);             //流程状态  1代表审核中
                    variables.put("approved", true);
                    variables.put("type", type);
                    isApproved=true;
                    strategicService.upStraApproval(pd);  //修改流程状态
                }
            }else if(action.equals("reject")) {
                status = 4;//被驳回
                pd.put("stra_approval",4);             //流程状态  4代表 被驳回
                variables.put("approved", false);
                strategicService.upStraApproval(pd);  //修改流程状态
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
     * 显示我已经处理的合同审核
     *
     * @return
     */
    @RequestMapping("/listDoneStra")
    public ModelAndView listDoneContractor(Page page) {
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
            mv.setViewName("system/strategic/strategic_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务
            List<PageData> strates = new ArrayList<>();
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("StrategyContract").orderByTaskCreateTime().desc().list();
            //移除重复的
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
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
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        stra.put(info[1],info[2]);
                        stra = strategicService.findByuuId(stra);
                        //检查申请者是否是本人,如果是,跳过
                        if (stra.getString("requester_id").equals(USER_ID))
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
                        strates.add(stra);
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
            page.setCurrentResult(strates.size());
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
            mv.addObject("strates", strates);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
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
        	pd.put("stra_approval",1);
        	 strategicService.upStraApproval(pd);  //修改流程状态
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
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
   			titles.add("协议UUID");
   			titles.add("协议编号");
   			titles.add("协议名称");
   			titles.add("协议条款");
   			titles.add("甲方");
   			titles.add("法定代表人");
   			titles.add("委托人");
   			titles.add("电话");
   			titles.add("乙方");
   			titles.add("法定代表人");
   			titles.add("委托人");
   			titles.add("电话");
   			titles.add("协议结束时间");
   			titles.add("签约日期");
   			titles.add("修改时间");
   			titles.add("流程KEY");
   			titles.add("流程状态");
   			titles.add("录入人");
   			titles.add("战略客户名称");
   			dataMap.put("titles", titles);
   			
   			List<PageData> itemList = strategicService.findStrategicList();
   			List<PageData> varList = new ArrayList<PageData>();
   			for(int i = 0; i < itemList.size(); i++){
   				PageData vpd = new PageData();
   				vpd.put("var1", itemList.get(i).getString("stra_uuid"));
   				vpd.put("var2", itemList.get(i).getString("stra_no"));
   				vpd.put("var3", itemList.get(i).getString("stra_name"));
   				vpd.put("var4", itemList.get(i).getString("stra_clause"));
   				vpd.put("var5", itemList.get(i).getString("stra_owner"));
   				vpd.put("var6", itemList.get(i).getString("stra_ow_representative"));
   				vpd.put("var7", itemList.get(i).getString("stra_ow_entrusted"));
   				vpd.put("var8", itemList.get(i).getString("stra_ow_phone"));
   				vpd.put("var9", itemList.get(i).getString("stra_second"));
   				vpd.put("var10", itemList.get(i).getString("stra_se_representative"));
   				vpd.put("var11", itemList.get(i).getString("stra_se_entrusted"));
   				vpd.put("var12", itemList.get(i).getString("stra_se_phone"));
   			    //定义格式，不显示毫秒
   				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   				String str = df.format(itemList.get(i).get("end_Time"));
   				vpd.put("var13", str);
   				String str1 = df.format(itemList.get(i).get("stra_SignedTime"));
   				vpd.put("var14", str1);
   				String str2 = df.format(itemList.get(i).get("modified_time"));
   				vpd.put("var15", str2);
   				vpd.put("var16", itemList.get(i).getString("stra_strategy_key"));
 
   				String con_approval=itemList.get(i).getString("stra_approval");
				if(con_approval.equals("0")){vpd.put("var17", "待启动");}
				else if(con_approval.equals("1")){vpd.put("var17", "审核中");}
				else if(con_approval.equals("2")){vpd.put("var17", "已完成");}
				else if(con_approval.equals("3")){vpd.put("var17", "已取消");}
				else if(con_approval.equals("4")){vpd.put("var17", "被驳回");}
   				vpd.put("var18", itemList.get(i).getString("requester_id"));
   				vpd.put("var19", itemList.get(i).getString("customer_name"));
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
   		try{
   			if(file!=null && !file.isEmpty()){
   	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
   	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
   				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
   			    //保存总错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
   				PageData pd = new PageData();
   				for(int i = 0;i<listPd.size();i++)
   				{
   				    //保存错误信息集合
	    			List<PageData> errList = new ArrayList<PageData>();
   					//生成战略客户协议编号
   					Date dt=new Date();
   				    SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
   				    String time= matter1.format(dt);
   				    int number=(int)((Math.random()*9+1)*100000);
   				    String stra_no=("SO"+time+number);
   				    String df=DateUtil.getTime().toString(); //获取系统时间
   				    //--------流程相关
   					Subject currentUser=SecurityUtils.getSubject();
   					Session session=currentUser.getSession();
   					PageData pds=new PageData();
   					pds=(PageData) session.getAttribute("userpds");
   					String USER_ID=pds.getString("USER_ID");
   					String processDefinitionKey="";
   					//字段检验-----------------------开始
   					//协议名称---检验
   				    String stra_name=listPd.get(i).getString("var0");
   				    if(stra_name==null || stra_name.equals(""))
   				    {
   				    	PageData errPd = new PageData();
	  	        		errPd.put("errMsg", "协议名称不能为空!");
	  	        		errPd.put("errCol", "1");
	  	        		errPd.put("errRow", i+1);
	  	        		errList.add(errPd);
   				    }
   				    //协议结束时间---检验
   				    String end_Time=listPd.get(i).getString("var10");
   				    if(end_Time==null || end_Time.equals(""))
   				    {
   				    	PageData errPd = new PageData();
	  	        		errPd.put("errMsg", "协议结束时间不能为空!");
	  	        		errPd.put("errCol", "11");
	  	        		errPd.put("errRow", i+1);
	  	        		errList.add(errPd);
   				    }
   					//战略客户---检验
   					PageData customerPd=new PageData();
   				    PageData customer=new PageData();
   				    String customer_name= listPd.get(i).getString("var12");
   				   if(customer_name==null || customer_name.equals(""))
   				   {
			        	PageData errPd = new PageData();
	  	        		errPd.put("errMsg", "战略客户客户不能为空!");
	  	        		errPd.put("errCol", "13");
	  	        		errPd.put("errRow", i+1);
	  	        		errList.add(errPd);
   				   }
   				   else
   				   {
    				   customerPd.put("customer_name", customer_name);
    				   customer=strategicService.findCustomer_coreByName(customerPd);
    				   if(customer==null)
    				   {
    			        	PageData errPd = new PageData();
    	  	        		errPd.put("errMsg", "战略客户不存在!");
    	  	        		errPd.put("errCol", "13");
    	  	        		errPd.put("errRow", i+1);
    	  	        		errList.add(errPd);
    				   } 
    				   
   				   }
   				   
   				  //查询流程是否存在
 				  List<PageData> straList = strategicService.stra_strategy_key(getPage());
				  if(straList==null)
				  {
					  PageData errPd = new PageData();
	  	        	  errPd.put("errMsg", "流程不存在，不能进行导入!");
	  	        	  errPd.put("errCol", "");
	  	        	  errPd.put("errRow", i+1);
	  	        	  errList.add(errPd);
				  }
 					
   				   if(errList.size()==0)
   				   {
   					    pd.put("stra_uuid", UUID.randomUUID().toString());
		        	    pd.put("stra_no", stra_no);
		        	    pd.put("stra_name", listPd.get(i).getString("var0"));
		        	    pd.put("stra_clause",  listPd.get(i).getString("var1"));
		        	    pd.put("stra_owner",  listPd.get(i).getString("var2"));
		        	    pd.put("stra_ow_representative",  listPd.get(i).getString("var3"));
		        	    pd.put("stra_ow_entrusted", listPd.get(i).getString("var4"));
		           	    pd.put("stra_ow_phone", listPd.get(i).getString("var5"));
		        	    pd.put("stra_second",  listPd.get(i).getString("var6"));
		        	    pd.put("stra_se_representative",  listPd.get(i).getString("var7"));
		        	    pd.put("stra_se_entrusted",  listPd.get(i).getString("var8"));
		        	    pd.put("stra_se_phone", listPd.get(i).getString("var9"));
		        	    pd.put("end_Time", listPd.get(i).getString("var10"));
		        	    pd.put("stra_SignedTime", listPd.get(i).getString("var11"));//签约时间
		        	    pd.put("modified_time",df);//录入时间
		        	    pd.put("stra_strategy_key","StrategyContract");//流程key
		        	    pd.put("stra_approval", 0);//流程状态
		        	    pd.put("requester_id",USER_ID);//录入人
		        	    pd.put("customer_no", customer.get("customer_no").toString());
		        	    
		        	    allErr = false;
		        	    //保存至数据库
		        	    strategicService.saveS(pd);
		        	    
		        	    //-----流程相关
   					   try 
   					   { 
	   						processDefinitionKey="StrategyContract";
	   						WorkFlow workFlow=new WorkFlow();
	   						IdentityService identityService=workFlow.getIdentityService();
	   						identityService.setAuthenticatedUserId(USER_ID);
	   						Object uuId=pd.get("stra_uuid");
	   						String businessKey="tb_strategic.stra_uuid."+uuId;
	   						Map<String,Object> variables = new HashMap<String,Object>();
	   						variables.put("user_id", USER_ID);
	   						ProcessInstance proessInstance=null; //流程1
	   						if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
	   						{
	   							proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
	   						}
	   						if(proessInstance!=null)
	   						{
	   							pd.put("stra_strategy_key", proessInstance.getId()); 
	   						}
	   						else
	   						{
	   							strategicService.delfindById(pd);//删除协议信息
	   							map.put("errorMsg", "上传失败");
	   						}
	   						 allErr = false;
	   						 strategicService.editS(pd);//修改单元基本信息 
   					  } catch (Exception e) {
   						    map.put("errorMsg", "上传失败");
   					  }
   					
   				   }
   				   else
   				   {
	   					for(PageData dataPd : errList){
		        			allErrList.add(dataPd);
		        		}
   				   }
   				   
   				   
   			}
   			//↑↑↑----------循环结束------------↑↑↑
			//判断总错误数
			if(allErrList.size()==0){
    			map.put("msg", "success");
			}else{
				if(allErr){
					//导入全部失败
        			map.put("msg", "allErr");
				}else{
					//部分导入成功，部分导入失败
					map.put("msg", "error");
				}
				//执行完操作之后抛出报错集合
    			String errStr = "";
    			errStr += "总错误:"+allErrList.size();
    			for(PageData forPd : allErrList){
    				errStr += "\n错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
    			}
    			map.put("errorUpload", errStr);
			}
    	}else{
    		map.put("msg", "exception");
    		map.put("errorMsg", "上传失败,没有数据！");
    	}
	}catch(Exception e){
		logger.error(e.getMessage(), e);
		map.put("msg", "exception");
		map.put("errorUpload", "系统错误，请稍后重试！");
	}
    return JSONObject.fromObject(map);
}
    /* ===============================权限================================== */
   	@SuppressWarnings("unchecked")
   	public Map<String, String> getHC() {
   		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
   		Session session = currentUser.getSession();
   		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
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
/* ===============================用户================================== */
}
