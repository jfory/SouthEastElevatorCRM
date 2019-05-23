package com.dncrm.service.system.production;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("productionService")
public class ProductionService
{
    @Resource(name="daoSupport")
    private DaoSupport dao;
    /**
   	 * 二排获取option集合
   	 * @return
   	 * @throws Exception
   	 */
   	public List<PageData> findProductionTowList() throws Exception{
   		return (List<PageData>) dao.findForList("ProductionMapper.findProductionTowList", null);
   	}
    /**
   	 * 获取option集合
   	 * @return
   	 * @throws Exception
   	 */
   	public List<PageData> findProductionOneList() throws Exception{
   		return (List<PageData>) dao.findForList("ProductionMapper.findProductionOneList", null);
   	}
    //查询基本信息（一排）
  	@SuppressWarnings("unchecked")
  	public List<PageData> listPdPageProduction(Page page) throws Exception {
  	        return (List<PageData>) dao.findForList("ProductionMapper.productionlistPage", page);
  	    }
  //查询基本信息（二排）
  	@SuppressWarnings("unchecked")
  	public List<PageData> listPdPageTow(Page page) throws Exception {
  	        return (List<PageData>) dao.findForList("ProductionMapper.proTowlistPage", page);
  	    }
  	
  	 /**
     * 查询流程是否存在
     * @param page
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> Production_key(Page page) throws Exception
    {
    	return (List<PageData>) dao.findForList("ProductionMapper.Production_key", page);
    }
    @SuppressWarnings("unchecked")
    public List<PageData> ProductionB_key(Page page)throws Exception
    {
    	return (List<PageData>)dao.findForList("ProductionMapper.ProductionB_key", page);
    }
    
    /**
     * 查询一排排产流程是否存在
     * @param page
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> OneProductionKEY(PageData pd) throws Exception
    {
    	return (List<PageData>) dao.findForList("ProductionMapper.OneProductionKEY", pd);
    }
    
    /**
     * 保存新增(一排)
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void saveS(PageData pd) throws Exception {
        dao.save("ProductionMapper.saveS", pd);
    }
    /**
     * 保存新增（二排）
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void saveSTow(PageData pd) throws Exception {
        dao.save("ProductionMapper.saveSTow", pd);
    }
    
    /**
     * 根据编号删除信息(二排)
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delTowfindById(PageData pd) throws Exception {
        dao.delete("ProductionMapper.delTowfindById", pd);
    }
    /**
     * 根据编号删除信息(一排)
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delfindById(PageData pd) throws Exception {
        dao.delete("ProductionMapper.delfindById", pd);
    }
    /**
     * 保存编辑(二排)
     * @param pd
     * @throws Exception
     */
    public void editSTow(PageData pd) throws Exception
    {
    	dao.update("ProductionMapper.upTowfindById", pd);
    }
    /**
     * 保存编辑
     * @param pd
     * @throws Exception
     */
    public void editS(PageData pd) throws Exception
    {
    	dao.update("ProductionMapper.upfindById", pd);
    }
    /**
     * 根据编号查询信息(二排)
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findProtowById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findProtowById", pd);
    }
    
    //根据项目name获取id和no
    public PageData findItemByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findItemByName", pd);
    }
 
  //根据电梯no 获取电梯信息
    public PageData findElevatorDetailsByNO(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findElevatorDetailsByNO", pd);
    }
    
  //根据电梯no 获取排产信息(一排)
    public PageData findProductionOnerowByNO(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findProductionOnerowByNO", pd);
    }
    
  //根据电梯no 获取排产信息（二排）
    public PageData findProductionTowrowByNO(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findProductionTowrowByNO", pd);
    }
    /**
     * 根据编号查询信息（一排）
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findProById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findProById", pd);
    }
  //更新流程审核状态（二排）
    public void upProTowApproval(PageData pd) throws Exception {
        dao.update("ProductionMapper.upProTowApproval", pd);
    }
  //更新流程审核状态（一排）
    public void updateProApproval(PageData pd) throws Exception {
        dao.update("ProductionMapper.updateProApproval", pd);
    }
    /**
     * 根据uuid查询信息（二排）
     * @param pd
     * @return
     * @throws Exception
     */
    public PageData findTowByuuId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findTowByuuId", pd);
    }
    /**
     * 根据uuid查询信息
     * @param pd
     * @return
     * @throws Exception
     */
    public PageData findByuuId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findByuuId", pd);
    }
    
    //------------------------------（特批相关内容）分割线------------------------
    //查询全部报价完成的项目
  	@SuppressWarnings("unchecked")
  	public List<PageData> speciallistPage(Page page) throws Exception {
  	        return (List<PageData>) dao.findForList("ProductionMapper.speciallistPage", page);
  	    }
  	 //根据项目id查询属于这个项目的电梯信息
  	@SuppressWarnings("unchecked")
  	public List<PageData> elevatorlistPage(Page page) throws Exception {
  	        return (List<PageData>) dao.findForList("ProductionMapper.elevatorlistPage", page);
  	    }
  	//保存特批排产
    public void saveOneSpecial(PageData pd) throws Exception {
        dao.save("ProductionMapper.saveOneSpecial", pd);
    }
    /**
     * 查询流程是否存在
     * @param page
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> special_key(Page page) throws Exception
    {
    	return (List<PageData>) dao.findForList("ProductionMapper.Production_key", page);
    }
    /**
     * 查询流程是否存在
     * @param page
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> Special_key(PageData pd) throws Exception
    {
    	return (List<PageData>) dao.findForList("ProductionMapper.Special_key", pd);
    }
    /**
     * 根据编号删除特批排产信息
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delSpecialfindById(PageData pd) throws Exception {
        dao.delete("ProductionMapper.delSpecialfindById", pd);
    }
    /**
     * 保存编辑
     * @param pd
     * @throws Exception
     */
    public void upSpecialfindById(PageData pd) throws Exception
    {
    	dao.update("ProductionMapper.upSpecialfindById", pd);
    }
    /**
     * 根据编号查询信息
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findSpetowById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionMapper.findSpetowById", pd);
    }
}
