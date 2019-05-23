package com.dncrm.listener.workflow;

/**
 * Created by Simon on 16/7/28.
 */

import com.dncrm.common.WorkFlow;
import com.dncrm.dao.DaoSupport;
import com.dncrm.service.system.workflow.TaskAssignService;
import com.dncrm.util.Logger;
import com.dncrm.util.PageData;
import com.dncrm.util.SpringContextHolder;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.context.ApplicationContext;

import java.util.List;

/**
 * 请假任务监听器
 *
 * @author Simon
 * @create 2016-07-28 上午10:34
 **/
public class LeaveTaskListener implements TaskListener
{

    private ApplicationContext app;
    private DaoSupport dao;

    @Override
    public void notify(DelegateTask delegateTask) {
        //设置任务处理人
        //获取当前任务定义的用户id

       /* ServletContext sc = null;
        HttpSession session = ContextHolderUtils.getSession();
        sc=session.getServletContext();
        ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);*/

        String user_id = (String)delegateTask.getVariable("user_id");
        //流程定义key
        String task_def_key = delegateTask.getTaskDefinitionKey();
        String process_definition_id = delegateTask.getProcessDefinitionId();

        WorkFlow workFlow = new WorkFlow();

        //根据task_def_key and processDefintionId查询对应的下一个任务的处理者所在的group
        PageData pd = new PageData();
        pd.put("task_def_key",task_def_key);
        pd.put("process_definition_id",process_definition_id);
        try {
            TaskAssignService taskAssignService = SpringContextHolder.getBean("taskAssignService");
            List <PageData> list = taskAssignService.getTaskAssignByKey(pd);
           /* List<HistoricTaskInstance> htilist= workFlow.getHistoryService().createHistoricTaskInstanceQuery().processInstanceId(delegateTask.getProcessInstanceId()).orderByExecutionId().desc().orderByTaskId().desc().list();
            if(htilist!=null&&htilist.size()>0){
                HistoricTaskInstance hti=htilist.get(0);
                pd.put("user_id",hti.getAssignee());
                System.out.println(hti);
                if(taskAssignService.checkTaskAuditUser(pd,list)){
                    try {
                        Map<String,Object> variables = delegateTask.getVariables();
                        variables.put("approved", true);
                        variables.put("action","系统自动完成");
                        //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
                        delegateTask.setVariablesLocal(variables);
                        Authentication.setAuthenticatedUserId( pd.getString("user_id"));
                        workFlow.getTaskService().addComment(delegateTask.getId(),null,"系统自动完成");
                        workFlow.getTaskService().complete(delegateTask.getId(),variables);
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
            }*/
            if(list!=null&&list.size()>0){
                for (PageData taskAssign:list) {
                    String group_id = taskAssign.getString("group_id");
                   delegateTask.addCandidateGroup(group_id);
                }
                if(!"CrossZone".equals(process_definition_id.split(":")[0])){
                    ThreadMail thread=new ThreadMail();
                    thread.setTaskAssignService(taskAssignService);
                    thread.setPlist(list);
                    thread.setUser_id(user_id);
                    thread.setSubject("东南CRM系统提醒");//标题

                    String processname=getActCh_ZnName(process_definition_id.split(":")[0]);
                    thread.setContent("您好：东南CRM系统中有新的待办事项："+processname+"，请您及时登录处理：<br>" +
                            "http://crm.dndt.net:8080/DNCRM<br><br><br>" +
                            "东南电梯股份有限公司 东南CRM系统 ");//内容
                    new Thread(thread).start();

                }

            }else {
                ThreadMail thread=new ThreadMail();
                thread.setTaskAssignService(taskAssignService);
                thread.setPlist(list);
                thread.setUser_id(user_id);
                thread.setSubject("东南CRM系统提醒");//标题
                thread.setVariablesMap(delegateTask.getVariables());

                String processname=getActCh_ZnName(process_definition_id.split(":")[0]);
                thread.setContent("您好：东南CRM系统中有被驳回的待办事项："+processname+"，请您及时登录处理：<br>" +
                        "http://crm.dndt.net:8080/DNCRM<br><br><br>" +
                        "东南电梯股份有限公司 东南CRM系统 ");//内容
                new Thread(thread).start();
            }
        } catch (Exception e) {
            Logger logger = Logger.getLogger(this.getClass());
            logger.error(e.toString(), e);
        }

        System.out.println("task listener");
        System.out.println("delegateTask -->"+delegateTask);
    }

    /**
     * 获取流程中文名字
     * @param key
     * @return
     */
    private String getActCh_ZnName(String key){
        if(key!=null){
            if ("agent".equals(key)){
                return "代理商审核";
            }else if ("contractor".equals(key)){
                return "分包商审核";
            }else if ("SubInvoice".equals(key)){
                return "分子公司开票审核";
            }else if ("ContractModify".equals(key)){
                return "变更协议审核";
            }else if ("ContractNew".equals(key)){
                return "合同审核流程";
            }else if ("ContractNewAZ".equals(key)){
                return "安装合同审核流程";
            }else if ("offer_changguihuoti".equals(key)){
                return "报价常规梯梯折扣审批";
            }else if ("JscInvoice".equals(key)){
                return "股份公司开票审核";
            }else if ("nonStandrad".equals(key)){
                return "非标审核";
            }else if ("CrossZone".equals(key)){
                return "项目跨区审核";
            }else if ("forecast".equals(key)){
                return "项目预测审核";
            }else {
                return  "";
            }
        }else {
            return "";
        }
    }

}


