package com.dncrm.service.system.workflow;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;
import net.sf.json.JSONArray;
import org.activiti.engine.task.IdentityLink;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The type Task Assign service.
 */
@Service("taskAssignService")
public class TaskAssignService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * get  taskAssign by key.
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getTaskAssignByKey(PageData pd) throws Exception {

		return (List<PageData>) dao.findForList("TaskAssignMapper.getTaskAssignByKey", pd);
	}
	/**
	 * 根据流程定义id及任务id查询角色权限。
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getTaskAssignByRole(PageData pd) throws Exception {

		return (List<PageData>) dao.findForList("TaskAssignMapper.getTaskAssignByRole", pd);
	}
	
	/**
	 * 根据电梯id查询角色权限。
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getContractTechTaskAssignByRole(PageData pd) throws Exception {

		return (List<PageData>) dao.findForList("TaskAssignMapper.getContractTechTaskAssignByRole", pd);
	}
	
	/**
	 * 更新电梯角色权限。
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public void updateContractTechTaskAssignByRole(PageData pd) throws Exception {

		dao.update("TaskAssignMapper.updateContractTechTaskAssignByRole", pd);
	}

	/**
	 * 保存数据
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public void save(PageData pd) throws Exception {

		dao.save("TaskAssignMapper.save", pd);
	}

	/**
	 * 删除数据
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public void del(PageData pd) throws Exception {

		 dao.delete("TaskAssignMapper.delete", pd);
	}
	/**
	 * get  userinfo by key.
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getUserInfoByGroupId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("TaskAssignMapper.getUserInfoByGroupId", pd);
	}

	public List<PageData> findUsersByRoleIds(List<PageData> list)throws Exception{
		List<PageData> relist=new ArrayList<PageData>();
		for(PageData pd:list){
			relist.addAll((List<PageData>)dao.findForList("TaskAssignMapper.findUsersByRoleIds", pd));
		}
		return relist;
	}

	public List<PageData> findUsersByRoleIds(PageData pd)throws Exception{
		List<PageData> relist=new ArrayList<PageData>();
		relist.addAll((List<PageData>)dao.findForList("TaskAssignMapper.findUsersByRoleIds", pd));
		return relist;
	}
	public List<String> findAllTechAuditGroup(Map<String,Object> pd) throws Exception {
		return (List<String>) dao.findForList("TaskAssignMapper.findAllTechAuditGroup", pd);
	}

	public String getTaskAuditUser(List<IdentityLink> lo,String user_id) throws Exception{
		SelectByRole sbr = new SelectByRole();
		List<Map<String,String>> relist=new ArrayList<>();
		PageData pd=new PageData();
		List<PageData> ulist=new ArrayList<PageData>();
		if(lo!=null&&lo.size()>0){
			for (IdentityLink idl:lo){
				pd.clear();
				pd.put("group_id",idl.getGroupId());
				ulist.addAll((List<PageData>)dao.findForList("TaskAssignMapper.findUsersByRoleIds", pd));
			}
		}else {
			pd.clear();
			pd.put("user_id",user_id);
			ulist.addAll((List<PageData>)dao.findForList("TaskAssignMapper.findUsersByRoleIds", pd));
		}

		if (ulist!=null&&ulist.size()>0){
			Map<String,Integer> usermap=new HashMap<>();
			for (PageData uspd:ulist){
				boolean re = sbr.findUserListQX(uspd.getString("USER_ID"),user_id);
				if(re){
					if(usermap.get(uspd.getString("USER_ID"))!=null){
						relist.get(usermap.get(uspd.getString("USER_ID"))).put("role_name",
								relist.get(usermap.get(uspd.getString("USER_ID"))).get("role_name")+","+uspd.getString("role_name"));
						continue;
					}else {
						usermap.put(uspd.getString("USER_ID"),relist.size());
					}
					Map<String,String>umap=new HashMap<>();
					umap.put("user_id",uspd.getString("USER_ID"));
					umap.put("user_name",uspd.getString("NAME"));
					umap.put("role_name",uspd.getString("role_name"));
					umap.put("email",uspd.getString("EMAIL"));
					umap.put("phone",uspd.getString("PHONE"));
					relist.add(umap);
				}
			}
		}
		return JSONArray.fromObject(relist).toString();
	}

	/**
	 * 检查当前审核角色是否与上一角色一致，如果是就自动跳过完成
	 * @return
	 */
	public boolean checkTaskAuditUser(PageData usepd,List<PageData> grouplist) throws Exception{
		List<PageData>uselist= (List<PageData>)dao.findForList("TaskAssignMapper.findUsersByRoleIds", usepd);
		if(uselist!=null&&uselist.size()>0&&grouplist!=null&&grouplist.size()>0){
			for (PageData upd:uselist){
				for (PageData gpd:grouplist){
					if (upd.getString("group_id").equals(gpd.getString("group_id"))){
						return true;
					}
				}
			}
		}
		return false;
	}
}
