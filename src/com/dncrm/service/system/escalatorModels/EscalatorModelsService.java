package com.dncrm.service.system.escalatorModels;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("escalatorModelsService")
public class EscalatorModelsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 型号列表分页
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageEscalatorModels(Page page) throws Exception{
		return (List<PageData>) dao.findForList("EscalatorModelsMapper.escalatorModelslistPage", page);
	}
	
	/**
	 * 根据ID查找型号对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findModelsById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("EscalatorModelsMapper.findModelsById", pd);
	}
	
	/**
	 * 根据类型查找型号列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findModelsByTypeList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ModelsMapper.findModelsByTypeList", pd);
	}
	
	/**
	 *根据电梯种类查询产品列表 
	 */
	public List<PageData> findProductListById(String elevator_type)throws Exception{
		return (List<PageData>)dao.findForList("EscalatorModelsMapper.findProductListById", elevator_type);
	}
	
	/**
	 * 根据电梯类型ID查找型号列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findModelsByElevatorIdList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ModelsMapper.findModelsByElevatorIdList", pd);
	}
	
	/**
	 * 型号添加
	 * @param pd
	 * @throws Exception
	 */
	public void modelsAdd(PageData pd) throws Exception{
		dao.save("ModelsMapper.modelsAdd", pd);
	}
	
	/**
	 *保存型号新增(新版扶梯) 
	 */
	public void configAdd(PageData pd)throws Exception{
		dao.save("EscalatorModelsMapper.configAdd", pd);
	}
	
	/**
	 *保存型号编辑 
	 */
	public void configUpdate(PageData pd)throws Exception{
		dao.update("EscalatorModelsMapper.configUpdate", pd);
	}
	
	/**
	 * 型号编辑
	 * @param pd
	 * @throws Exception
	 */
	public void modelsUpdate(PageData pd) throws Exception{
		dao.update("ModelsMapper.modelsUpdate", pd);
	}
	
	/**
	 * 型号删除
	 * @param pd
	 * @throws Exception
	 */
	public void modelsDelete(PageData pd) throws Exception{
		dao.delete("ModelsMapper.modelsDelete", pd);
	}
	
	/**
	 * 型号删除,扶梯新版
	 * @param pd
	 * @throws Exception
	 */
	public void configDelete(PageData pd) throws Exception{
		dao.delete("EscalatorModelsMapper.configDelete", pd);
	}
	
	/**
	 * 批量删除型号
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void modelsDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ModelsMapper.modelsDeleteAll", ArrayDATA_IDS);
	}
	
	
	/**
	 *查询扶梯标准ID 
	 */
	public PageData findEscalatorStandardId(PageData pd)throws Exception{
		return (PageData) dao.findForObject("EscalatorModelsMapper.findEscalatorStandardId", pd);
	}
	
	
	/**
	 *保存扶梯标准返回id 
	 */
	public void saveEscalatorStandard(PageData pd)throws Exception{
		dao.save("EscalatorModelsMapper.saveEscalatorStandard", pd);
	}
	
	/**
	 *查询扶梯标准 
	 */
	public PageData findEscalatorStandard(String id)throws Exception{
		return (PageData) dao.findForObject("EscalatorModelsMapper.findEscalatorStandard", id);
	}
}
