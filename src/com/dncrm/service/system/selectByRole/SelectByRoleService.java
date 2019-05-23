package com.dncrm.service.system.selectByRole;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service("selectByRoleService")
public class SelectByRoleService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	/**
	 *查询用户的角色id组
	 */
	public List<String> findUserRole(String user_id)throws Exception{
		List<String> resultList = new ArrayList<String>();
		String role_id = (String)dao.findForObject("selectByRoleMapper.findUserRole", user_id);
		if(role_id!=null){
			if(role_id.contains(",")){
				resultList = Arrays.asList(role_id.split(","));
			}else if(!"".equals(role_id)){
				resultList.add(role_id);
			}
		}
		return resultList;
	}
	
	/**
	 *查询角色id组的最高分级 
	 */
	public String findRoleType(List<String> roleIds)throws Exception{
		String type = "";
		type = (String)dao.findForObject("selectByRoleMapper.findRoleType", roleIds);
		return type;
	}
	
	/**
	 *查询所有用户id 
	 */
	public List<String> findAllUser()throws Exception{
		return (List<String>) dao.findForList("selectByRoleMapper.findAllUser", "");
	}
	
	/**
	 *根据用户id查询职位 
	 */
	public PageData findPositionByUser(String user_id)throws Exception{
		return (PageData) dao.findForObject("selectByRoleMapper.findPositionByUser", user_id);
	}
	
	/**
	 *根据职位id查询所有用户 
	 */
	public List<String> findUserByPosition(List<String> positionIds)throws Exception{
		return (List<String>) dao.findForList("selectByRoleMapper.findUserByPosition", positionIds);
	}
	
	/**
	 *根据家用梯加盟商级别查询销售id 
	 */
	public List<String> findSalesmanByLv(List<String> list)throws Exception{
		return (List<String>) dao.findForList("selectByRoleMapper.findSalesmanByLv", list);
	}

	public  List<String> getPostionUserList(PageData pd) throws Exception {
		return ( List<String>) dao.findForList("selectByRoleMapper.getPostionUserList", pd);
	}
}
