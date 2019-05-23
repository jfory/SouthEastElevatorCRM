package com.dncrm.service.system.housesType;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("housestypeService")
public class HousesTypeService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	//查询楼盘类型基本信息
		 @SuppressWarnings("unchecked")
		public List<PageData> listPdPageHousesType(Page page) throws Exception {
		        return (List<PageData>) dao
		                .findForList("HousesTypeMapper.housestypelistPage", page);
		    }
		 //根据楼盘类型编号查询信息
		    public PageData findHousesTypeById(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesTypeMapper.findHousesTypeById", pd);
		    }
			 //根据楼盘类型名称查询信息
		    public PageData findHousesTypeByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("HousesTypeMapper.findHousesTypeByName", pd);
		    }
		   //根据楼盘类型编号删除数据
		    public void deleteHousesType(PageData pd) throws Exception {
		        // TODO Auto-generated method stub
		        dao.delete("HousesTypeMapper.deleteHousesType", pd);
		    }
		   //保存新增
		    public void saveS(PageData pd) throws Exception {
		        dao.save("HousesTypeMapper.saveS", pd);
		    }
		    
		   //保存修改
		    public void editS(PageData pd) throws Exception {
		        dao.update("HousesTypeMapper.editS", pd);
		    }
		    
		    /**
			 * 获取option集合
			 * @return
			 * @throws Exception
			 */
			public List<PageData> findHousesTypeList() throws Exception{
				return (List<PageData>) dao.findForList("HousesTypeMapper.findHousesTypeList", null);
			}
		 
}
