package com.dncrm.test;

import com.dncrm.common.WorkFlow;
import com.dncrm.listener.workflow.CheckTerm;
import com.dncrm.service.system.workflow.WorkFlowService;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.dncrm.util.tree.VirtualDataGenerator;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.activiti.engine.test.ActivitiRule;
import org.junit.Rule;
import org.junit.Test;

import javax.annotation.Resource;
import java.io.InputStream;
import java.util.*;

import static org.junit.Assert.assertNotNull;


/**
 * Created by Simon on 16/7/18.
 */

/**
 * Test of Activiti
 *
 * @author Simon
 * @create 2016-07-18 下午4:19
 **/
public class TestActiviti {

	private WorkFlow workFlow = new WorkFlow();
	@Resource (name = "workFlowService")
	WorkFlowService workFlowService;
	
	@Rule
	public ActivitiRule activitiRule=new ActivitiRule();
	/**
	 * 数据库表结构
	 * ACT_RE_PROCDEF 	#流程定义表
	 * ACT_GE_BYTEARRY 	#资源文件表
	 * ACT_GE_PROPERTY  #主键生成策略表
	 * ACT_RU_EXECUTION #正在执行的执行对象表
	 * ACT_HI_PROCINST 	#流程实例的历史表
	 * ACT_RU_TASK	    #正在执行的任务表（只有节点是UserTask的时候，该表中才存在数据)
	 * ACT_HI_TASAKINST #任务历史表（只有节点是UserTask的时候，该表中才存在数据)
	 * ACT_HI_ACTINST	#所有活动节点的历史表
	 * 
	 * ACT_RU_VARIABLE 	#正在执行的流程变量
	 * ACT_HI_VARINST 	#历史的流程变量 
	 * 
	 * ACT_RU_IDENTITYLINK # 任务办理人表（个人任务、组任务）
	 * ACT_HI_IDENTITYLINK # 历史任务办理人表（个人任务、组任务）
	 * 
	 * ACT_ID_GROUP 	#角色表
	 * ACT_ID_USER		#用户表
	 * ACT_ID_MEMBERSHIP #用户角色关系表
	 */
	
	public ProcessEngine processEngine2;
	
	public ProcessEngine getProcessEngine2() {
		return ProcessEngines.getDefaultProcessEngine();
	}

	@Test
	public void startProcess() throws Exception
	{
		RepositoryService repositoryService = activitiRule.getRepositoryService();

		ProcessEngine processEngine=ProcessEngines.getDefaultProcessEngine();
		// TODO:Assembel the process deployment with configuration.
		// @see:
		processEngine.getRepositoryService().
		createDeployment().addClasspathResource("activiti/diagrams/newContract.bpmn")
				.addClasspathResource("activiti/diagrams/newContract.png")
				.addClasspathResource("activiti/diagrams/LoanRequestRules.drl").enableDuplicateFiltering()
				.name("newContract").deploy();
        /*repositoryService.createDeployment().addClasspathResource("diagrams/BusinessRuleLoanProcess.bpmn")
            .addClasspathResource("diagrams/BusinessRuleLoanProcess.png")
            .addClasspathResource("diagrams/LoanRequestRules.drl").enableDuplicateFiltering()
            .name("businessRuleLoanProcessSimple").deploy();*/
		// repositoryService.createDeployment().addInputStream("BusinessRuleLoanProcess.bpmn",
		// new FileInputStream(filename)).deploy();
		RuntimeService runtimeService = activitiRule.getRuntimeService();

		/*IdentityService identityService= processEngine.getIdentityService();
		Group gp1=identityService.newGroup("1a");
		gp1.setName("组1");
		gp1.setType("manager");
		identityService.saveGroup(gp1);

		Group gp2=identityService.newGroup("2a");
		gp2.setName("组2");
		gp2.setType("manager");
		identityService.saveGroup(gp2);
		User user1=identityService.newUser("3a");
		identityService.saveUser(user1);
		User user4=identityService.newUser("4a");
		identityService.saveUser(user4);
		identityService.createMembership("3a","1a");
		identityService.createMembership("4a","2a");
*/
		List<String> usr=new ArrayList<String>();
		usr.add("1a");
		//usr.add("2a");


		Map<String, Object> variableMap = new HashMap<String, Object>();
		variableMap.put("name", "Nadim");
		variableMap.put("allcount", 5400);
		variableMap.put("agreecount", 5400);

		//variableMap.put("assigneeList",usr);

		CheckTerm checkTerm=new CheckTerm();
		checkTerm.setAlldiscount(52);
		checkTerm.setChangguidiscount(52);
		checkTerm.setChargesstatus("0");
		checkTerm.setProfit("1");
		checkTerm.setNextlevel(false);
		checkTerm.setApprove(true);
		variableMap.put("checkTerm",checkTerm);
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("newContract", "test.test.id",variableMap);




		TaskService taskService=processEngine.getTaskService();
		List<Task> toHandleListCount4 = workFlow.getTaskService().createTaskQuery().processDefinitionKey("newContract").orderByTaskCreateTime().desc().active().list();
		while (true){
			List<Task> tslist=taskService.createTaskQuery().taskCandidateOrAssigned("3a").list();
			if (tslist.size()<=0){break;}
			for (Task task:tslist){
            /*TestObj testObj=new TestObj();
            testObj.setTest1((Integer) taskService.getVariable(task.getId(),"test1"));
            testObj.setTest2((Integer) taskService.getVariable(task.getId(),"test2"));
            taskService.setVariable(task.getId(),"testobj",testObj);*/
            //System.out.println("allcount:"+taskService.getVariables(task.getId()));
				taskService.setVariable(task.getId(),"allcount",1);
				taskService.setVariable(task.getId(),"agreecount",1);
				taskService.complete(task.getId());
				System.out.println("id " +task.getId() + " " + task.getName());
			}
		}


		List<Task> tslist3=taskService.createTaskQuery().taskCandidateOrAssigned("3a").list();

		List<Task> tslist2=taskService.createTaskQuery().taskCandidateOrAssigned("4a").list();

		for (Task task:tslist2){
			taskService.complete(task.getId());
			System.out.println("id " +task.getId() + " " + task.getName());
		}

		assertNotNull(processInstance.getId());
		System.out.println("id " + processInstance.getId() + " " + processInstance.getProcessDefinitionId());
	}
	
