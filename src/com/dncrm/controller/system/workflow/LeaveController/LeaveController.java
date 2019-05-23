package com.dncrm.controller.system.workflow.LeaveController;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.workflow.WorkFlowService;
import com.dncrm.service.system.workflow.leave.LeaveService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.StringUtil;
import net.sf.json.JSONObject;
import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

@RequestMapping("/workflow/leave")
@Controller
public class LeaveController extends BaseController {
    @Resource(name = "leaveService")
    private LeaveService leaveService;
    @Resource(name = "workFlowService")
    private WorkFlowService workFlowService;

    /**
     * 显示我申请的请假
     *
     * @return
     */
    @RequestMapping("/listLeaves")
    public ModelAndView listLeaves(Page page) {
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
            mv.setViewName("system/workflow/leave/leave_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> leaves = leaveService.listLeaves(page);
            for (PageData leave:leaves) {
                String process_instance_id= leave.getString("process_instance_id");
                if (process_instance_id!=null){
                    WorkFlow workflow = new WorkFlow();
                    Task task = workflow.getTaskService().createTaskQuery().processInstanceId(process_instance_id).active().singleResult();
                    if(task!=null){
                        leave.put("task_id",task.getId());
                        leave.put("task_name",task.getName());
                    }
                }
            }

            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count",toHandleListCount.size());
            pd.put("isActive1","1");
            mv.addObject("pd",pd);
            mv.addObject("leaves", leaves);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 显示待我处理的请假
     *
     * @return
     */
    @RequestMapping("/listPendingLeaves")
    public ModelAndView listPendingLeaves(Page page) {
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
            mv.setViewName("system/workflow/leave/leave_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限

            List<PageData> pleaves = new ArrayList<>();
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
            List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("leave").orderByTaskCreateTime().desc().active().list();
            List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("leave").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
            for (Task task : toHandleList) {

                PageData leave = new PageData();
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                    //leave.leaveId.
                    String[] info = businessKey.split("\\.");
                    leave.put(info[1],info[2]);
                    leave = leaveService.findById(leave);
                    leave.put("task_name",task.getName());
                    leave.put("task_id",task.getId());
                    if(task.getAssignee()!=null){
                        leave.put("type","1");//待处理
                    }else{
                        leave.put("type","0");//待签收
                    }
                }
                pleaves.add(leave);
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
            page.setCurrentResult(pleaves.size());
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
            mv.addObject("pleaves", pleaves);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 显示我已经处理的请假
     *
     * @return
     */
    @RequestMapping("/listDoneLeaves")
    public ModelAndView listDoneLeaves(Page page) {
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
            mv.setViewName("system/workflow/leave/leave_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务
            List<PageData> dleaves = new ArrayList<>();
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("leave").orderByTaskCreateTime().desc().list();
            //移除重复的
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            for (HistoricTaskInstance instance:historicTaskInstances
                 ) {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
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
                PageData leave = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        leave.put(info[1],info[2]);
                        leave = leaveService.findById(leave);
                        //检查申请者是否是本人,如果是,跳过
                        if (leave.getString("requester_id").equals(USER_ID))
                            continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (runing==null||runing.size()<=0){
                            leave.put("isRuning",0);

                        }else{
                            leave.put("isRuning",1);
                            //正在运行,查询当前的任务信息
                            Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                            leave.put("task_name",task.getName());
                            leave.put("task_id",task.getId());
                        }
                        dleaves.add(leave);
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
            List<PageData> leaves = new ArrayList<>();
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
     * 重新申请
     *
     * @return
     */
    @RequestMapping("/restartLeave")
    @ResponseBody
    public Object restartLeave() {
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
            List<PageData> leaves = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);

            Map <String,Object> variables = new HashMap<String,Object>();
            variables.put("action","重新提交");
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id);

            //更新业务数据的状态
            pd.put("status",1);
            leaveService.updateLeaveStatus(pd);
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 跳到办理任务页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandleLeave")
    public ModelAndView goHandleLeave() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("system/workflow/leave/leave_handle");
        mv.addObject("pd", pd);
        return mv;
    }
    /**
     * 处理任务
     *
     * @return
     */
    @RequestMapping("/handle")
    public ModelAndView handle() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 办理任务
            List<PageData> leaves = new ArrayList<>();
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
                if (task.getTaskDefinitionKey().equals("HRApproval")){
                    status = 2;//已完成
                    pd.put("status",2);
                    leaveService.updateLeaveStatus(pd);
                }
            }else if(action.equals("reject")) {
                status = 4;//被驳回
                pd.put("status",4);
                leaveService.updateLeaveStatus(pd);
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
        } catch (Exception e) {
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
     * 启动流程
     *
     */
    @RequestMapping(value = "/apply")
    @ResponseBody
    public Object apply() {
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String processDefinitionKey = "leave";

            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");

            WorkFlow workFlow = new WorkFlow();
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(pd.getString("process_instance_id")).singleResult();
            Map<String,Object> variables = new HashMap<String,Object>();
            //设置任务角色
            workFlow.getTaskService().setAssignee(task.getId(),USER_ID);
            //签收任务
            workFlow.getTaskService().claim(task.getId(),USER_ID);
            //设置流程变量
            variables.put("action","提交申请");
            workFlow.getTaskService().setVariablesLocal(task.getId(),variables);
            //办理任务
            workFlow.getTaskService().complete(task.getId());

            pd.put("status",1);
            //更新状态
            leaveService.updateLeaveStatus(pd);
            //获取下一个任务的信息
            Task task2 = workFlow.getTaskService().createTaskQuery().processInstanceId(pd.getString("process_instance_id")).singleResult();
            map.put("task_name",task2.getName());
            map.put("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        System.out.println("json-->"+JSONObject.fromObject(map));
        return JSONObject.fromObject(map);
    }

    /**
     * 跳到添加页面
     *
     * @return
     */
    @RequestMapping("/goAddLeave")
    public ModelAndView goAddLeave() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/workflow/leave/leave_edit");
        mv.addObject("msg", "addLeave");
        mv.addObject("pd", pd);
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();

        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");

        mv.addObject("userpds", pds);
        return mv;
    }

    /**
     * 跳到编辑页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goEditLeave")
    public ModelAndView goEditLeave() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = leaveService.findById(pd);
        mv.setViewName("system/workflow/leave/leave_edit");
        mv.addObject("pd", pd);
        mv.addObject("msg", "editLeave");
        return mv;
    }

    /**
     * 保存
     *
     * @return
     */
    @RequestMapping("/addLeave")
    public ModelAndView addLeave() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            pd.put("id", UUID.randomUUID().toString());
            leaveService.insertLeave(pd);
            //启动流程
            String processDefinitionKey = "leave";

            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");

            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            WorkFlow workFlow = new WorkFlow();
            IdentityService identityService = workFlow.getIdentityService();
            identityService.setAuthenticatedUserId(USER_ID);
            //设置businesskey,格式为,表.字段名称.字段值
            Object leaveId = pd.get("id");
            String businessKey = "leave.leaveId."+leaveId;

            //设置变量
            Map<String ,Object> variables = new HashMap<String, Object>() ;
            variables.put("user_id",USER_ID);
            ProcessInstance processInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey,variables);
            if (processInstance != null) {
                pd.put("process_instance_id",processInstance.getId());
                leaveService.updateLeaveProcessInstanceId(pd);
                mv.addObject("msg", "success");
            } else {
                leaveService.deleteLeave(pd);
                mv.addObject("msg", "failed");
                mv.addObject("err", "保存失败！");
            }

        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
        }
        mv.addObject("id", "AddLeaves");
        mv.addObject("form", "leaveForm");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 保存编辑
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/editLeave")
    public ModelAndView editLeave() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        try {
            leaveService.updateLeave(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "修改失败！");
        }
        mv.addObject("id", "EditLeaves");
        mv.addObject("form", "leaveForm");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 删除一条数据
     *
     */
    @RequestMapping("/delLeave")
    @ResponseBody
    public Object delLeave() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
            String leaveId = (String)pd.get("id");
            if (!StringUtils.isEmpty(leaveId)) {
                pd.put("leaveId",pd.getString("id"));
                pd = leaveService.findById(pd);
                //删除启动的流程
                WorkFlow workflow = new WorkFlow();
                String processInstanceId = pd.getString("process_instance_id");
                workflow.getRuntimeService().deleteProcessInstance(processInstanceId,"删除业务数据,删除流程");
                leaveService.deleteLeave(pd);
                map.put("msg", "success");

            }else{
                map.put("msg", "failed");
                map.put("err", "无法获取ID");
            }
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "删除失败");
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 批量删除
     */
    @RequestMapping(value = "/delAllLeaves")
    @ResponseBody
    public Object delAllLeaves() {
        logBefore(logger, "批量删除请假流程");
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();
            String DATA_IDS = pd.getString("DATA_IDS");
            if (null != DATA_IDS && !"".equals(DATA_IDS)) {
                String ArrayDATA_IDS[] = DATA_IDS.split(",");
                leaveService.deleteAll(ArrayDATA_IDS);
                pd.put("msg", "ok");
            } else {
                pd.put("msg", "no");
            }
            pdList.add(pd);
            map.put("list", pdList);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
}
