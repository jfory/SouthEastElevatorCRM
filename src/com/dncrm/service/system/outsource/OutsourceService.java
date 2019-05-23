package com.dncrm.service.system.outsource;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;


@Service("outsourceService")
public class OutsourceService{

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	public List<PageData> listPageItem(Page page)throws Exception{
		return (List<PageData>) dao.findForList("OutsourceMapper.listPageItem", page);
	}
	
	public List<PageData> listPageOutsource(Page page)throws Exception{
		return (List<PageData>) dao.findForList("OutsourceMapper.listPageOutsource", page);
	}
	
	public void saveOutsource(PageData pd)throws Exception{
		dao.save("saveOutsource", pd);
	}
	
	public PageData findOutsource(String id) throws Exception{
		return (PageData) dao.findForObject("OutsourceMapper.findOutsource", id);
	}
	
	public void updateOutsource(PageData pd)throws Exception{
		dao.update("OutsourceMapper.updateOutsource", pd);
	}
	
	
	

	
}
