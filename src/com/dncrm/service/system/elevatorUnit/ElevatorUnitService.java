package com.dncrm.service.system.elevatorUnit;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("elevatorUnitService")
public class ElevatorUnitService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	
	/**
	 * 单元列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorUnit(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorUnitMapper.elevatorUnitlistPage", page);
	}
	
	
	/**
	 * 单元添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorUnitAdd(PageData pd) throws Exception{
		dao.save("ElevatorUnitMapper.elevatorUnitAdd", pd);
	}
	
	/**
	 * 单元编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorUnitEdit(PageData pd) throws Exception{
		dao.update("ElevatorUnitMapper.elevatorUnitUpdate", pd);
	}
	
	/**
	 * 单元名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorUnitName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorUnitMapper.existsElevatorUnitName", pd);
	}
	
	/**
	 * 单元删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorUnitDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorUnitMapper.elevatorUnitDeleteById", pd);
	}
	
	/**
	 * 批量删除单元
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void elevatorUnitDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ElevatorUnitMapper.elevatorUnitDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 根据ID查询单元对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorUnitById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorUnitMapper.findElevatorUnitById", pd);
	}
	
	/**
	 * 根据ID查询单元集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorUnitListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorUnitMapper.findElevatorUnitListById", pd);
	}
}
