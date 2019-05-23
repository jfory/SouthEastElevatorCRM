package com.dncrm.service.system.escalatorStandard;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("escalatorStandardService")
public class EscalatorStandardService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	
	/**
	 * 扶梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageEscalatorStandard(Page page) throws Exception{
		return (List<PageData>) dao.findForList("EscalatorStandardMapper.escalatorStandardlistPage", page);
	}
	
	
	/**
	 * 扶梯标准价格添加
	 * @param pd
	 * @throws Exception
	 */
	public void escalatorStandardAdd(PageData pd) throws Exception{
		dao.save("EscalatorStandardMapper.escalatorStandardAdd", pd);
	}
	
	/**
	 * 扶梯标准价格编辑
	 * @param pd
	 * @throws Exception
	 */
	public void escalatorStandardEdit(PageData pd) throws Exception{
		dao.update("EscalatorStandardMapper.escalatorStandardUpdate", pd);
	}
	
	/**
	 * 扶梯标准价格名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsEscalatorStandardName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("EscalatorStandardMapper.existsEscalatorStandardName", pd);
	}
	
	/**
	 * 扶梯标准价格删除
	 * @param pd
	 * @throws Exception
	 */
	public void escalatorStandardDeleteById(PageData pd) throws Exception{
		dao.delete("EscalatorStandardMapper.escalatorStandardDeleteById", pd);
	}
	
	/**
	 * 批量删除扶梯标准价格
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void escalatorStandardDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("EscalatorStandardMapper.escalatorStandardDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 根据ID查询标准价格对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findEscalatorStandardById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("EscalatorStandardMapper.findEscalatorStandardById", pd);
	}
	
	/**
	 * 根据ID查询标准价格集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findEscalatorStandardListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("EscalatorStandardMapper.findEscalatorStandardListById", pd);
	}
	
	/**
	 * 计算扶梯标准价格
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData countEscalatorStandardPrice(PageData pd) throws Exception{
		return (PageData) dao.findForObject("EscalatorStandardMapper.countEscalatorStandardPrice", pd);
	}
	
	/**
	 *扶梯标准导出 
	 */
	public List<PageData> findEscalatorStandardList()throws Exception{
		return (List<PageData>)dao.findForList("EscalatorStandardMapper.findEscalatorStandardList", "");
	}
	
	/**
	 *扶梯标准导入 
	 */
	public void saveEscalatorStandard(PageData pd)throws Exception{
		dao.save("EscalatorStandardMapper.saveEscalatorStandard", pd);
	}
}
