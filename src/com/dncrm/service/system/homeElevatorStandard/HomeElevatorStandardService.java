package com.dncrm.service.system.homeElevatorStandard;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("homeElevatorStandardService")
public class HomeElevatorStandardService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	
	
	/**
	 * 家用电梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageHomeElevatorStandard(Page page) throws Exception{
		return (List<PageData>) dao.findForList("HomeElevatorStandardMapper.homeElevatorStandardlistPage", page);
	}
	
	
	/**
	 * 家用电梯标准价格添加
	 * @param pd
	 * @throws Exception
	 */
	public void homeElevatorStandardAdd(PageData pd) throws Exception{
		dao.save("HomeElevatorStandardMapper.homeElevatorStandardAdd", pd);
	}
	
	/**
	 * 家用电梯标准价格编辑
	 * @param pd
	 * @throws Exception
	 */
	public void homeElevatorStandardEdit(PageData pd) throws Exception{
		dao.update("HomeElevatorStandardMapper.homeElevatorStandardUpdate", pd);
	}
	
	/**
	 * 家用电梯标准价格名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsHomeElevatorStandardName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("HomeElevatorStandardMapper.existsHomeElevatorStandardName", pd);
	}
	
	/**
	 * 家用电梯标准价格删除
	 * @param pd
	 * @throws Exception
	 */
	public void homeElevatorStandardDeleteById(PageData pd) throws Exception{
		dao.delete("HomeElevatorStandardMapper.homeElevatorStandardDeleteById", pd);
	}
	
	/**
	 * 批量删除家用电梯标准价格
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void homeElevatorStandardDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("HomeElevatorStandardMapper.homeElevatorStandardDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 * 根据ID查询标准价格对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findHomeElevatorStandardById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("HomeElevatorStandardMapper.findHomeElevatorStandardById", pd);
	}
	
	/**
	 * 根据ID查询标准价格集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findHomeElevatorStandardListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("HomeElevatorStandardMapper.findHomeElevatorStandardListById", pd);
	}
	
	/**
	 * 计算家用电梯标准价格
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData countHomeStandardPrice(PageData pd) throws Exception{
		return (PageData) dao.findForObject("HomeElevatorStandardMapper.countHomeStandardPrice", pd);
	}
}
