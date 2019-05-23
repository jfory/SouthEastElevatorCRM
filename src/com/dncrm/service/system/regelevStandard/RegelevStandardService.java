package com.dncrm.service.system.regelevStandard;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("regelevStandardService")
public class RegelevStandardService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 电梯标准分页列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageRegelevStandard(Page page) throws Exception{
		return (List<PageData>) dao.findForList("RegelevStandardMapper.regelevStandardlistPage", page);
	}
	
	/**
	 * 电梯标准列表全部
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllRegelevStandard() throws Exception{
		return (List<PageData>) dao.findForList("RegelevStandardMapper.listAllRegelevStandard", "");
	}
	
	
	/**
	 * 电梯标准价格添加
	 * @param pd
	 * @throws Exception
	 */
	public void regelevStandardAdd(PageData pd) throws Exception{
		dao.save("RegelevStandardMapper.regelevStandardAdd", pd);
	}
	
	/**
	 * 扶梯标准价格添加
	 * @param pd
	 * @throws Exception
	 */
	public void escalatorStandardAdd(PageData pd) throws Exception{
		dao.save("RegelevStandardMapper.escalatorStandardAdd", pd);
	}
	
	
	/**
	 * 根据主键查询
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception{
		return (PageData)dao.findForObject("RegelevStandardMapper.findById", pd);
	}
	
	public PageData findByModelsId(PageData pd) throws Exception{
		return (PageData)dao.findForObject("RegelevStandardMapper.findByModelsId", pd);
	}
	
	public PageData findByModelsId2(PageData pd) throws Exception{
		return (PageData)dao.findForObject("RegelevStandardMapper.findByModelsId2", pd);
	}
	
	
	/**
	 * 根据主键查询--扶梯标准
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById2(PageData pd) throws Exception{
		return (PageData)dao.findForObject("RegelevStandardMapper.findById2", pd);
	}
	
	/**
	 * 根据主键查询--家用梯标准
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById3(PageData pd) throws Exception{
		return (PageData)dao.findForObject("RegelevStandardMapper.findById3", pd);
	}
	
	/**
	 * 获取常规梯 全部电梯型号信息
	 */
	public List<PageData> modelsList(Page page) throws Exception{
		return (List<PageData>) dao.findForList("RegelevStandardMapper.modelsList", page);
	}
}
