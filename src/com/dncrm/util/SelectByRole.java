package com.dncrm.util;

import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.selectByRole.SelectByRoleService;
import net.sf.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SelectByRole{
		
	private	SelectByRoleService selectByRoleService = SpringContextHolder.getBean("selectByRoleService");
	private DepartmentService departmentService = SpringContextHolder.getBean("departmentService");
	private List<PageData> parentDepartments = new ArrayList<PageData>();
	private List<PageData> childDepartments = new ArrayList<PageData>();
	public static void main(String args[]){
		
	}
	
	/**
	 *根据用户id查询角色分级,多个角色返回最高分级
	 *1: 个人;	2:分子公司;	3:区域;	4:管理员;  5:小业主加盟商;  6:家用梯加盟商A; 7:家用梯加盟商B; 8:家用梯加盟商C; 9:家用梯加盟商D
	 */
	public String findRoleType(String user_id)throws Exception{
		if("1".equals(user_id)){
			return "4";	//如果是admin,返回管理员分级
		}else{
			List<String> roleIds = selectByRoleService.findUserRole(user_id);
			String type = selectByRoleService.findRoleType(roleIds);
			return type;
		}
	}
	
	/**
	 *根据传入用户的角色分级查询所在范围的用户集合 
	 */
	public List<String> findUserList(String user_id)throws Exception{
		List<String> userList = new ArrayList<String>();
		String type = findRoleType(user_id);
		if("1".equals(type)){
			userList.add(user_id);
		}else if("4".equals(type)){
			/*userList = selectByRoleService.findAllUser();*/
		}else if("2".equals(type)||"3".equals(type)){
			String theType = "2".equals(type)?"10":"8";	//如果是分子公司分级(2),过滤分子公司节点(10);区域分级(3),过滤区域节点(8)
			PageData userPosition = selectByRoleService.findPositionByUser(user_id);
			List<PageData> parentNodes = getAllParentDepartments(userPosition);
			List<PageData> theNodes = getNodesByType(parentNodes, theType);
			if(theNodes.size()>0&&"1".equals(userPosition.get("is_manager").toString())){
				PageData node = theNodes.get(0);	
				List<PageData> childNodes = getAllChildDepartments(node);
				List<PageData> positionNodes = getNodesByType(childNodes, "9");
				parentDepartments.clear();
				childDepartments.clear();
				List<String> positionIds = new ArrayList<String>();
	        	for(PageData forPd : positionNodes){
	        		positionIds.add(forPd.get("id").toString());
	        	}
	        	userList = selectByRoleService.findUserByPosition(positionIds);
			}else{
				userList.add(user_id);
			}
		}
		List<String> resultList = new ArrayList<String>();
		for(String userId : userList){
			resultList.add("'"+userId+"'");
		}
		return resultList;
	}
	
	/**
	 *获取家用梯加盟商当前级别可以操作的其他级别 
	 */
	public List<String> getSelectLevel(String roleType, String modelName)throws Exception{
		String lvStr = "";
		if(modelName.equals("HOUSE")){
			lvStr = Const.HOUSES_LEVEL;
		}else if(modelName.equals("ITEM")){
			lvStr = Const.ITEM_LEVEL;
		}
		return getLevelUser(lvStr, roleType);
	}
	
	/**
	 * 返回用户id集合
	 */
	public List<String> getLevelUser(String lvStr, String roleType)throws Exception{
		JSONObject jsonObj = JSONObject.fromObject(lvStr);
		String str = jsonObj.get(roleType).toString();
		List<String> list = Arrays.asList(str.split("-"));
		List<String> userList = selectByRoleService.findSalesmanByLv(list);
		
		List<String> resultList = new ArrayList<String>();
		for(String userId : userList){
			resultList.add("'"+userId+"'");
		}
		return resultList;
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

	public boolean findUserListQX(String user_id,String child_user_id)throws Exception{
		List<String> userList = new ArrayList<String>();
		String type = findRoleType(user_id);
		boolean rebo=false;

		PageData npd=new PageData();
		npd.put("user_id",user_id);
		npd.put("child_user_id",child_user_id);
        List<String> lst=selectByRoleService.getPostionUserList(npd);
        if(lst!=null&&lst.size()>0){
            rebo=true;
        }else {
            rebo=false;
        }
		return rebo;
	}
    public boolean findUserListQX2(String user_id,String child_user_id)throws Exception{
        List<String> userList = new ArrayList<String>();
        String type = findRoleType(user_id);
        boolean rebo=false;

        PageData npd=new PageData();
        npd.put("user_id",user_id);
        npd.put("child_user_id",child_user_id);
        List<String> lst=selectByRoleService.getPostionUserList(npd);
        if("1".equals(type)){
            rebo=false;
        }else if("4".equals(type)){
            rebo=true;
        }else if("2".equals(type)||"3".equals(type)){
            String theType = "2".equals(type)?"10":"8";	//如果是分子公司分级(2),过滤分子公司节点(10);区域分级(3),过滤区域节点(8)
            PageData userPosition = selectByRoleService.findPositionByUser(user_id);
            PageData childPostion=selectByRoleService.findPositionByUser(child_user_id);
            List<PageData> parentNodes = getAllParentDepartments(userPosition);
            List<PageData> theNodes = getNodesByType(parentNodes, theType);
            if(theNodes.size()>0){
                PageData node = theNodes.get(0);
                List<PageData> childNodes = getAllChildDepartments(node);
                List<PageData> positionNodes = getNodesByType(childNodes, "9");
                parentDepartments.clear();
                childDepartments.clear();
                List<String> positionIds = new ArrayList<String>();
                for(PageData forPd : positionNodes){
                    positionIds.add(forPd.get("id").toString());
                    if (forPd.get("id")!=null&&childPostion.get("id")!=null&&
                            forPd.getString("id").equals(childPostion.getString("id"))){
                        rebo=true;
                        break;
                    }
                }
            }else{
                if (userPosition!=null&&childPostion!=null&&userPosition.get("id")!=null&&childPostion.get("id")!=null&&
                        userPosition.getString("id").equals(childPostion.getString("id"))){
                    rebo=true;
                }
            }
        }
        return rebo;
    }
	
}
