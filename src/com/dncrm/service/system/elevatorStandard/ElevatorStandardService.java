package com.dncrm.service.system.elevatorStandard;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("elevatorStandardService")
public class ElevatorStandardService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	
	/**
	 * 电梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorStandard(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorStandardMapper.elevatorStandardlistPage", page);
	}
	
	
	/**
	 * 电梯标准价格添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorStandardAdd(PageData pd) throws Exception{
		dao.save("ElevatorStandardMapper.elevatorStandardAdd", pd);
	}
	
	/**
	 * 电梯标准价格编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorStandardEdit(PageData pd) throws Exception{
		dao.update("ElevatorStandardMapper.elevatorStandardUpdate", pd);
	}
	
	/**
	 * 电梯标准价格名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorStandardName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorStandardMapper.existsElevatorStandardName", pd);
	}
	
	/**
	 * 电梯标准价格删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorStandardDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorStandardMapper.elevatorStandardDeleteById", pd);
	}
	
	/**
	 * 批量删除电梯标准价格
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void elevatorStandardDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ElevatorStandardMapper.elevatorStandardDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 根据ID查询标准价格对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorStandardById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorStandardMapper.findElevatorStandardById", pd);
	}
	
	/**
	 * 根据ID查询标准价格集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorStandardListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorStandardMapper.findElevatorStandardListById", pd);
	}
	
	/**
	 * 计算电梯标准价格
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData countStandardPrice(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorStandardMapper.countStandardPrice", pd);
	}
}
