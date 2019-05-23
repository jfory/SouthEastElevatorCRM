package com.dncrm.common;

import org.activiti.engine.*;

public class WorkFlow {

	public TaskService taskService;

	public RuntimeService runtimeService;

	public RepositoryService repositoryService;

	public IdentityService identityService;

	public ManagementService managementService;

	public ProcessEngine processEngine;

	public HistoryService historyService;

	public WorkFlow() {
		if (!ProcessEngines.isInitialized()) {
			buildProcessEngine();
		}
		this.processEngine=ProcessEngines.getDefaultProcessEngine();
		this.taskService = this.processEngine.getTaskService();
		this.runtimeService = this.processEngine.getRuntimeService();
		this.repositoryService = this.processEngine.getRepositoryService();
		this.identityService = this.processEngine.getIdentityService();
		this.managementService = this.processEngine.getManagementService();
		this.historyService = this.processEngine.getHistoryService();
	}

	public void setProcessEngine(ProcessEngine processEngine) {
		this.processEngine = processEngine;
	}

	public TaskService getTaskService() {
		return taskService;
	}

	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	public RuntimeService getRuntimeService() {
		return runtimeService;
	}

	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}

	public RepositoryService getRepositoryService() {
		return repositoryService;
	}

	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}

	public IdentityService getIdentityService() {
		return identityService;
	}

	public void setIdentityService(IdentityService identityService) {
		this.identityService = identityService;
	}

	public ManagementService getManagementService() {
		return managementService;
	}

	public void setManagementService(ManagementService managementService) {
		this.managementService = managementService;
	}

	public HistoryService getHistoryService() {
		return historyService;
	}

	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}

	/**
	 * buildProcessEngine
	 */
	public void buildProcessEngine(){
		 ProcessEngineConfiguration processEngineConfiguration =
		 ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("activiti.cfg.xml");
		 ProcessEngine processEngine =processEngineConfiguration.buildProcessEngine();
		 System.out.println("ProcessEngine build 成功,表已创建！");
	}

}
