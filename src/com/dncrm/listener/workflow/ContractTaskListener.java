package com.dncrm.listener.workflow;

import com.dncrm.dao.DaoSupport;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.workflow.TaskAssignService;
import com.dncrm.util.PageData;
import com.dncrm.util.SpringContextHolder;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.context.ApplicationContext;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备合同专用监听器
 * @author LGD
 *
 */
public class ContractTaskListener implements TaskListener,ExecutionListener {
	
	private ApplicationContext app;
    private DaoSupport dao;
	
	@Override
	public void notify(DelegateTask delegateTask) {
		String definitiokey=delegateTask.getTaskDefinitionKey();

        ContractNewService contractNewService=SpringContextHolder.getBean("contractNewService");
		TaskAssignService taskAssignService = SpringContextHolder.getBean("taskAssignService");
        try {
            if(definitiokey!=null&&definitiokey.equals("techtask")){
				List<String> usr= (List<String>) delegateTask.getVariable("assigneeList");
					List<PageData> pdlist=new ArrayList<PageData>();
					for (String group_id:usr){
						PageData pd=new PageData();
						pd.put("group_id",group_id);
						pdlist.add(pd);
					}
					ThreadMail thread=new ThreadMail();
					thread.setTaskAssignService(taskAssignService);
					thread.setPlist(pdlist);
					thread.setUser_id((String)delegateTask.getVariable("user_id"));
					thread.setSubject("东南CRM系统提醒");//标题

					String processname="合同审核流程";
					thread.setContent("您好：东南CRM系统中有新的待办事项："+processname+"，请您及时登录处理：<br>" +
							"http://crm.dndt.net:8080/DNCRM<br><br><br>" +
							"东南电梯股份有限公司 东南CRM系统 ");//内容
					new Thread(thread).start();

            }else if(definitiokey!=null&&"createtask".equals(definitiokey)){
                CheckTerm checkTerm= (CheckTerm) delegateTask.getVariable("checkTerm");
                if((checkTerm!=null&&!checkTerm.isApprove())){
                    System.out.println("the end!!");
                    PageData pd=new PageData();
                    pd.put("HT_UUID",delegateTask.getVariable("HT_UUID"));
                    pd.put("ACT_STATUS",5);
                    contractNewService.editAct_Status(pd);
                    checkTerm.setApprove(true);
                    delegateTask.setVariable("checkTerm",checkTerm);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

		System.out.println("test"+delegateTask+">"+delegateTask.getTaskDefinitionKey()+">"+delegateTask.getProcessDefinitionId());
	}

	@Override
	public void notify(DelegateExecution delegateExecution) throws Exception {
		String eventname=delegateExecution.getEventName();
		String activityid=delegateExecution.getCurrentActivityId();
		TaskAssignService taskAssignService = SpringContextHolder.getBean("taskAssignService");
		ContractNewService contractNewService=SpringContextHolder.getBean("contractNewService");
		String a=delegateExecution.getProcessBusinessKey();
		if(eventname!=null&&activityid!=null&&"take".equals(eventname)&&"createtask".equals(activityid)){//创建人走完准备走下一个流程
		    Map<String,Object> map=delegateExecution.getVariables();
            List<String> busr =taskAssignService.findAllTechAuditGroup(map);
			Map<String,String> umap=new HashMap<String,String>();
			if(busr!=null){
				for (int i=0;i<busr.size();i++){
					String []splitarray=busr.get(i).split(",");
					for(String user:splitarray){
						umap.put(user,user);
					}
				}
			}

			List<String> usr=new ArrayList<String>(umap.keySet());
            delegateExecution.setVariable("allcount",usr.size());
            delegateExecution.setVariable("agreecount",0);
			delegateExecution.setVariable("assigneeList",usr);
		}else if (activityid!=null&&"endevent".equals(activityid)){//结束变更审核状态为通过
			PageData pd=new PageData();
			pd.put("HT_UUID",delegateExecution.getVariable("HT_UUID"));
			pd.put("ACT_STATUS",4);
			contractNewService.editAct_Status(pd);
			contractNewService.setYSK(pd);  //修改流程状态
		}
		System.out.println(delegateExecution.getEventName()+">"+delegateExecution.getCurrentActivityName()+">"+delegateExecution.getCurrentActivityId()+">"+delegateExecution.getId());
	}

}
