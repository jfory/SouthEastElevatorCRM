package com.dncrm.service.system.solution;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("solutionService")
public class SolutionService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	//查询全部信息
	@SuppressWarnings("unchecked")
	public List<PageData> SolutionlistPage(Page page) throws Exception 
	{
		return (List<PageData>) dao.findForList("SolutionMapper.SolutionlistPage", page);
    }
	
	//根据ID删除信息
	public void delSolution(PageData pd) throws Exception 
	{
		dao.delete("SolutionMapper.delSolution", pd);
	}
	//查询户型ID和name
	@SuppressWarnings("unchecked")
	public List<PageData> houseTypelistPage(Page page) throws Exception 
	{
		return (List<PageData>) dao.findForList("SolutionMapper.houseTypelistPage", page);
	}
    //保存新增
    public void saveS(PageData pd) throws Exception {
        dao.save("SolutionMapper.saveS", pd);
    }
   //保存修改
    public void editS(PageData pd) throws Exception {
        dao.update("SolutionMapper.editS", pd);
    }
    //根据编号查询信息
    public PageData findSolutionById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("SolutionMapper.findSolutionById", pd);
    }
    //根据户型名称和楼盘名称查询户型id和楼盘id
    public PageData housesByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("SolutionMapper.housesByName", pd);
    }
    
    /**
   	 * 获取option集合
   	 * @return
   	 * @throws Exception
   	 */
   	@SuppressWarnings("unchecked")
	public List<PageData> findSolutionList() throws Exception{
   		return (List<PageData>) dao.findForList("SolutionMapper.findSolutionList", null);
   	}
}