	/**
	 * 创建表
	 */
	 @Test
	 public void createTable(){
	 ProcessEngineConfiguration processEngineConfiguration =
	 ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("activiti.cfg.xml");
	 ProcessEngine processEngine =processEngineConfiguration.buildProcessEngine();
	 System.out.println("xxxxxx--->processEngine:"+processEngine);
	 }

	 /**
	  * 通过xml默认配置，直接获得流程引擎
	  */
	ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

	/**
	 * 部署流程
	 */
	@Test
	public void deployActiviti() {
		// ProcessEngineConfiguration processEngineConfiguration =
		// ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("activiti/activiti.cfg.xml");
		// ProcessEngine processEngine =
		// processEngineConfiguration.buildProcessEngine();
		try {
			Deployment deployment = processEngine.getRepositoryService().createDeployment().name("helloworld入门程序")
					.addClasspathResource("activiti/diagrams/helloworld.bpmn")
					.addClasspathResource("activiti/diagrams/helloworld.png").deploy();
			System.out.println("deployment id -->" + deployment.getId());
			System.out.println("deployment name -->" + deployment.getName());
			System.out.println("deployment tenantId -->" + deployment.getTenantId());
			System.out.println("deployment category -->" + deployment.getCategory());
		} catch (Exception e) {
			System.out.println("deployActiviti--error-->" +e);
		}

	}
	/**
	 * 启动流程实例
	 */
	@Test
	public void startProcessInstance(){
		//定义流程的key
		String processDefinitionKey = "helloworld";//bpmn文件中定义的id
		System.out.println("processDefinitionKey-->"+processDefinitionKey);
		try {
			ProcessInstance processInstance = processEngine.getRuntimeService().startProcessInstanceByKey(processDefinitionKey);
			System.out.println("流程实例id："+processInstance.getId());
			System.out.println("流程定义id："+processInstance.getProcessDefinitionId());
		} catch (Exception e) {
			System.out.println("start process error -->"+e);
		}
		
	}

