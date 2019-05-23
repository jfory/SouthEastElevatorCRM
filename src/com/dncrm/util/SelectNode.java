package com.dncrm.util;

import java.util.ArrayList;
import java.util.List;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.selectByRole.SelectByRoleService;

public class SelectNode{
		
	private	SelectByRoleService selectByRoleService = SpringContextHolder.getBean("selectByRoleService");
	private DepartmentService departmentService = SpringContextHolder.getBean("departmentService");
	private List<PageData> parentDepartments = new ArrayList<PageData>();
	private List<PageData> childDepartments = new ArrayList<PageData>();
	public static void main(String args[]){
		
	}
	
	/**
	 *根据用户id和需要查找的节点类型返回节点
	 * 1 :  总部
	 * 2 :  部门
	 * 3 :  工厂
	 * 4 :  战略联盟
	 * 5 :  海外
	 * 6 :  特种
	 * 7 :  工厂子级
	 * 8 :  区域
	 * 9 :  职位
	 * 10:  分子公司
	 */
	public PageData findNode(String user_id,String type)throws Exception{
		PageData pd = new PageData();
		//根据用户id查询到职位节点
		PageData userPosition = selectByRoleService.findPositionByUser(user_id);
		//查找职位节点的所有父级节点
		List<PageData> parentNodes = getAllParentDepartments(userPosition);
		//从所有父级节点中过滤指定节点
		List<PageData> theNodes = getNodesByType(parentNodes, type);
		if(theNodes.size()>0){
			pd = theNodes.get(0);	
		}
		clearNode();
		return pd;
	}
	
	
	/**
	 *清空 
	 */
	private void clearNode(){
		parentDepartments.clear();
		childDepartments.clear();
	}
	
	//--------------------------------------------
	/**
     *递归获取所有父节点 
     */
    private List<PageData> getAllParentDepartments(PageData pd)throws Exception{
    	PageData parentPd =  departmentService.findAllParentDepartments(pd);
    	if(parentPd!=null){
    		parentDepartments.add(parentPd);
    		getAllParentDepartments(parentPd);
    	}
    	return parentDepartments;
    }
    
    /**
     *递归获取所有子节点 
     */
    private List<PageData> getAllChildDepartments(PageData pd)throws Exception{
    	List<PageData> childPdList = departmentService.findAllChildDepartments(pd);
    	if(childPdList!=null){
    		for(PageData childPd : childPdList){
        		childDepartments.add(childPd);
        		getAllChildDepartments(childPd);
    		}
    	}
    	return childDepartments;
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
	
}
