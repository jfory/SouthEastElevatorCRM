package com.dncrm.service.system.houseType;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("housetypeService")
public class HouseTypeService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	//查询户型信息
	@SuppressWarnings("unchecked")
	public List<PageData> HouseTypelistPage(Page page) throws Exception 
	{
		return (List<PageData>) dao.findForList("HouseTypeMapper.HouseTypelistPage", page);
    }
	
	//根据户型ID删除户型信息
	public void delHouseType(PageData pd) throws Exception 
	{
		dao.delete("HouseTypeMapper.delHouseType", pd);
	}
	//查询楼盘ID和name
	@SuppressWarnings("unchecked")
	public List<PageData> HouseslistPage(Page page) throws Exception 
	{
		return (List<PageData>) dao.findForList("HouseTypeMapper.houseslistPage", page);
	}
	
	 /**
     * 判断户型名称是否唯一
     */
    public PageData findHouseTypeByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("HouseTypeMapper.findHouseTypeByName", pd);
    }
	
    //保存新增
    public void saveS(PageData pd) throws Exception {
        dao.save("HouseTypeMapper.saveS", pd);
    }
   //保存修改
    public void editS(PageData pd) throws Exception {
        dao.update("HouseTypeMapper.editS", pd);
    }
    //根据户型编号查询信息
    public PageData findHouseTypeById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("HouseTypeMapper.findHouseTypeById", pd);
    }	
    
    //根据楼盘name查询楼盘ID
    public PageData findHousesByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("HouseTypeMapper.findHousesByName", pd);
    }
    //查询属于该户型的解决方案信息
  	@SuppressWarnings("unchecked")
  	public List<PageData> solutionlistPage(Page page) throws Exception 
  	{
  		return (List<PageData>) dao.findForList("HouseTypeMapper.solutionlistPage", page);
      }	
  	//查询属于该户型的单元信息
  	@SuppressWarnings("unchecked")
  	public List<PageData> celllistPage(Page page) throws Exception 
  	{
  		return (List<PageData>) dao.findForList("HouseTypeMapper.celllistPage", page);
      }	
  	 /**
	 * 获取option集合
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findHouseTypeList() throws Exception{
		return (List<PageData>) dao.findForList("HouseTypeMapper.findHouseTypeList", null);
	}
		 
}
