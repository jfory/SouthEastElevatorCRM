package com.dncrm.service.system.workflow;

import com.dncrm.common.WorkFlow;
import com.dncrm.util.PageData;
import com.dncrm.util.Tools;
import com.dncrm.util.WorkflowUtils;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.delegate.ActivityBehavior;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.*;

import javax.annotation.Resource;

/**
 * 工作流跟踪相关Service
 *
 * @author HenryYan
 */
@Component
@Service("workflowTraceService")
public class WorkflowTraceService {
    protected Logger logger = LoggerFactory.getLogger(getClass());

//    @Autowired
//    protected RuntimeService runtimeService;
//
//    @Autowired
//    protected TaskService taskService;
//
//    @Autowired
//    protected RepositoryService repositoryService;
//
//    @Autowired
//    protected IdentityService identityService;

    /**
     * 流程跟踪图
     *
     * @param processInstanceId 流程实例ID
     * @return 封装了各种节点信息
     */
    public List<Map<String, Object>> traceProcess(String processInstanceId) throws Exception {
        WorkFlow workFlow = new WorkFlow();
        Execution execution = workFlow.getRuntimeService().createExecutionQuery().executionId(processInstanceId).singleResult();//执行实例
        Object property = PropertyUtils.getProperty(execution, "activityId");
        String activityId = "";
        if (property != null) {
            activityId = property.toString();
        }
        ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId)
                .singleResult();
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) workFlow.getRepositoryService())
                .getDeployedProcessDefinition(processInstance.getProcessDefinitionId());
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点

        List<Map<String, Object>> activityInfos = new ArrayList<Map<String, Object>>();
        for (ActivityImpl activity : activitiList) {

            boolean currentActiviti = false;
            String id = activity.getId();

            // 当前节点
            if (id.equals(activityId)) {
                currentActiviti = true;
            }

            Map<String, Object> activityImageInfo = packageSingleActivitiInfo(activity, processInstance, currentActiviti);

            activityInfos.add(activityImageInfo);
        }

        return activityInfos;
    }
    /**
     * 流程跟踪图 with process definition id in English
     *
     * @param processDefinitionId 流程定义id
     * @return 封装了各种节点信息
     */
    public List<Map<String, Object>> traceProcessWithPdidInEn(String processDefinitionId) throws Exception {
        WorkFlow workFlow = new WorkFlow();

        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) workFlow.getRepositoryService())
                .getDeployedProcessDefinition(processDefinitionId);
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点

        List<Map<String, Object>> activityInfos = new ArrayList<Map<String, Object>>();
        for (ActivityImpl activity : activitiList) {
            boolean currentActiviti = false;
            String id = activity.getId();
            Map<String, Object> activityImageInfo = packageSingleActivitiInfoInEn(activity, currentActiviti);

            activityInfos.add(activityImageInfo);
        }

        return activityInfos;
    }
    /**
     * 流程跟踪图 with process definition id in Chinese
     *
     * @param processDefinitionId 流程定义id
     * @return 封装了各种节点信息
     */
    public List<Map<String, Object>> traceProcessWithPdidInCh(String processDefinitionId) throws Exception {
        WorkFlow workFlow = new WorkFlow();

        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) workFlow.getRepositoryService())
                .getDeployedProcessDefinition(processDefinitionId);
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点

        List<Map<String, Object>> activityInfos = new ArrayList<Map<String, Object>>();
        for (ActivityImpl activity : activitiList) {
            boolean currentActiviti = false;
            String id = activity.getId();
            Map<String, Object> activityImageInfo = packageSingleActivitiInfoInCh(activity, currentActiviti);

            activityInfos.add(activityImageInfo);
        }

        return activityInfos;
    }

    /**
     * 封装输出信息，包括：当前节点的X、Y坐标、变量信息、任务类型、任务描述
     *
     * @param activity
     * @param processInstance
     * @param currentActiviti
     * @return
     */
    private Map<String, Object> packageSingleActivitiInfo(ActivityImpl activity, ProcessInstance processInstance,
                                                          boolean currentActiviti) throws Exception {
        Map<String, Object> vars = new HashMap<String, Object>();
        Map<String, Object> activityInfo = new HashMap<String, Object>();
        activityInfo.put("currentActiviti", currentActiviti);
        setPosition(activity, activityInfo);
        setWidthAndHeight(activity, activityInfo);

        Map<String, Object> properties = activity.getProperties();
        vars.put("任务类型", WorkflowUtils.parseToZhType(properties.get("type").toString()));

        ActivityBehavior activityBehavior = activity.getActivityBehavior();
        logger.debug("activityBehavior={}", activityBehavior);
        if (activityBehavior instanceof UserTaskActivityBehavior) {

            Task currentTask = null;

			/*
             * 当前节点的task
			 */
            if (currentActiviti) {
                currentTask = getCurrentTaskInfo(processInstance);
            }

			/*
			 * 当前任务的分配角色
			 */
            UserTaskActivityBehavior userTaskActivityBehavior = (UserTaskActivityBehavior) activityBehavior;
            TaskDefinition taskDefinition = userTaskActivityBehavior.getTaskDefinition();
            Set<Expression> candidateGroupIdExpressions = taskDefinition.getCandidateGroupIdExpressions();
            if (!candidateGroupIdExpressions.isEmpty()) {

                // 任务的处理角色
                setTaskGroup(vars, candidateGroupIdExpressions);

                // 当前处理人
                if (currentTask != null) {
                    setCurrentTaskAssignee(vars, currentTask);
                }
            }
        }
        vars.put("节点说明", properties.get("documentation"));

        String description = activity.getProcessDefinition().getDescription();
        vars.put("描述", description);
        String fName = activity.getProcessDefinition().getName();
        vars.put("流程名称", fName);
        String key = activity.getProcessDefinition().getKey();
        vars.put("Key", key);
        String tName = (String)activity.getProperties().get("name");
        vars.put("节点名称", tName);
        vars.put("节点ID", activity.getId());

        logger.debug("trace variables: {}", vars);
        activityInfo.put("vars", vars);
        return activityInfo;
    }

    /**
     * 封装输出信息，包括：当前节点的X、Y坐标、变量信息、任务类型、任务描述 in English
     *
     * @param activity
     * @param currentActiviti
     * @return
     */
    private Map<String, Object> packageSingleActivitiInfoInEn(ActivityImpl activity,
                                                          boolean currentActiviti) throws Exception {
        Map<String, Object> vars = new HashMap<String, Object>();
        Map<String, Object> activityInfo = new HashMap<String, Object>();
        activityInfo.put("currentActiviti", currentActiviti);
        setPosition(activity, activityInfo);
        setWidthAndHeight(activity, activityInfo);

        Map<String, Object> properties = activity.getProperties();
        vars.put("type", properties.get("type").toString());

        ActivityBehavior activityBehavior = activity.getActivityBehavior();
        logger.debug("activityBehavior={}", activityBehavior);

        vars.put("doc", properties.get("documentation"));

        String description = activity.getProcessDefinition().getDescription();
        vars.put("desc", description);
        String fName = activity.getProcessDefinition().getName();
        vars.put("flow_name", fName);
        String key = activity.getProcessDefinition().getKey();
        vars.put("key", key);
        String tName = (String)activity.getProperties().get("name");
        vars.put("node_name", tName);
        vars.put("node_id", activity.getId());

        logger.debug("trace variables: {}", vars);
        activityInfo.put("vars", vars);
        return activityInfo;
    }
    /**
     * 封装输出信息，包括：当前节点的X、Y坐标、变量信息、任务类型、任务描述 in Chinese
     *
     * @param activity
     * @param currentActiviti
     * @return
     */
    private Map<String, Object> packageSingleActivitiInfoInCh(ActivityImpl activity,
                                                              boolean currentActiviti) throws Exception {
        Map<String, Object> vars = new HashMap<String, Object>();
        Map<String, Object> activityInfo = new HashMap<String, Object>();
        activityInfo.put("currentActiviti", currentActiviti);
        setPosition(activity, activityInfo);
        setWidthAndHeight(activity, activityInfo);

        Map<String, Object> properties = activity.getProperties();
        vars.put("任务类型", WorkflowUtils.parseToZhType(properties.get("type").toString()));

        ActivityBehavior activityBehavior = activity.getActivityBehavior();
        //获取优先级
        if (activityBehavior instanceof UserTaskActivityBehavior) {

			/*
			 * 当前任务的分配角色
			 */
            UserTaskActivityBehavior userTaskActivityBehavior = (UserTaskActivityBehavior) activityBehavior;
            TaskDefinition taskDefinition = userTaskActivityBehavior.getTaskDefinition();
            Set<Expression> candidateGroupIdExpressions = taskDefinition.getCandidateGroupIdExpressions();
            String priority = taskDefinition.getPriorityExpression().getExpressionText();
            vars.put("优先级", priority);
        }

        logger.debug("activityBehavior={}", activityBehavior);

        vars.put("节点说明", properties.get("documentation"));

        String description = activity.getProcessDefinition().getDescription();
        vars.put("描述", description);
        String fName = activity.getProcessDefinition().getName();
        vars.put("流程名称", fName);
//        String key = activity.getProcessDefinition().getKey();
//        vars.put("Key", key);
        String tName = (String)activity.getProperties().get("name");
        vars.put("节点名称", tName);
        vars.put("节点ID", activity.getId());

        logger.debug("trace variables: {}", vars);
        activityInfo.put("vars", vars);
        return activityInfo;
    }
    private void setTaskGroup(Map<String, Object> vars, Set<Expression> candidateGroupIdExpressions) {
        String roles = "";
        WorkFlow workFlow = new WorkFlow();
        for (Expression expression : candidateGroupIdExpressions) {
            String expressionText = expression.getExpressionText();
            String roleName = workFlow.getIdentityService().createGroupQuery().groupId(expressionText).singleResult().getName();
            roles += roleName;
        }
        vars.put("任务所属角色", roles);
    }

    /**
     * 设置当前处理人信息
     *
     * @param vars
     * @param currentTask
     */
    private void setCurrentTaskAssignee(Map<String, Object> vars, Task currentTask) {
        String assignee = currentTask.getAssignee();
        WorkFlow workFlow = new WorkFlow();
        if (assignee != null) {
            User assigneeUser = workFlow.getIdentityService().createUserQuery().userId(assignee).singleResult();
            String userInfo = assigneeUser.getFirstName() + " " + assigneeUser.getLastName();
            vars.put("当前处理人", userInfo);
        }
    }

    /**
     * 获取当前节点信息
     *
     * @param processInstance
     * @return
     */
    private Task getCurrentTaskInfo(ProcessInstance processInstance) {
        Task currentTask = null;
        WorkFlow workFlow = new WorkFlow();
        try {
            String activitiId = (String) PropertyUtils.getProperty(processInstance, "activityId");
            logger.debug("current activity id: {}", activitiId);

            currentTask = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstance.getId()).taskDefinitionKey(activitiId)
                    .singleResult();
            logger.debug("current task for processInstance: {}", ToStringBuilder.reflectionToString(currentTask));

        } catch (Exception e) {
            logger.error("can not get property activityId from processInstance: {}", processInstance);
        }
        return currentTask;
    }

    /**
     * 设置宽度、高度属性
     *
     * @param activity
     * @param activityInfo
     */
    private void setWidthAndHeight(ActivityImpl activity, Map<String, Object> activityInfo) {
        activityInfo.put("width", activity.getWidth());
        activityInfo.put("height", activity.getHeight());
    }

    /**
     * 设置坐标位置
     *
     * @param activity
     * @param activityInfo
     */
    private void setPosition(ActivityImpl activity, Map<String, Object> activityInfo) {
        activityInfo.put("x", activity.getX());
        activityInfo.put("y", activity.getY());
    }
    
    @Resource(name = "sysUserService")
    private com.dncrm.service.system.sysUser.sysUserService sysUserService;
    
    public List<Map> getViewHistory(String processInstanceId) throws Exception{
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
