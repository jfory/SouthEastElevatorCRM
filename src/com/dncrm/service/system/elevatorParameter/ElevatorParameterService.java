package com.dncrm.service.system.elevatorParameter;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("elevatorParameterService")
public class ElevatorParameterService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 电梯速度参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorSpeed(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.elevatorSpeedlistPage", page);
	}
	
	/**
	 * 电梯速度参数添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorSpeedAdd(PageData pd) throws Exception{
		dao.save("ElevatorParameterMapper.elevatorSpeedAdd", pd);
	}
	
	/**
	 * 电梯速度参数编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorSpeedEdit(PageData pd) throws Exception{
		dao.update("ElevatorParameterMapper.elevatorSpeedUpdate", pd);
	}
	
	/**
	 * 电梯速度参数名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorSpeedName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.existsElevatorSpeedName", pd);
	}
	
	/**
	 * 电梯速度参数删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorSpeedDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorParameterMapper.elevatorSpeedDeleteById", pd);
	}
	
	/**
	 * 根据ID查询速度参数对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorSpeedById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.findElevatorSpeedById", pd);
	}
	
	/**
	 * 根据ID查询速度参数集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorSpeedListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.findElevatorSpeedListById", pd);
	}
	
	/**
	 * 电梯重量参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorWeight(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.elevatorWeightlistPage", page);
	}
	
	/**
	 * 电梯重量参数添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorWeightAdd(PageData pd) throws Exception{
		dao.save("ElevatorParameterMapper.elevatorWeightAdd", pd);
	}
	
	/**
	 * 电梯重量参数编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorWeightEdit(PageData pd) throws Exception{
		dao.update("ElevatorParameterMapper.elevatorWeightUpdate", pd);
	}
	
	/**
	 * 电梯重量参数名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorWeightName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.existsElevatorWeightName", pd);
	}
	
	/**
	 * 电梯重量参数删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorWeightDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorParameterMapper.elevatorWeightDeleteById", pd);
	}
	
	/**
	 * 根据ID查询重量参数对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorWeightById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.findElevatorWeightById", pd);
	}
	
	/**
	 * 根据ID查询重量参数集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorWeightListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.findElevatorWeightListById", pd);
	}
	
	/**
	 * 电梯楼层参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorStorey(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.elevatorStoreylistPage", page);
	}
	
	
	/**
	 * 电梯楼层参数添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorStoreyAdd(PageData pd) throws Exception{
		dao.save("ElevatorParameterMapper.elevatorStoreyAdd", pd);
	}
	
	/**
	 * 电梯楼层参数编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorStoreyEdit(PageData pd) throws Exception{
		dao.update("ElevatorParameterMapper.elevatorStoreyUpdate", pd);
	}
	
	/**
	 * 电梯楼层参数名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorStoreyName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.existsElevatorStoreyName", pd);
	}
	
	/**
	 * 电梯楼层参数删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorStoreyDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorParameterMapper.elevatorStoreyDeleteById", pd);
	}
	
	/**
	 * 根据ID查询楼层参数对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorStoreyById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.findElevatorStoreyById", pd);
	}
	
	/**
	 * 根据ID查询楼层参数集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorStoreyListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.findElevatorStoreyListById", pd);
	}
	
	/**
	 * 电梯井道参数列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorHeight(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.elevatorHeightlistPage", page);
	}
	
	/**
	 * 电梯井道高度参数添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorHeightAdd(PageData pd) throws Exception{
		dao.save("ElevatorParameterMapper.elevatorHeightAdd", pd);
	}
	
	/**
	 * 电梯井道高度参数编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorHeightEdit(PageData pd) throws Exception{
		dao.update("ElevatorParameterMapper.elevatorHeightUpdate", pd);
	}
	
	/**
	 * 电梯井道高度参数删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorHeightDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorParameterMapper.elevatorHeightDeleteById", pd);
	}
	
	/**
	 * 根据ID查询井道高度参数对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorHeightById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.findElevatorHeightById", pd);
	}
	
	/**
	 * 根据ID查询井道高度参数集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorHeightListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorParameterMapper.findElevatorHeightListById", pd);
	}
	
	/**
	 * 根据电梯速度name获取速度信息
	 * @param pd
	 * @return PageData
	 * @throws Exception
	 * Stone 2017-06-30
	 */
	public PageData findSpeedByName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorParameterMapper.findSpeedByName", pd);
	}
}
