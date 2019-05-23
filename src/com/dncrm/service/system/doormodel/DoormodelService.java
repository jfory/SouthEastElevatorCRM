package com.dncrm.service.system.doormodel;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("doormodelService")
public class DoormodelService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
		
		//查询户型类型基本信息
		 @SuppressWarnings("unchecked")
		public List<PageData> doormodellistPage(Page page) throws Exception {
		        return (List<PageData>) dao
		                .findForList("DoormodelMapper.doormodellistPage", page);
		    }
		 //根据户型类型编号查询信息
		    public PageData findDoorModelById(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("DoormodelMapper.findDoorModelById", pd);
		    }
		  //根据户型类型名称查询信息
		    public PageData findDoorModelByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("DoormodelMapper.findDoorModelByName", pd);
		    }
		    
		   //根据户型类型编号删除数据
		    public void deleteDoorModel(PageData pd) throws Exception {
		        // TODO Auto-generated method stub
		        dao.delete("DoormodelMapper.deleteDoorModel", pd);
		    }
		   //保存新增
		    public void saveS(PageData pd) throws Exception {
		        dao.save("DoormodelMapper.saveS", pd);
		    }
		    
		   //保存修改
		    public void editS(PageData pd) throws Exception {
		        dao.update("DoormodelMapper.editS", pd);
		    }
		 
}
