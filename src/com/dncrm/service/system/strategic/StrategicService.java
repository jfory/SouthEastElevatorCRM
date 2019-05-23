package com.dncrm.service.system.strategic;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("strategicService")
public class StrategicService 
{
	@Resource(name="daoSupport")
    private DaoSupport dao;
	
	/**
	 * 查询全部协议信息
	 * @param page
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> strategiclistPage(Page page) throws Exception
	{
		return (List<PageData>) dao.findForList("StrategicMapper.strategiclistPage", page);
	}
	/**
	 * 根据协议编号查询协议信息
	 * @param pd （传入数据 “协议编号”）
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception
	{
		return (PageData) dao.findForObject("StrategicMapper.findById", pd);
	}
	/**
     * 根据协议编号删除信息
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delfindById(PageData pd) throws Exception {
        dao.delete("StrategicMapper.delfindById", pd);
    }
    /**
     * 保存新增
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void saveS(PageData pd) throws Exception {
        dao.save("StrategicMapper.saveS", pd);
    }
    /**
     * 保存编辑
     * @param pd
     * @throws Exception
     */
    public void editS(PageData pd) throws Exception
    {
    	dao.update("StrategicMapper.upfindById", pd);
    }
    /**
     * 查询流程是否存在
     * @param page
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> stra_strategy_key(Page page) throws Exception
    {
    	return (List<PageData>) dao.findForList("StrategicMapper.stra_strategy_key", page);
    }
    /**
     * 更新流程状态
     * @param pd
     * @throws Exception
     */
    public void upStraApproval(PageData pd) throws Exception {
        dao.update("StrategicMapper.upStraApproval", pd);
    }
    /**
     * 根据uuid查询信息
     * @param pd
     * @return
     * @throws Exception
     */
    public PageData findByuuId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("StrategicMapper.findByuuId", pd);
    }
    /**
     * 查询战略客户信息
     * @param pd
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> customerlist(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("StrategicMapper.customerlist", pd);
    }
    
    /**
   	 * 获取option集合
   	 * @return
   	 * @throws Exception
   	 */
   	public List<PageData> findStrategicList() throws Exception{
   		return (List<PageData>) dao.findForList("StrategicMapper.findStrategicList", null);
   	}
   	//根据客户name查询客户id
    public PageData findCustomer_coreByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("StrategicMapper.findCustomer_coreByName", pd);
    }
}