	@Test
	public void testFind(){
		workFlowService.findPersonalTaskWithAssignee("张大大");
	}
	/**
	 * 查询当前个人的流程实例
	 */
	@Test
	public void findPersonalTask(){
		String assignee = "李大大";//通过assignee查找
//		List <Task> tasks = processEngine.getTaskService().createTaskQuery().taskAssignee(assignee).list();
//		List <Task> tasks = this.getProcessEngine2().getTaskService().createTaskQuery().taskAssignee(assignee).list();
		List <Task> tasks = workFlow.taskService.createTaskQuery().taskAssignee(assignee).list();
		if (tasks!=null) {
			for (Task task : tasks) {
				System.out.println("*****************************************");
				System.out.println("任务id："+task.getId());
				System.out.println("任务名称："+task.getName());
				System.out.println("任务创建时间："+task.getCreateTime());
				System.out.println("任务办理人："+task.getAssignee());
				System.out.println("流程实例id："+task.getProcessInstanceId());
				System.out.println("执行对象id："+task.getExecutionId());
				System.out.println("#########################################");
			}
			
		}
	}
	/**
	 * 办理个人任务
	 */
	@Test
	public void completePersonalTask(){
		//任务id
		String taskId = "30004";
		processEngine.getTaskService().complete(taskId);
		System.out.println("完成任务，任务id："+taskId);
	}
	
	/**
	 * 添加comment
	 */
	@Test
	public void addComment(){
		//任务id
		String taskId = "5004";
		String message = "这是一个comment";
		processEngine.getTaskService().addComment(taskId, null, message);
		System.out.println("添加comment，任务id："+taskId);
		System.out.println("添加comment，comment："+message);
	}
	/**
	 * 办理个人任务，添加comment
	 */
	@Test
	public void completePersonalTaskWithComment2(){
		//任务id
		String taskId = "30004";
		String message = "这是一个comment";
		processEngine.getTaskService().addComment(taskId, null, message);
		processEngine.getTaskService().complete(taskId);
		System.out.println("添加comment，任务id："+taskId);
		System.out.println("添加comment，comment："+message);
	}
	
