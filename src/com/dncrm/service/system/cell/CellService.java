package com.dncrm.service.system.cell;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("cellService")
public class CellService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageCellByRole(Page page)throws Exception{
		return (List<PageData>) dao.findForList("CellMapper.celllistPageByRole", page);
	}

	//查询单元基本信息
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageCell(Page page) throws Exception {
	        return (List<PageData>) dao
	                .findForList("CellMapper.celllistPage", page);
	    }
	 
	//查询户型信息
  	@SuppressWarnings("unchecked")
  	public List<PageData> houseTypelistPage(Page page) throws Exception 
  	{
  		return (List<PageData>) dao.findForList("CellMapper.houseTypelistPage", page);
      }		
	//查询楼盘基本信息
		@SuppressWarnings("unchecked")
		public List<PageData> listPdPageHouses(Page page) throws Exception {
		        return (List<PageData>) dao
		                .findForList("CellMapper.houseslistPage", page);
		    }
//查询小业主信息
@SuppressWarnings("unchecked")
public List<PageData> MerchantlistPage(Page page) throws Exception 
{
    return (List<PageData>) dao.findForList("CellMapper.MerchantlistPage", page);
}	
		/**
		 * 根据楼盘编号，查询属于该楼盘的户型信息
		 * @param pd
		 * @return
		 * @throws Exception
		 */
		 public List<PageData> findhouseTypeById(PageData pd) throws Exception {
		        return (List<PageData>) dao.findForList("CellMapper.findhouseTypeById", pd);
		    }
	 /**
	     * 根据单元编号查询楼盘信息
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findCellById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("CellMapper.findCellById", pd);
	    }
	    /**
	     * 根据单元名称查询楼盘信息
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findCellByName(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("CellMapper.findCellByName", pd);
	    }
	    /**
	     * 根据单元编号删除单元信息
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void deleteCell(PageData pd) throws Exception {
	        dao.delete("CellMapper.deleteCell", pd);
	    }
	 
	    /*
	     * 查询竞争对手信息
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> competitorList(Page page) throws Exception {
	        return (List<PageData>) dao
	                .findForList("CellMapper.competitorList", page);
	    }
	    /*
	     * 查询井道信息
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> welllistPage(Page page) throws Exception {
	        return (List<PageData>) dao
	                .findForList("CellMapper.welllistPage", page);
	    }
	    /*
	     * 查询户型信息
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> doormodellistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("CellMapper.doormodellistPage", page);
	    }
	    /*
	     * 根据编号查询竞争对手信息
	     */
	    public PageData findCompetitorById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("CellMapper.findCompetitorById", pd);
	    }
	    
	    
	    /*
	     * 根据楼盘编号查询楼盘信息
	     */
	    public PageData findHousesById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("CellMapper.findHousesById", pd);
	    }
	    
	    /*
	     * 根据楼盘编号   统计属于该楼盘的单元数量
	     */
	    public PageData findCellByHousesId(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("CellMapper.findCellByHousesId", pd);
	    }
	    //查询属于该户型的解决方案信息
	  	@SuppressWarnings("unchecked")
		public List<PageData> solutionlistPage(Page page) throws Exception 
	  	{
	  		return (List<PageData>) dao.findForList("CellMapper.solutionlistPage", page);
	      }	
	    /**
	     * 保存新增
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void saveS(PageData pd) throws Exception {
	        dao.save("CellMapper.saveS", pd);
	    }
	    /**
	     * 保存修改
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void editS(PageData pd) throws Exception {
	        dao.update("CellMapper.editS", pd);
	    }
	    
	    /**
	     * 修改楼盘 别墅数量
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void editHouses(PageData pd) throws Exception {
	        dao.update("CellMapper.editHouses", pd);
	    }
	    /**
		 * 获取option集合
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		public List<PageData> findCellList() throws Exception{
			return (List<PageData>) dao.findForList("CellMapper.findCellList", null);
		}	
		/**
		 * 根据楼盘name获取楼盘信息
		 * @param pd
		 * @return
		 * @throws Exception
		 */
		 public PageData findHousesByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findHousesByName", pd);
		    }
		 /**
		  * 根据户型name获取户型信息
		  * @param pd
		  * @return
		  * @throws Exception
		  */
		 public PageData findHouseTypeByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findHouseTypeByName", pd);
		    }
		 /**
		  * 根据业主name获取业主信息
		  * @param pd
		  * @return
		  * @throws Exception
		  */
		 public PageData findCustomerByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findCustomerByName", pd);
		    }
		 //根据户型方案name获取方案信息
		 public PageData findSolutionByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findSolutionByName", pd);
		    }
		 //根据竞争对手name获取对手信息
		 public PageData findCompetitorByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findCompetitorByName", pd);
		    }
		 
		//根据井道类型name获取井道类型信息
		 public PageData findWellByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findWellByName", pd);
		    }
		 
		//根据单元name获取单元信息
		 public PageData findComp_priceByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("CellMapper.findComp_priceByName", pd);
		    }
}
