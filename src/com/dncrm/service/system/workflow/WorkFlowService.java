package com.dncrm.service.system.workflow;

import java.io.InputStream;
import java.util.List;
import java.util.zip.ZipInputStream;

import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.dncrm.common.WorkFlow;
import com.dncrm.entity.Page;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.PathUtil;

@Service("workFlowService")
public class WorkFlowService {

	// workflow
	public  WorkFlow workFlow = new WorkFlow();

	/**
	 * 部署一个新的流程(zip)
	 * 
	 * @param name
	 * @param bpmnPath
	 * @param pngPath
	 * @return deployment
	 */
	public Deployment deployActivitiWithZip(String name, MultipartFile file) {
		try {
			ZipInputStream zipInputStream = new ZipInputStream(file.getInputStream());
			Deployment deployment = workFlow.getRepositoryService().createDeployment().name(name)// 流程定义名称
					.addZipInputStream(zipInputStream)
					.deploy();
			return deployment;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 部署流程
	 * 
	 * @param name
	 * @param bpmnPath
	 * @param pngPath
	 * @return deployment
	 */
	public Deployment deployActivitiWithClassPath(String name, String bpmnPath, String pngPath) {
		try {
			Deployment deployment = workFlow.getRepositoryService().createDeployment().name(name)// 流程定义名称
					.addClasspathResource(bpmnPath)// bpmn文件路径
					.addClasspathResource(pngPath)// png文件路径
					.deploy();
			return deployment;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 部署流程 with InputStream
	 * 
	 * @param name
	 * @param bpmnPath
	 * @param pngPath
	 * @return deployment
	 */
	public Deployment deployActivitiWithInputStream(String name, String bpmnPath, String pngPath) {
		try {
			InputStream inputStreamBpmn = this.getClass().getResourceAsStream(bpmnPath);
			InputStream inputStreamPng = this.getClass().getResourceAsStream(pngPath);
			String bpmnName = bpmnPath.substring(bpmnPath.lastIndexOf("\\/"), bpmnPath.length());
			String pngName = pngPath.substring(pngPath.lastIndexOf("\\/"), pngPath.length());
			Deployment deployment = workFlow.getRepositoryService().createDeployment().name(name)// 流程定义名称
					.addInputStream(bpmnName, inputStreamBpmn)// 使用资源文件的名称（要求与资源文件的名称一致）
					.addInputStream(pngName, inputStreamPng)// 使用资源文件的名称（要求与资源文件的名称一致）
					.deploy();
			//把流程图片拷贝到图片目录
			
			String filePath = PathUtil.getClasspath() + Const.ACTIVITIFILEPATHIMG
                    +deployment.getId()+Const.ACTIVITIFILEPATHIMGEXT; // 文件上传路径:http://localhost:8080/DNCRM/uploadFiles/activitiDiagrams/87501/activiti/diagrams/helloworld.png
			FileUpload.copyFile(inputStreamPng, filePath, pngName.substring(0,pngName.lastIndexOf("\\.")) + pngName.substring(pngName.lastIndexOf("\\."),pngName.length()));
			return deployment;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 启动流程 with processDefinitionKey
	 * 
	 * @param processDefinitionKey
	 * @return processInstance
	 */
	public ProcessInstance startProcessInstanceWithPDKey(String processDefinitionKey) {
		try {
			ProcessInstance processInstance = workFlow.getRuntimeService()
					.startProcessInstanceByKey(processDefinitionKey);
			return processInstance;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 启动流程 with deploymentId
	 * 
	 * @param deploymentId
	 * @return processInstance
	 */
	public ProcessInstance startProcessInstanceWithDeploymentId(String deploymentId) {
		try {
			//先通过deploymentid获取 processdefinition
			ProcessDefinition processDefinition = workFlow.getRepositoryService().createProcessDefinitionQuery().deploymentId(deploymentId).singleResult();
			//通过processdefinitionid启动流程实例
			ProcessInstance processInstance = workFlow.getRuntimeService()
					.startProcessInstanceById(processDefinition.getId());
			return processInstance;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 查询个人任务 with assignee
	 * 
	 * @param assignee
	 * @return List<Task>
	 */
	public List<Task> findPersonalTaskWithAssignee(String assignee) {
		try {
			List<Task> tasks = workFlow.taskService.createTaskQuery().taskAssignee(assignee).list();
			return tasks;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 查询个人任务 with candidateUser
	 * 
	 * @param candidateUser
	 * @return List<Task>
	 */
	public List<Task> findPersonalTaskWithCandidateUser(String candidateUser) {
		try {
			List<Task> tasks = workFlow.taskService.createTaskQuery().taskCandidateUser(candidateUser).list();
			return tasks;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 查询工作流列表
	 * 
	 * @param page
	 * @return List<ProcessDefinition>
	 */     
	public List<ProcessDefinition> listProcessDefinitions(Page page) {
		try {
			List<ProcessDefinition> processDefinitions;
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
			//搜索参数
			String name = (String)page.getPd().get("name");
			if (!StringUtils.isEmpty(name)) {
				name="%"+name+"%";
			}else{
				name= "%%";
			}
			String key = (String)page.getPd().get("key");
			if (!StringUtils.isEmpty(key)) {
				key="%"+key+"%";
			}else{
				key= "%%";
			}
			//模糊查询
			processDefinitions = workFlow.getRepositoryService().createProcessDefinitionQuery().processDefinitionNameLike(name).processDefinitionKeyLike(key).
					orderByProcessDefinitionName().asc().orderByProcessDefinitionVersion().desc()//排序:名称升序，版本降序
					.listPage(firstResult, maxResults);
			//设置分页数据
			if (processDefinitions!=null&&processDefinitions.size()>0) {
				int totalResult = (int)workFlow.getRepositoryService().createProcessDefinitionQuery().processDefinitionNameLike(name).processDefinitionKeyLike(key).count();
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
				page.setCurrentResult(processDefinitions.size());
				page.setCurrentPage(currentPage);
				page.setShowCount(showCount);
				page.setEntityOrField(true);
				page.setPageStrForActiviti(page.getPageStrForActiviti());
			}
			
			return processDefinitions;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 查询部署列表
	 * 
	 * @param page
	 * @return List<Deployment>
	 */     
	public List<Deployment> listDeployment(Page page) {
		try {
			List<Deployment> deployments;
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
			//搜索参数
			String name = (String)page.getPd().get("name");
			if (!StringUtils.isEmpty(name)) {
				name="%"+name+"%";
			}else{
				name= "%%";
			}
			String key = (String)page.getPd().get("key");
			if (!StringUtils.isEmpty(key)) {
				key="%"+key+"%";
			}else{
				key= "%%";
			}
			//模糊查询
			deployments = workFlow.getRepositoryService().createDeploymentQuery()
					.deploymentNameLike(name).processDefinitionKeyLike(key)//名称，key模糊查询
					.orderByDeploymentName().asc().orderByDeploymenTime().desc()//排序: 名称升序，部署时间降序
					.listPage(firstResult, maxResults);
			//设置分页数据
			if (deployments!=null&&deployments.size()>0) {
				int totalResult = (int) workFlow.getRepositoryService().createDeploymentQuery().deploymentNameLike(name).processDefinitionKeyLike(key).count();
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
				page.setCurrentResult(deployments.size());
				page.setCurrentPage(currentPage);
				page.setShowCount(showCount);
				page.setEntityOrField(true);
				page.setPageStrForActiviti(page.getPageStrForActiviti());
			}
			
			return deployments;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 查询流程实例列表
	 * 
	 * @param page
	 * @return List<ProcessDefinition>
	 */     
	public List<ProcessInstance> listProcessInstance(Page page) {
		try {
			List<ProcessInstance> processInstances;
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
			//搜索参数
			String name = (String)page.getPd().get("name");
			if (!StringUtils.isEmpty(name)) {
				name="%"+name+"%";
			}else{
				name= "%%";
			}
			//模糊查询
			processInstances = workFlow.getRuntimeService().createProcessInstanceQuery()
					.listPage(firstResult, maxResults);
			//设置分页数据
			if (processInstances!=null&&processInstances.size()>0) {
				int totalResult = (int)workFlow.getRuntimeService().createProcessInstanceQuery().count();
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
				page.setCurrentResult(processInstances.size());
				page.setCurrentPage(currentPage);
				page.setShowCount(showCount);
				page.setEntityOrField(true);
				page.setPageStrForActiviti(page.getPageStrForActiviti());
			}
			
			return processInstances;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 删除一个已部署流程
	 * 
	 * @param candidateUser
	 * @return List<Task>
	 */
	public boolean deleteDeploymentById(String deploymentId) {
		try {
			  workFlow.getRepositoryService().deleteDeployment(deploymentId, true);//删除已部署流程，级联删除已经启动的流程实例
			  return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


}
