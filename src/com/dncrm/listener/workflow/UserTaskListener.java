package com.dncrm.listener.workflow;

/**
 * Created by Simon on 16/7/28.
 */

import com.dncrm.dao.DaoSupport;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.service.system.workflow.TaskAssignService;
import com.dncrm.util.Logger;
import com.dncrm.util.PageData;
import com.dncrm.util.SpringContextHolder;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.context.ApplicationContext;

import java.util.ArrayList;
import java.util.List;

/**
 * 请假任务监听器
 *
 * @author Simon
 * @create 2016-07-28 上午10:34
 **/
public class UserTaskListener implements TaskListener
{

    private ApplicationContext app;
    private DaoSupport dao = SpringContextHolder.getBean("daoSupport");
	private RoleService roleService = SpringContextHolder.getBean("roleService");
	private PositionService positionService = SpringContextHolder.getBean("positionService");
	private sysUserService sysUserService = SpringContextHolder.getBean("sysUserService");
	private DepartmentService departmentService = SpringContextHolder.getBean("departmentService");
	private List<PageData> parentDepartments = new ArrayList<PageData>();
	private List<PageData> childDepartments = new ArrayList<PageData>();

    @Override
    public void notify(DelegateTask delegateTask) {
    	System.out.println(dao);
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

        //根据task_def_key and processDefintionId查询对应的下一个任务的处理者所在的group
        PageData pd = new PageData();
        pd.put("task_def_key",task_def_key);
        pd.put("process_definition_id",process_definition_id);
        try {
            TaskAssignService taskAssignService = SpringContextHolder.getBean("taskAssignService");
            List <PageData> list = taskAssignService.getTaskAssignByKey(pd);
            if(list!=null&&list.size()>0){
            	List<String> userList = new ArrayList<String>();
            	List<String> userIdList = new ArrayList<String>();
                for (PageData taskAssign:list) {
                    String group_id = taskAssign.getString("group_id");
                	PageData paramPd = new PageData();
                    paramPd.put("ROLE_ID", group_id);
                	/*List<PageData> dataList = (List<PageData>)dao.findForList("RoleMapper.listAllUserByRid", paramPd);*/
                	List<PageData> dataList = roleService.listAllUserByRid(paramPd);
                    for(PageData forPd : dataList){
                    	userList.add(forPd.get("USER_ID").toString());
                    }
                }
            	/*PageData positionPd = (PageData)dao.findForObject("PositionMapper.findPositionByUserId", user_id);*/
            	PageData positionPd = positionService.findPositionByUserId(user_id);
            	List<PageData> nodeList = getAllParentDepartments(positionPd);
            	/*nodeList = getNodesByType(nodeList, getTaskType(delegateTask.getTaskDefinitionKey()));*/
            	if(nodeList!=null&&nodeList.size()>0){
                	nodeList = getAllChildDepartments(nodeList.get(0));
                	nodeList = getNodesByType(nodeList, "9");
                	parentDepartments.clear();
                	childDepartments.clear();
                	List<String> positionIdList = new ArrayList<String>();
                	for(PageData forPd : nodeList){
                		positionIdList.add(forPd.get("id").toString());
                	}
                	/*userIdList = (List<String>)dao.findForList("UserMapper.getUserIdByPositionList", positionIdList);*/
                	userIdList = sysUserService.getUserIdByPositionList(positionIdList);
            	}
                userList.retainAll(userIdList);
                delegateTask.addCandidateUsers(userList);
                /*delegateTask.addCandidateGroup(group_id);*/
            }
        } catch (Exception e) {
            Logger logger = Logger.getLogger(this.getClass());
            logger.error(e.toString(), e);
        }

        System.out.println("task listener");
        System.out.println("delegateTask -->"+delegateTask);
    }
    
    
    /**
     *根据用户id返回所有的职位父级节点
     */
    public List<PageData> findAllParentNodeByPosition(String USER_ID){
    	try{
        	PageData positionPd = new PageData();
    		/*String POSITION_ID = sysUserService.findPositionIdByUserId(USER_ID);*/
        	/*String POSITION_ID = dao.findForObject("UserXMapper.findPositionIdByUserId", USER_ID).toString();*/
        	String POSITION_ID = sysUserService.findPositionIdByUserId(USER_ID).toString();
    		positionPd.put("id", POSITION_ID);
    		/*positionPd = (PageData)dao.findForObject("PositionMapper.getPositionById", positionPd);*/
    		positionPd = positionService.getPositionById(positionPd);
    		/*positionPd = positionService.getPositionById(positionPd);*/
    		parentDepartments = getAllParentDepartments(positionPd);
    	}catch(Exception e){
            Logger logger = Logger.getLogger(this.getClass());
            logger.error(e.toString(), e);
    	}
    	return parentDepartments;
    }
    
    /**
     *递归获取所有父节点 
     */
    public List<PageData> getAllParentDepartments(PageData pd)throws Exception{
    	/*PageData parentPd = departmentService.findAllParentDepartment(pd);*/
    	/*PageData parentPd =  (PageData)dao.findForObject("DepartmentMapper.findParentModels", pd);*/
    	PageData parentPd =  departmentService.findAllParentDepartments(pd);
    	if(parentPd!=null){
    		parentDepartments.add(parentPd);
    		getAllParentDepartments(parentPd);
    	}
    	return parentDepartments;
    }
    
    /**
     *过滤指定type的节点 
     */
    private List<PageData> getNodesByType(List<PageData> list,String type){
		List<PageData> dataList = new ArrayList<PageData>();
    	if(list!=null&&list.size()>0){
    		for(PageData pd : list){
    			if(type.equals(pd.get("type").toString())){
    				dataList.add(pd);
    			}
    		}
    	}
    	return dataList;
    }
    
    /**
     *根据节点设置过滤的用户范围 
     */
    private String getTaskType(String taskName){
    	String type = "";
    	if("areaTask".equals(taskName)){
    		type = "8";
    	}else if("managerTask".equals(taskName)){
    		type = "8";
    	}else if("branchTask".equals(taskName)){
    		type = "10";
    	}else if("areaEngineerTask".equals(taskName)){
    		type = "8";
    	}else if("headAreaTask".equals(taskName)){
    		type = "1";
    	}else if("factoryTask".equals(taskName)){
    		/*type = "3";*/
    		type="10";
    	}else if("companyTask".equals(taskName)){
    		type = "1";
    	}
    	return type;
    }
    
    
    /**
     *递归获取所有子节点 
     */
    private List<PageData> getAllChildDepartments(PageData pd)throws Exception{
    	/*List<PageData> childPdList = (List<PageData>)dao.findForList("DepartmentMapper.findAllChildDepartments", pd);*/
    	List<PageData> childPdList = departmentService.findAllChildDepartments(pd);
    	if(childPdList!=null){
    		for(PageData childPd : childPdList){
        		childDepartments.add(childPd);
        		getAllChildDepartments(childPd);
    		}
    	}
    	return childDepartments;
    }

}
