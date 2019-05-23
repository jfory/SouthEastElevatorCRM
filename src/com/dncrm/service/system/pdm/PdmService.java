package com.dncrm.service.system.pdm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("pdmService")
public class PdmService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	/**
	 *工程项目表新增数据 
	 */
	public void saveDGCXM(PageData pd)throws Exception{
		dao.save("PdmMapper.saveDGCXM", pd);
	}
	
	/**
	 *工程项目表查询 
	 */
	public List<PageData> findDGCXM()throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.findDGCXM", "");
	}
	
	/**
	 *项目配置新增数据
	 */
	public void saveDXMPZ(PageData pd)throws Exception{
		dao.save("PdmMapper.saveDXMPZ", pd);
	}
	
	/**
	 *项目配置表查询 
	 */
	public List<PageData> findDXMPZ()throws Exception{
		return (List<PageData>) dao.findForList("findDXMPZ", "");
	}
	
	/**
	 *项目配置参数新增数据
	 */
	public void saveDXMPZCS(PageData pd)throws Exception{
		dao.save("PdmMapper.saveDXMPZCS", pd);
	}
	
	/**
	 *项目配置参数表查询 
	 */
	public List<PageData> findDXMPZCS()throws Exception{
		return (List<PageData>) dao.findForList("findDXMPZCS", "");
	}
	
	/**
	 *基础数据对照关系表新增数据
	 */
	public void saveDDZGX(PageData pd)throws Exception{
		dao.save("PdmMapper.saveDDZGX", pd);
	}
	
	/**
	 *基础数据对照表查询 
	 */
	public List<PageData> findDDZGX()throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.findDDZGX", "");
	}
	
	
	/**
	 *pdm查询用 
	 */
	public List<PageData> findGCXMForPdm()throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.findGCXMForPdm", "");
	}
	
	/**
	 *查询pdm日志 
	 */
	public List<PageData> listPagefindPdmLog(Page page)throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.listPagefindPdmLog", page);
	}
	
	
	/**
	 *查询基础关系对照表中数据是否存在 
	 */
	public String findExistDZGX(PageData pd)throws Exception{
		return (String) dao.findForObject("PdmMapper.findExistDZGX", pd);
	}
	
	/**
	 *获取基础对照关系数据 
	 */
	public List<PageData> findDataDZGX()throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.findDataDZGX", "");
	}
	
	/**
	 *获取项目配置数据 
	 */
	public List<PageData> findDataXMPZ()throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.findDataXMPZ", "");
	}
	
	/**
	 *获取项目配置参数数据 
	 */
	public List<PageData> findDataXMPZCS()throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.findDataXMPZCS", "");
	}
	
	/**
	 *GCXM日志 
	 */
	public List<PageData> listPageGCXMLog(Page page)throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.listPageGCXMLog", page);
	}
	
	/**
	 *XMPZ日志 
	 */
	public List<PageData> listPageXMPZLog(Page page)throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.listPageXMPZLog", page);
	}
	
	/**
	 *XMPZCS日志 
	 */
	public List<PageData> listPageXMPZCSLog(Page page)throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.listPageXMPZCSLog", page);
	}
	
	/**
	 *DZGX日志 
	 */
	public List<PageData> listPageDZGXLog(Page page)throws Exception{
		return (List<PageData>) dao.findForList("PdmMapper.listPageDZGXLog", page);
	}
	
	/**
	 *上传GCXM 
	 */
	public void saveGCXMLog(PageData pd)throws Exception{
		dao.save("PdmMapper.saveGCXMLog", pd);
	}
	
	/**
	 *上传XMPZ 
	 */
	public void saveXMPZLog(PageData pd)throws Exception{
		dao.save("PdmMapper.saveXMPZLog", pd);
	}
	
	/**
	 *上传XMPZCS 
	 */
	public void saveXMPZCSLog(PageData pd)throws Exception{
		dao.save("PdmMapper.saveXMPZCSLog", pd);
	}
	
	/**
	 *上传DZGX 
	 */
	public void saveDZGXLog(PageData pd)throws Exception{
		dao.save("PdmMapper.saveDZGXLog", pd);
	}
	
}
