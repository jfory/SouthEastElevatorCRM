package com.dncrm.service.system.encasement;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("encasementService")
public class EncasementService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	/**
	 * 根据项目查询出货单列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageAllConsignee(Page page) throws Exception{
		return (List<PageData>) dao.findForList("EncasementMapper.listPageAllConsignee", page);
	}
	
	/**
	 * 根据项目查询电梯详情列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllElevatorDetails(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("EncasementMapper.listAllElevatorDetails", pd);
	}
	
	/**
	 * 根据电梯工号查询装箱列表
	 * @throws Exception 
	 */
	public List<PageData> listPageAllEncasement(Page page) throws Exception{
		return (List<PageData>) dao.findForList("EncasementMapper.listPageAllEncasement", page);
	}
	
	/**
	 * 根据电梯工号查询装箱对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findEncasementObjByElevatorNo(PageData pd) throws Exception{
		return (PageData) dao.findForObject("EncasementMapper.findEncasementObjByElevatorNo", pd);
	}
	
	/**
	 * 保存装箱
	 * @param pd
	 * @throws Exception
	 */
	public void saveEncasement(PageData pd) throws Exception{
		dao.save("EncasementMapper.saveEncasement", pd);
	}
	
	/**
	 * 修改装箱
	 * @param pd
	 * @throws Exception
	 */
	public void editEncasement(PageData pd) throws Exception{
		dao.update("EncasementMapper.editEncasement", pd);
	}
	
	/**
	 * 删除出货单
	 * @param pd
	 * @throws Exception
	 */
	public void delEncasement(PageData pd) throws Exception{
		dao.delete("EncasementMapper.delEncasement", pd);
	}
	
	/**
	 * 更新出货单状态
	 * @param pd
	 * @throws Exception 
	 */
	public void updateConsigneeState(PageData pd) throws Exception{
		dao.update("EncasementMapper.updateConsigneeState", pd);
	}
	
	
	/**
	 * 根据电梯编号查询电梯id
	 */
	public String findElevatorDetailsIdByNO(String no)throws Exception{
		return (String) dao.findForObject("EncasementMapper.findElevatorDetailsIdByNO", no);
	}
}