	/**
	 * 查询流程定义
	 */
	@Test
	public void findProcessDefinition(){
		String processDefinitionKey = "helloworld";
		List <ProcessDefinition> processDefinitions = processEngine.getRepositoryService().createProcessDefinitionQuery().processDefinitionKey(processDefinitionKey).list();
		if (processDefinitions!=null) {
			for (ProcessDefinition processDefinition : processDefinitions) {
				System.out.println("流程定义id："+processDefinition.getId());
				System.out.println("流程定义名称："+processDefinition.getName());
				System.out.println("部署id："+processDefinition.getDeploymentId());
				System.out.println("流程定义key："+processDefinition.getKey());
				System.out.println("流程定义资源名称："+processDefinition.getResourceName());
				System.out.println("流程定义图片资源名称："+processDefinition.getDiagramResourceName());
				System.out.println("流程定义版本号："+processDefinition.getVersion());
				System.out.println("#########################################");
			}
		}
	}
	/**
	 *  查询最新版本的流程定义
	 */
	@Test
	public void findLatestVersionProcessDefinition(){
		List <ProcessDefinition> processDefinitions = processEngine.getRepositoryService().
				createProcessDefinitionQuery().
				orderByProcessDefinitionVersion().asc().list();
		Map<String,ProcessDefinition> map = new LinkedHashMap<String,ProcessDefinition>();
		if (processDefinitions!=null&&processDefinitions.size()>0) {
			for (ProcessDefinition processDefinition : processDefinitions) {
				map.put(processDefinition.getKey(), processDefinition);
			}
		}
		List<ProcessDefinition> pdList = new ArrayList<ProcessDefinition>(map.values());
		if (pdList!=null&&pdList.size()>0) {
			for (ProcessDefinition processDefinition : pdList) {
				System.out.println("最新版本流程定义id："+processDefinition.getId());
				System.out.println("最新版本流程定义名称："+processDefinition.getName());
				System.out.println("最新版本部署id："+processDefinition.getDeploymentId());
				System.out.println("最新版本流程定义key："+processDefinition.getKey());
				System.out.println("最新版本流程定义资源名称："+processDefinition.getResourceName());
				System.out.println("最新版本流程定义图片资源名称："+processDefinition.getDiagramResourceName());
				System.out.println("最新版本流程定义版本号："+processDefinition.getVersion());
				System.out.println("#########################################");
			}
		}
	}
	/**
	 * 删除相同key的不同版本流程定义
	 */
	@Test
	public void deleteProcessDefinitionByKey(){
		String processDefinitionKey = "newContract";
		List<ProcessDefinition> processDefinitions = processEngine.getRepositoryService().createProcessDefinitionQuery().processDefinitionKey(processDefinitionKey).list();
		
		if(processDefinitions!=null&&processDefinitions.size()>0){
			for (ProcessDefinition processDefinition : processDefinitions) {
				//获取部署id
				System.out.println("删除流程定义：id->"+processDefinition.getId()+"--name->"+processDefinition.getName());
				String deploymentId = processDefinition.getDeploymentId();
				processEngine.getRepositoryService().deleteDeployment(deploymentId,true);//如果流程已经启动，设置为false不能删除，设置为true则为级连删除
				System.out.println("成功删除");
			}
		}
	}
	/**
	 * 查询历史任务
	 */
	@Test
	public void findPersonalHistoryTask(){
		String assignee = "张三";
		List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(assignee).list();
		if (historicTaskInstances!=null&&historicTaskInstances.size()>0) {
			for (HistoricTaskInstance historicTaskInstance : historicTaskInstances) {
				System.out.println("历史任务id："+historicTaskInstance.getId());
				System.out.println("历史任务名称："+historicTaskInstance.getName());
				System.out.println("历史任务任务执行者："+historicTaskInstance.getAssignee());
				System.out.println("历史任务执行id："+historicTaskInstance.getExecutionId());
				System.out.println("历史任务owner："+historicTaskInstance.getOwner());
				System.out.println("历史任务dueDate："+historicTaskInstance.getDueDate());
				System.out.println("历史任务duration in milliseconds："+historicTaskInstance.getDurationInMillis());
				System.out.println("历史任务开始时间："+historicTaskInstance.getStartTime());
				System.out.println("历史任务结束时间："+historicTaskInstance.getEndTime());
				System.out.println("##################################################");
			}
		}
	}
	/**
	 * 查询历史流程实例
	 */
	@Test
	public void findPersonalHistoryProcessInstance(){
		String processInstanceId = "30001";
		HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		
		if (historicProcessInstance!=null) {
			System.out.println("历史流程实例id："+historicProcessInstance.getId());
			System.out.println("历史流程实例businesskey："+historicProcessInstance.getBusinessKey());
			System.out.println("历史流程实例name："+historicProcessInstance.getName());
			System.out.println("历史流程实例deletereason："+historicProcessInstance.getDeleteReason());
			System.out.println("历史流程实例部署id："+historicProcessInstance.getDeploymentId());
			System.out.println("历史流程实例定义id："+historicProcessInstance.getProcessDefinitionId());
			System.out.println("历史流程实例定义key："+historicProcessInstance.getProcessDefinitionKey());
			System.out.println("历史流程实例定义name："+historicProcessInstance.getProcessDefinitionName());
			System.out.println("历史流程实例start actity id："+historicProcessInstance.getStartActivityId());
			System.out.println("历史流程实例start ueser id："+historicProcessInstance.getStartUserId());
			System.out.println("历史流程实例super process instance id："+historicProcessInstance.getSuperProcessInstanceId());
//			System.out.println("历史流程实例 end activity id："+historicProcessInstance.getEndActivityId());
		}
	}
	/*** 流程变量***/
	
	/***
	 * 输入流加载资源文件的3种方式
	 */
	//从classpath根目录下加载指定名称的文件
	InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("diagrams/processVariables.bpmn");
	//从当前包下加载指定名称的文件
	InputStream inputStream2 = this.getClass().getResourceAsStream("processVariables.bpmn");
	//从classpath根目录下加载指定名称的文件
	InputStream inputStream3 = this.getClass().getResourceAsStream("/processVariables.bpmn");
	
