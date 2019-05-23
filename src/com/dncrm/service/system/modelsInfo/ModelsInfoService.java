package com.dncrm.service.system.modelsInfo;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("modelsInfoService")
public class ModelsInfoService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 型号信息列表分页
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageModelsInfo(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ModelsInfoMapper.modelsInfolistPage", page);
	}
	
	/**
	 * 根据ID查找型号信息对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findModelsInfoById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ModelsInfoMapper.findModelsInfoById", pd);
	}
	
	/**
	 * 根据类型查找型号信息列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findModelsInfoByTypeList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ModelsInfoMapper.findModelsInfoByTypeList", pd);
	}
	
	/**
	 * 型号信息添加
	 * @param pd
	 * @throws Exception
	 */
	public void modelsInfoAdd(PageData pd) throws Exception{
		dao.save("ModelsInfoMapper.modelsInfoAdd", pd);
	}
	
	/**
	 * 型号信息编辑
	 * @param pd
	 * @throws Exception
	 */
	public void modelsInfoUpdate(PageData pd) throws Exception{
		dao.update("ModelsInfoMapper.modelsInfoUpdate", pd);
	}
	
	/**
	 * 型号信息删除
	 * @param pd
	 * @throws Exception
	 */
	public void modelsInfoDelete(PageData pd) throws Exception{
		dao.delete("ModelsInfoMapper.modelsInfoDelete", pd);
	}
	
	/**
	 * 批量删除型号信息
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void modelsInfoDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ModelsInfoMapper.modelsInfoDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 根据ID查找非标中心对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findNonstandardCentreById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ModelsInfoMapper.findNonstandardCentreById", pd);
	}
	
	/**
	 * 根据ID查找非标中心集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findNonstandardCentreListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ModelsInfoMapper.findNonstandardCentreListById", pd);
	}
	
	/**
	 * 电梯非标中心申请添加
	 * @param pd
	 * @throws Exception
	 */
	public void nonstandardCentreAdd(PageData pd) throws Exception{
		dao.save("ModelsInfoMapper.nonstandardCentreAdd", pd);
	}
	
	/**
	 * 电梯非标中心申请更新
	 * @param pd
	 * @throws Exception
	 */
	public void nonstandardCentreUpadate(PageData pd) throws Exception{
		dao.update("ModelsInfoMapper.nonstandardCentreUpdate", pd);
	}
	
	/**
	 * 电梯非标中心申请删除
	 * @param pd
	 * @throws Exception
	 */
	public void nonstandardCentreDelete(PageData pd) throws Exception{
		dao.delete("ModelsInfoMapper.nonstandardCentreDelete", pd);
	}
	
	/**
	 * 根据ID查找电梯审核表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorAuditById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ModelsInfoMapper.findElevatorAuditById", pd);
	}
	
	/**
	 * 根据ID查询所有内容  (非标审核处理页面)
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorAuditHandleAllById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ModelsInfoMapper.findElevatorAuditHandleAllById", pd);
	}
	
	/**
	 * 电梯审核表添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorAuditAdd(PageData pd) throws Exception{
		dao.save("ModelsInfoMapper.elevatorAuditAdd", pd);
	}
	
	/**
	 * 电梯审核表状态更新
	 * @param pd
	 * @throws Exception
	 */
	public void updateElevatorApproval(PageData pd) throws Exception{
		dao.update("ModelsInfoMapper.updateElevatorApproval", pd);
	}
	
	/**
	 * 工厂配置之后修改非标项json 
	 */
	public void updateNonstandardJson(PageData pd)throws Exception{
		dao.update("ModelsInfoMapper.updateNonstandardJson", pd);
	}
	
	/**
	 *工厂配置时查询非标json 
	 */
	public String findNonstandardJson(String centre_id)throws Exception{
		return (String) dao.findForObject("ModelsInfoMapper.findNonstandardJson", centre_id);
	}
	
	/**
	 *根据id查询非标项json 
	 */
	public String findNonstandardJsonById(String models_id)throws Exception{
		return (String) dao.findForObject("ModelsInfoMapper.findNonstandardJsonById", models_id);
	}
}
