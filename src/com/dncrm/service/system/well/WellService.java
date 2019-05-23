package com.dncrm.service.system.well;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("wellService")
public class WellService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	//查询井道类型基本信息
		 @SuppressWarnings("unchecked")
		public List<PageData> listPdPageWell(Page page) throws Exception {
		        return (List<PageData>) dao
		                .findForList("WellMapper.WelllistPage", page);
		    }
		 //根据井道类型编号查询信息
		    public PageData findWellpeById(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("WellMapper.findWellpeById", pd);
		    }
		  //根据井道类型名称查询信息
		    public PageData findWellpeByName(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("WellMapper.findWellpeByName", pd);
		    }
		   //根据井道类型编号删除数据
		    public void deleteWell(PageData pd) throws Exception {
		        // TODO Auto-generated method stub
		        dao.delete("WellMapper.deleteWell", pd);
		    }
		   //保存新增
		    public void saveS(PageData pd) throws Exception {
		        dao.save("WellMapper.saveS", pd);
		    }
		    
		   //保存修改
		    public void editS(PageData pd) throws Exception {
		        dao.update("WellMapper.editS", pd);
		    }
		 
		    
		    /**
			 * 获取option集合
			 * @return
			 * @throws Exception
			 */
			public List<PageData> findWellList() throws Exception{
				return (List<PageData>) dao.findForList("WellMapper.findWellList", null);
			}
}
