package com.dncrm.service.system.comefund;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("comefundService")
public class ComeFundService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	

	//查询来款基本信息
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageComeFund(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ComeFundMapper.comefundlistPage", page);
	    }
	/**
     * 保存新增
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void saveS(PageData pd) throws Exception {
        dao.save("ComeFundMapper.saveS", pd);
    }
    /**
     * 保存分款
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void claimsaveS(PageData pd) throws Exception {
        dao.save("ComeFundMapper.claimsaveS", pd);
    }
    /**
     * 根据编号查询信息
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findComeFundById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ComeFundMapper.findComeFundById", pd);
    }
    /**
     * 保存修改
     * @param pd the pd
     * @throws Exception the exception
     */
    public void editS(PageData pd) throws Exception {
        dao.update("ComeFundMapper.editS", pd);
    }
    /**
     * 根据编号删除信息
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delComeFund(PageData pd) throws Exception {
        dao.delete("ComeFundMapper.delComeFund", pd);
    }
   //查询应收款项目信息
  	@SuppressWarnings("unchecked")
  	public List<PageData> collectSetlistPage(Page page) throws Exception {
  	        return (List<PageData>) dao.findForList("ComeFundMapper.collectSetlistPage", page);
  	    }
  	 /*
     * 根据编号查询应收款信息
     */
    public PageData findCollectSetById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ComeFundMapper.findCollectSetById", pd);
    }
    /*
     * 根据编号查询应收款电梯信息
     */
  	public List<PageData> findCollectStageById(PageData pd) throws Exception {
  	        return (List<PageData>) dao.findForList("ComeFundMapper.findCollectStageById", pd);
  	    }
  	/**
	 *保存分款    分给电梯 的钱
	 */
	public void saveEle(PageData pd)throws Exception{
		dao.save("ComeFundMapper.saveEle", pd);
	}
	
	
	/**
	 * 获取option集合
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findComFundList() throws Exception{
		return (List<PageData>) dao.findForList("ComeFundMapper.findComFundList", null);
	}
}
