package com.dncrm.service.system.models;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("modelsService")
public class ModelsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 型号列表分页
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageModels(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ModelsMapper.modelslistPage", page);
	}
	
	/**
	 * 根据ID查找型号对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findModelsById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ModelsMapper.findModelsById", pd);
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
	 * 批量删除型号
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void modelsDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ModelsMapper.modelsDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 *扶梯型号导入 
	 */
	public void saveEscalatorModels(PageData pd)throws Exception{
		dao.save("ModelsMapper.saveEscalatorModels", pd);
	}
	
	/**
	 *查询扶梯型号 
	 */
	public List<PageData> findEscalatorModels()throws Exception{
		return (List<PageData>)dao.findForList("ModelsMapper.findEscalatorModels", "");
	}
	
	/**
	 *查询常规梯型号 
	 */
	public List<PageData> findRegelevModels()throws Exception{
		return (List<PageData>)dao.findForList("ModelsMapper.findRegelevModels", "");
	}
	
	/**
	 *查询家用梯型号 
	 */
	public List<PageData> findHomeelevModels()throws Exception{
		return (List<PageData>)dao.findForList("ModelsMapper.findHomeelevModels", "");
	}
	
	/**
	 *查询家用梯型号 
	 */
	public List<PageData> findModelsNameList()throws Exception{
		return (List<PageData>)dao.findForList("ModelsMapper.findModelsNameList", "");
	}
	
}