	/**
	 * 部署流程定义(从inputstream）
	 */
	@Test
	public void deployProcessDefinition_inputstream(){
		InputStream inputStreamBpmn = this.getClass().getResourceAsStream("/activiti/diagrams/processVariables.bpmn");
		InputStream inputStreamPng = this.getClass().getResourceAsStream("/activiti/diagrams/processVariables.png");
		
		Deployment deployment = processEngine.getRepositoryService().createDeployment()
				.name("流程定义")
				.addInputStream("processVariables.bpmn", inputStreamBpmn)//使用资源文件的名称（要求与资源文件的名称一致）
				.addInputStream("processVariables.png", inputStreamPng)//使用资源文件的名称（要求与资源文件的名称一致）
				.deploy();
		System.out.println("部署id："+deployment.getId());
		System.out.println("部署name："+deployment.getName());
		
	}
	/**
	 * 启动流程实例
	 */
	@Test
	public void startProcessInstance2(){
		//定义流程的key
		String processDefinitionKey = "processVariables";//bpmn文件中定义的id
		System.out.println("processDefinitionKey-->"+processDefinitionKey);
		try {
			ProcessInstance processInstance = processEngine.getRuntimeService().startProcessInstanceByKey(processDefinitionKey);
			System.out.println("流程实例id："+processInstance.getId());
			System.out.println("流程定义id："+processInstance.getProcessDefinitionId());
		} catch (Exception e) {
			System.out.println("start process error -->"+e);
		}
		
	}
	
	/**
	 * 模拟设置和获取流程变量的场景
	 */
	@Test
	public void setAndGetVariables(){
		/**与流程实例，执行对象（正在执行）**/
		RuntimeService runtimeService = processEngine.getRuntimeService();
		/**与任务（正在执行）**/
		TaskService taskService =processEngine.getTaskService();
		
		/**设置流程变量**/
//		runtimeService.setVariable(executionId, variableName, value);//使用执行对象id，一次一个
//		runtimeService.setVariables(executionId, variables);//使用执行对象id，多个
		
//		taskService.setVariable(taskId, variableName, value);//使用任务id，一次一个
//		taskService.setVariables(taskId, variables);//使用任务id，一次多个
		/**获取流程变量**/
//		runtimeService.getVariable(executionId, variableName)//使用执行对象id，变量名称，一次一个
//		runtimeService.getVariables(executionId)//使用执行对象id，多个对象，返回map
		
//		taskService.getVariable(taskId, variableName)//使用任务id，变量名称，一次一个
//		taskService.getVariables(taskId);//使用任务id，一次多个，返回map
	}
	/**
	 * 设置流程变量
	 */
	@Test
	public void setVariables(){
		//double ,long ,text
		//相同名称会被覆盖
		TaskService taskService =processEngine.getTaskService();
		String taskId ="40004";
		taskService.setVariable(taskId, "请假天数", 5);
//		taskService.setVariableLocal(taskId, "请假天数", 5);//与任务id绑定
		taskService.setVariable(taskId, "请假日期", new Date());
		taskService.setVariable(taskId, "请假原因", "回家探亲");
		System.out.println("流程变量设置成功");
		/****
		 * 放置到act_ru_variable,act_hi_variable
		 */
	}
	/**
	 * 设置local流程变量
	 * 
	 * 区别
	 * 
	 * setVariable 设置流程变量的时候，流程变量名称相同的时候，后一次的值替换前面一次的值，而且可以看到task_id的字段不会存放任务id的值
	 * 
	 * setVariableLocal:
	 * 1.设置流程变量的时候，针对当前活动的节点设置流程变量，如果一个流程中存在2个活动节点，对每个活动节点都设置流程变量，即使流程变量的名称箱体，后一次的值也不会替换前一次的值，
	 * 它会使用不同的任务id作为标识，存放两个流程变量值，而且可以看到task_id的字段会存放任务id的值
	 * 2.使用该方法时，流程变量与当前任务进行绑定，当流程继续执行时，下一个任务获取不到该流程变量（因为正在执行的流程变量中已经没有了这个数据），所有查询正在执行的任务时
	 * 不能查到我们需要的数据，此时需要查询历史数据
	 */
	@Test
	public void setLocalVariables(){
		//double ,long ,text
		//相同名称会被覆盖
		TaskService taskService =processEngine.getTaskService();
		String taskId ="52502";
		taskService.setVariableLocal(taskId, "请假天数", 5);//与任务id绑定
		taskService.setVariableLocal(taskId, "请假日期", new Date());
		taskService.setVariableLocal(taskId, "请假原因", "回家探亲");
		System.out.println("流程变量设置成功");
		/****
		 * 放置到act_ru_variable,act_hi_variable
		 */
	}
	/**
	 * 获取流程变量
	 */
	@Test
	public void getVariables(){
		TaskService taskService =processEngine.getTaskService();
		String taskId ="52502";
		/**1.使用基本数据类型**/
		Integer days  = (Integer) taskService.getVariable(taskId, "请假天数");
		Date date = (Date) taskService.getVariable(taskId, "请假日期");
		String reason  = (String) taskService.getVariable(taskId, "请假原因");
		System.out.println("请假天数："+days);
		System.out.println("请假时间："+date);
		System.out.println("请假原因："+reason);
	}
	
