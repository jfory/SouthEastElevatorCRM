package com.dncrm.service.system.competitor;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("competitorService")
public class CompetitorService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	//查询竞争对手基本信息
	 @SuppressWarnings("unchecked")
	public List<PageData> listPdPageCompetitor(Page page) throws Exception {
	        return (List<PageData>) dao
	                .findForList("CompetitorMapper.competitorlistPage", page);
	    }
	 
	 /**
	     * 根据竞争对手公司编号查询信息
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findCompetitorById(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("CompetitorMapper.findCompetitorById", pd);
	    }

	    
	    /**
	     * 根据竞争对手公司名称
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findCompByName(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("CompetitorMapper.findCompByName", pd);
	    }
	    
	    /**
	     * 根据竞争对手公司地址
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findCompByAddress(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("CompetitorMapper.findCompByAddress", pd);
	    }
	    
	    
	    /**
	     * 根据竞争对手公司编号删除信息
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void deletecompetitor(PageData pd) throws Exception {
	        // TODO Auto-generated method stub
	        dao.delete("CompetitorMapper.deletecompetitor", pd);
	    }
	    
	    
	    
	    /**
	     * 保存新增
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void saveS(PageData pd) throws Exception {
	        dao.save("CompetitorMapper.saveS", pd);
	    }
	 
	    /**
	     * 保存修改
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void editS(PageData pd) throws Exception {

	        dao.update("CompetitorMapper.editS", pd);
	    }
	    /**
		 * 获取option集合
		 * @return
		 * @throws Exception
		 */
		public List<PageData> findCompetitorList() throws Exception{
			return (List<PageData>) dao.findForList("CompetitorMapper.findCompetitorList", null);
		}
}
