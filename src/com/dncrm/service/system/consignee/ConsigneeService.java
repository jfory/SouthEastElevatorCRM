package com.dncrm.service.system.consignee;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("consigneeService")
public class ConsigneeService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	/**
	 *根据登录人角色分级查询项目列表 
	 */
	public List<PageData> listPageAllItemByRole(Page page)throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.listPageAllItemByRole", page);
	}
	
	/**
	 * 根据状态查询项目列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageAllItem(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.listPageAllItem", page);
	}
	
	/**
	 * @throws Exception 
	 * 根据项目ID查询二排电梯详情列表
	 */
	public List<PageData> findElevatorDetailsListByItemId(List list) throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.findElevatorDetailsListByItemId", list);
	}
	
	/**
	 * @throws Exception 
	 * 根据项目ID查询二排电梯详情列表(编辑版)
	 */
	public List<PageData> findElevatorDetailsListByItemIds(List list) throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.findElevatorDetailsListByItemIds", list);
	}
	/**
	 * 根据项目查询出货单列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageAllConsignee(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.listPageAllConsignee", page);
	}
	
	/**
	 * 根据项目ID查询所有选中的电梯列表
	 * @param pd
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> findElevatorDetailsListCheckedByItemId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.findElevatorDetailsListCheckedByItemId", pd);
	}
	
	/**
	 * 根据主键ID查询出货单对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findConsigneeObjById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ConsigneeMapper.findConsigneeObjById", pd);
	}
	
	/**
	 * 保存出货单
	 * @param pd
	 * @throws Exception
	 */
	public void saveConsignee(PageData pd) throws Exception{
		dao.save("ConsigneeMapper.saveConsignee", pd);
	}
	
	/**
	 * 修改出货单
	 * @param pd
	 * @throws Exception
	 */
	public void editConsignee(PageData pd) throws Exception{
		dao.update("ConsigneeMapper.editConsignee", pd);
	}
	
	/**
	 * 删除出货单
	 * @param pd
	 * @throws Exception
	 */
	public void delConsignee(PageData pd) throws Exception{
		dao.delete("ConsigneeMapper.delConsignee", pd);
	}
	
	/**
	 * 更新出货单状态
	 * @param pd
	 * @throws Exception 
	 */
	public void updateConsigneeState(PageData pd) throws Exception{
		dao.update("ConsigneeMapper.updateConsigneeState", pd);
	}
	
	
	/**
	 *查询此项目已出货的电梯id集合
	 */
	public String findEditElevatorIds(PageData pd)throws Exception{
		return (String) dao.findForObject("ConsigneeMapper.findEditElevatorIds", pd);
	}
	
	/**
	 *查询编辑时电梯列表 
	 */
	public List<PageData> findElevatorDetailsListForEdit(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("ConsigneeMapper.findElevatorDetailsListForEdit", pd);
	}
}