	/**
	 * 办理个人任务
	 */
	@Test
	public void completePersonalTask2(){
		//任务id
		String taskId = "47504";
		processEngine.getTaskService().complete(taskId);
		System.out.println("完成任务，任务id："+taskId);
	}
	/**
	 * 设置流程变量 with javabean
	 */
	@Test
	public void setVariablesWithJavaBean(){
		//double ,long ,text
		//相同名称会被覆盖
		TaskService taskService =processEngine.getTaskService();
		String taskId ="52502";
		Person person = new Person();
		person.setId(2);
		person.setName("小明");
		person.setSex("男");
		taskService.setVariable(taskId, "人员信息2", person);
		System.out.println("流程变量Person设置成功");
		/****
		 * 放置到act_ru_variable,act_hi_variable
		 */
	}
	/**
	 * 获取流程变量 with javabean
	 */
	@Test
	public void getVariablesWithJavaBean(){
		TaskService taskService =processEngine.getTaskService();
		String taskId ="52502";
		/**2.使用JavaBean**/
		Person person   = (Person) taskService.getVariable(taskId, "人员信息");
		
		System.out.println("人员id："+person.getId());
		System.out.println("人员name："+person.getName());
		System.out.println("人员性别："+person.getSex());
	}
	/**
	 * 查询流程变量的历史记录
	 */
	@Test
	public void findHistoryVariables(){
		List <HistoricVariableInstance> historicVariableInstances =processEngine.getHistoryService().createHistoricVariableInstanceQuery().variableName("请假天数").list();
	    if (historicVariableInstances!=null&&historicVariableInstances.size()>0) {
			for (HistoricVariableInstance historicVariableInstance : historicVariableInstances) {
				System.out.println("历史变量id："+historicVariableInstance.getId());
				System.out.println("历史变量流程实例id："+historicVariableInstance.getProcessInstanceId());
				System.out.println("历史变量任务id："+historicVariableInstance.getTaskId());
				System.out.println("历史变量名称："+historicVariableInstance.getVariableName());
				System.out.println("历史变量类型名称："+historicVariableInstance.getVariableTypeName());
				System.out.println("历史变量值："+historicVariableInstance.getValue());
				System.out.println("历史变量最新更新时间："+historicVariableInstance.getLastUpdatedTime());
				System.out.println("历史变量创建时间："+historicVariableInstance.getCreateTime());
				System.out.println("历史变量时间："+historicVariableInstance.getTime());
				System.out.println("##############################################");
			}
		}
    }
	    
	    
	/**
	 * 查询历史任务
	 */
	@Test
	public void findHistoryTask(){
		String processInstanceId = "47501";
	   List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService().createHistoricTaskInstanceQuery().processInstanceId(processInstanceId)
	    .orderByHistoricTaskInstanceStartTime().asc().list();
	    
	   if (historicTaskInstances!=null&&historicTaskInstances.size()>0) {
		for (HistoricTaskInstance historicTaskInstance : historicTaskInstances) {
			System.out.println("id:"+historicTaskInstance.getId());
			System.out.println("name:"+historicTaskInstance.getName());
			System.out.println("assignee:"+historicTaskInstance.getAssignee());
			System.out.println("##############################################");
		}
	}
	}
	/**
	 * 查询流程实例
	 */
	@Test
	public void findProcessInstance(){
		List<ProcessInstance> processInstances = processEngine.getRuntimeService().createProcessInstanceQuery().list();
		
		if (processInstances!=null&&processInstances.size()>0) {
			for (ProcessInstance processInstance : processInstances) {
				System.out.println("id:"+processInstance.getId());
				System.out.println("name:"+processInstance.getName());
				System.out.println("key:"+processInstance.getProcessDefinitionKey());
				System.out.println("##############################################");
			}
		}
	}
	/***
	 * test tree
	 */
	@Test
	public void testTree(){
		// 读取层次数据结果集列表 
		List<?> dataList = VirtualDataGenerator.getVirtualResult();
		MultipleTree tree = new MultipleTree();
		Node node = tree.makeTreeWithOderNo(dataList, 1);
		System.out.println(node);
	}
	@Test
	public void testActiviti(){
		// 等待签收的任务
		List<Task> tasks = processEngine.getTaskService().createTaskQuery().taskCandidateGroup("68f9baba91104d2d947974c97a996d06").active().list();
		for (Task task:tasks
			 ) {
			System.out.println("task assignee-->"+task);

		}
		// 等待签收的任务
		List<Task> tasks1 = processEngine.getTaskService().createTaskQuery().taskCandidateOrAssigned("68f9baba91104d2d947974c97a996d06").active().list();
		for (Task task:tasks
				) {
			System.out.println("task1 assignee-->"+task);
			System.out.println("task1 assignee-->"+task);
			String processInstanceId = task.getProcessInstanceId();
			ProcessInstance processInstance = processEngine.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
			String businessKey = processInstance.getBusinessKey();
			if (businessKey == null) {
				continue;
			}
			System.out.println("task1 processInstanceId-->"+processInstanceId);
			System.out.println("task1 processInstance-->"+processInstance);
			System.out.println("task1 businessKey-->"+businessKey);

		}

	}

