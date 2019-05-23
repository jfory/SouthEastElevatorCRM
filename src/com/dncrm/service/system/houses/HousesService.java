package com.dncrm.service.system.houses;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("housesService")
public class HousesService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageHousesByRole(Page page)throws Exception{
		return (List<PageData>) dao.findForList("HousesMapper.houseslistPageByRole", page);
	}
	
	//查询楼盘基本信息
	 @SuppressWarnings("unchecked")
	public List<PageData> listPdPageHouses(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("HousesMapper.houseslistPage", page);
	    }
	//测试
	    public PageData text(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("HousesMapper.text", pd);
	    }
	    //查询属于该楼盘的户型信息
	  	@SuppressWarnings("unchecked")
	  	public List<PageData> houseTypelistPage(Page page) throws Exception 
	  	{
	  		return (List<PageData>) dao.findForList("HousesMapper.houseTypelistPage", page);
	      }	
	 
	 /**
	     * 根据楼盘编号查询楼盘信息
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findHousesById(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("HousesMapper.findHousesById", pd);
	    }
	    
	    
	    /**
	     * 根据楼盘编号查询单元信息
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
		 @SuppressWarnings("unchecked")
		public List<PageData> cellListPage(Page page) throws Exception {
		        return (List<PageData>) dao.findForList("HousesMapper.celllistPage", page);
		    }
	    
	    /**
	     * 根据楼盘名称查询
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findHousesByName(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("HousesMapper.findHousesByName", pd);
	    }
	    
	    /**
	     * 根据楼盘地址查询
	     *
	     * @param pd the pd
	     * @return the page data
	     * @throws Exception the exception
	     */
	    public PageData findHousesByAddress(PageData pd) throws Exception {

	        return (PageData) dao.findForObject("HousesMapper.findHousesByAddress", pd);
	    }
	    /*
	     * 根据编号查询开发商信息
	     */
	    public PageData findcustomerOrdinaryById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("HousesMapper.findcustomerOrdinaryById", pd);
	    }

	    /**
	     * 根据楼盘编号删除楼盘信息
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void deleteHouses(PageData pd) throws Exception {
	        // TODO Auto-generated method stub
	        dao.delete("HousesMapper.deleteHouses", pd);
	    }
	 
	    /*
	     * 查询楼盘类型
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> housesTypeList(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("HousesMapper.housesTypeList", page);
	    }
	    /*
	     * 查询开发商信息
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> ordinarylistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("HousesMapper.ordinarylist", page);
	    }
	    /*
	     * 查询楼盘状态
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> housesStatusList(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("HousesMapper.housesStatusList", page);
	    }
	    
	    
	    /*
	     * 查询所属区域
	     */
	    @SuppressWarnings("unchecked")
		public List<PageData> housesRegionList(Page page) throws Exception {
	        return (List<PageData>) dao
	                .findForList("HousesMapper.housesRegionList", page);
	    }
	    
	    
	    
	    /**
	     * 保存新增
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void saveS(PageData pd) throws Exception {
	        dao.save("HousesMapper.saveS", pd);
	    }
	 
	       
	    /**
	     * 保存修改
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void editS(PageData pd) throws Exception {

	        dao.update("HousesMapper.editS", pd);
	    }
	    
	    /**
	     *查询楼盘编号和name
	     *@author arisu 
	     */
	    public List<PageData> findHouseNoAndName()throws Exception{
	    	return (List<PageData>)dao.findForList("HousesMapper.findHouseNoAndName", "");
	    }
	   //**********************报表信息**********************
	    //查询每一年楼盘数量
	    public List<PageData> housesNum()throws Exception{
			return (List<PageData>)dao.findForList("HousesMapper.housesNum", "");
		}
	    //当前年份 每月的数量
	    public List<PageData> housesMonthNum(String year)throws Exception{
			return (List<PageData>)dao.findForList("HousesMapper.housesMonthNum", year);
		}
	    //当前年份  每个季度的数量
	    public List<PageData> housesQuarterNum(String year)throws Exception{
			return (List<PageData>)dao.findForList("HousesMapper.housesQuarterNum", year);
		}
	    
	    
	    
	    
	    
	    /**
		 * 获取option集合
		 * @return
		 * @throws Exception
		 */
		public List<PageData> findHousesList() throws Exception{
			return (List<PageData>) dao.findForList("HousesMapper.findHousesList", null);
		}
		//根据区域name获取id （导入）
		 public PageData findDepartmentByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesMapper.findDepartmentByName", pd);
		    }
		 
		//根据楼盘类型name获取id （导入）
		 public PageData findHousesTypeByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesMapper.findHousesTypeByName", pd);
		    }
		 
		//根据楼开发商name获取id （导入）
		 public PageData findOrdinaryByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesMapper.findOrdinaryByName", pd);
		    }
		 
		//根据楼楼盘状态name获取id （导入）
		 public PageData findHousesStatusByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesMapper.findHousesStatusByName", pd);
		    }
		 
		//根据省，市，区name获取id （导入）
		 public PageData findProvinceByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesMapper.findProvinceByName", pd);
		    }
}
