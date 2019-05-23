package com.dncrm.service.system.elevatorInfo;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("elevatorInfoService")
public class ElevatorInfoService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	
	/**
	 * 电梯详情列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> elevatorDetailsList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorInfoMapper.elevatorDetailsList", pd);
	}
	
	
	/**
	 * 电梯详情添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorInfoAdd(PageData pd) throws Exception{
		dao.save("ElevatorInfoMapper.elevatorInfoAdd", pd);
	}
	
	/**
	 * 电梯详情编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorInfoEdit(PageData pd) throws Exception{
		dao.update("ElevatorInfoMapper.elevatorInfoUpdate", pd);
	}
	
	/**
	 * 型号保存后更新电梯详情
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorDetailsToModelsUpdate(PageData pd) throws Exception{
		dao.update("ElevatorInfoMapper.elevatorDetailsToModelsUpdate", pd);
	}
	
	/**
	 * 电梯详情删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorInfoDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorInfoMapper.elevatorInfoDeleteById", pd);
	}
	
	/**
	 * 批量删除电梯详情
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void elevatorInfoDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ElevatorInfoMapper.elevatorInfoDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 根据ID查询电梯详情对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorInfoById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorInfoMapper.findElevatorInfoById", pd);
	}
	
	/**
	 * 根据主键查询电梯详情对象
	 * @param pd
	 * @return
	 * @throws Exception 
	 */
	public PageData findElevatorInfoId(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorInfoMapper.findElevatorInfoId", pd);
	}
	
	/**
	 * 根据ID查询电梯详情集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorDetailsListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorInfoMapper.findElevatorDetailsListById", pd);
	}
	
	/**
	 * 根据ID查询电梯详情INFO集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorInfoListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorInfoMapper.findElevatorInfoListById", pd);
	}
	
	/**
	 * 根据主键ID删除电梯详情
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorInfoDeleteByPid(PageData pd) throws Exception{
		dao.delete("ElevatorInfoMapper.elevatorInfoDeleteByPid", pd);
	}
	
	/**
	 *根据项目id查询详情和电梯关联信息
	 *@param String
	 *@throws Exception 
	 */
	public List<PageData> findElevatorInfoListByItemId(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("ElevatorInfoMapper.findElevatorInfoListByItemId", item_id);
	}
	
	/**
	 *根据id查询total 
	 */
	public String findTotalById(String id)throws Exception{
		return (String)dao.findForObject("ElevatorInfoMapper.findTotalById", id);
	}
	
	/**
	 *根据电梯id修改flag 标记标准和非标型号类型 
	 */
	public void updateElevatorInfoFlag(String details_id)throws Exception{
		dao.update("ElevatorInfoMapper.updateElevatorInfoFlag", details_id);
	}
	
	/**
	 *根据电梯id修改flag 标记非非标类型 
	 */
	public void resetElevatorInfoFlag(String details_id)throws Exception{
		dao.update("ElevatorInfoMapper.resetElevatorInfoFlag", details_id);
	}
	
	/**
	 *根据项目id删除 
	 */
	public void deleteElevatorInfoByItemId(String item_id)throws Exception{
		dao.delete("ElevatorInfoMapper.deleteElevatorInfoByItemId", item_id);
	}
}