	@Test
	public void testActivitiHistory(){

		String processInstanceId = "47549";
		List<HistoricProcessInstance> historicProcessInstances = processEngine.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).list();

		for (HistoricProcessInstance historicProcessInstance :historicProcessInstances
				) {
			System.out.println("historicProcessInstance -->"+historicProcessInstance);
			System.out.println("historicProcessInstance -id->"+historicProcessInstance.getId());
			System.out.println("historicProcessInstance -name->"+historicProcessInstance.getName());
			System.out.println("historicProcessInstance -bkey->"+historicProcessInstance.getBusinessKey());
			System.out.println("historicProcessInstance -dname->"+historicProcessInstance.getProcessDefinitionName());

		}

		List<HistoricActivityInstance> historicActivityInstances = processEngine.getHistoryService().createHistoricActivityInstanceQuery().processInstanceId(processInstanceId).list();

		for (HistoricActivityInstance historicActivityInstance :historicActivityInstances
				) {
			System.out.println("##########################################################");
			System.out.println("historicActivityInstance -->"+historicActivityInstance);
			System.out.println("historicActivityInstance -id->"+historicActivityInstance.getId());
			System.out.println("historicActivityInstance -taskid->"+historicActivityInstance.getTaskId());
			System.out.println("historicActivityInstance -aName->"+historicActivityInstance.getActivityName());
			System.out.println("historicActivityInstance -assignee->"+historicActivityInstance.getAssignee());
			System.out.println("historicActivityInstance -start->"+historicActivityInstance.getStartTime());
			System.out.println("historicActivityInstance -end->"+historicActivityInstance.getEndTime());
			System.out.println("historicActivityInstance -dur->"+historicActivityInstance.getDurationInMillis());
			System.out.println("historicActivityInstance -acid->"+historicActivityInstance.getActivityId());

		}

		List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService().createHistoricTaskInstanceQuery().processInstanceId(processInstanceId).list();

		for (HistoricTaskInstance historicTaskInstance :historicTaskInstances
				) {
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			System.out.println("historicTaskInstance -->"+historicTaskInstance);
			System.out.println("historicTaskInstance -id->"+historicTaskInstance.getId());
			System.out.println("historicTaskInstance -name->"+historicTaskInstance.getName());
			System.out.println("historicTaskInstance -dreason->"+historicTaskInstance.getDeleteReason());
			System.out.println("historicTaskInstance -assignee->"+historicTaskInstance.getAssignee());
			System.out.println("historicTaskInstance -start->"+historicTaskInstance.getStartTime());
			System.out.println("historicTaskInstance -end->"+historicTaskInstance.getEndTime());
			System.out.println("historicTaskInstance -dur->"+historicTaskInstance.getDurationInMillis());
			System.out.println("historicTaskInstance -ctime->"+historicTaskInstance.getClaimTime());
			System.out.println("historicTaskInstance -wdur->"+historicTaskInstance.getWorkTimeInMillis());
			System.out.println("historicTaskInstance -vars->"+historicTaskInstance.getProcessVariables());
			System.out.println("historicTaskInstance -task local var->"+historicTaskInstance.getTaskLocalVariables());
			System.out.println("historicTaskInstance -catogry->"+historicTaskInstance.getCategory());
			System.out.println("historicTaskInstance -desc->"+historicTaskInstance.getDescription());
			System.out.println("historicTaskInstance -task def ky->"+historicTaskInstance.getTaskDefinitionKey());
			System.out.println("historicTaskInstance -task exc id->"+historicTaskInstance.getExecutionId());
			System.out.println("historicTaskInstance -parent task id->"+historicTaskInstance.getParentTaskId());
			System.out.println("historicTaskInstance -owner->"+historicTaskInstance.getOwner());
			System.out.println("historicTaskInstance -getTenantId->"+historicTaskInstance.getTenantId());
			System.out.println("historicTaskInstance -getPriority->"+historicTaskInstance.getPriority());
			System.out.println("historicTaskInstance -getDueDate->"+historicTaskInstance.getDueDate());
			List<Comment> comments =  processEngine.getTaskService().getTaskComments(historicTaskInstance.getId());
			for (Comment comment :
					comments) {
				System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
				System.out.println("historicActivityInstance -comment-userid->"+comment.getUserId());
				System.out.println("historicActivityInstance -comment-msg->"+comment.getFullMessage());
				System.out.println("historicActivityInstance -comment-time->"+comment.getTime());
				System.out.println("historicActivityInstance -comment-type->"+comment.getType());

			}

			List<HistoricVariableInstance> historicVariableInstances = processEngine.getHistoryService().createHistoricVariableInstanceQuery().taskId(historicTaskInstance.getId()).list();

			for (HistoricVariableInstance historicVariableInstance :historicVariableInstances
					) {
				System.out.println("******************************************************");
				System.out.println("historicVariableInstance -->"+historicVariableInstance);
				System.out.println("historicVariableInstance -id->"+historicVariableInstance.getId());
				System.out.println("historicVariableInstance -vname->"+historicVariableInstance.getVariableName());
				System.out.println("historicVariableInstance -tname->"+historicVariableInstance.getVariableTypeName());
				System.out.println("historicVariableInstance -value->"+historicVariableInstance.getValue());
				System.out.println("historicVariableInstance -time->"+historicVariableInstance.getTime());
				System.out.println("historicVariableInstance -create_time->"+historicVariableInstance.getCreateTime());
				System.out.println("historicVariableInstance -lastupdate_time->"+historicVariableInstance.getLastUpdatedTime());
				System.out.println("historicVariableInstance -tid->"+historicVariableInstance.getTaskId());
				if (historicVariableInstance.getVariableName().equals("action")){
					System.out.println("the action is --------------------->"+historicVariableInstance.getValue());
				}

			}

		}
		List<HistoricVariableInstance> historicVariableInstances = processEngine.getHistoryService().createHistoricVariableInstanceQuery().processInstanceId(processInstanceId).list();

		for (HistoricVariableInstance historicVariableInstance :historicVariableInstances
				) {
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println("historicVariableInstance -->"+historicVariableInstance);
			System.out.println("historicVariableInstance -id->"+historicVariableInstance.getId());
			System.out.println("historicVariableInstance -vname->"+historicVariableInstance.getVariableName());
			System.out.println("historicVariableInstance -tname->"+historicVariableInstance.getVariableTypeName());
			System.out.println("historicVariableInstance -value->"+historicVariableInstance.getValue());
			System.out.println("historicVariableInstance -time->"+historicVariableInstance.getTime());
			System.out.println("historicVariableInstance -create_time->"+historicVariableInstance.getCreateTime());
			System.out.println("historicVariableInstance -lastupdate_time->"+historicVariableInstance.getLastUpdatedTime());
			System.out.println("historicVariableInstance -tid->"+historicVariableInstance.getTaskId());

		}

	}
	@Test
	public void getTaskById(){
//		String processInstanceId = "50504";
//		ProcessInstance pi = processEngine.getRuntimeService().createProcessInstanceQuery().processInstanceId("50504").singleResult();
//		Task task = processEngine.getTaskService().createTaskQuery().processInstanceId(processInstanceId).active().singleResult();
//		System.out.println("pi -->"+pi);
//		System.out.println("task -->"+task);
		String task_id = "50578";
		Task task = processEngine.getTaskService().createTaskQuery().taskId(task_id).singleResult();
		System.out.println("task -->"+task.getName());
		System.out.println("task -->"+task.getAssignee());
	}
}
