package com.dncrm.service.system.elevatorCascade;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("elevatorCascadeService")
public class ElevatorCascadeService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 电梯级联管理集合
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllElevatorCascade() throws Exception{
		return (List<PageData>) dao.findForList("ElevatorCascadeMapper.listAllElevatorCascade", null);
	}
	
	/**
	 * 电梯级联管理类别集合
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllElevatorCascadeByElevatorId(PageData pd ) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorCascadeMapper.listAllElevatorCascadeByElevatorId", pd);
	}
	
	 /**
     * Add ElevatorCascade.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
	public String addElevatorCascade(PageData pd) throws Exception {
    	try {
    		int result = (int)dao.save("ElevatorCascadeMapper.insertElevatorCascade", pd);
    		if (result>0) {
				return (String)this.getMaxId(pd);
			}else{
				return "-1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
    }
	
	/**
     * 获取最大主键值 ElevatorCascade.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public Object getMaxId(PageData pd) throws Exception {
    	try {
    		return (Object)dao.findForObject("ElevatorCascadeMapper.getMaxId", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * 根据ID获取ElevatorCascade.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public PageData getElevatorCascadeById(PageData pd) throws Exception {
    	try {
    		return (PageData) dao.findForObject("ElevatorCascadeMapper.getElevatorCascadeById", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * 根据ID获取级联配置集合
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> getElevatorCascadeListById(PageData pd) throws Exception{
    	return (List<PageData>) dao.findForList("ElevatorCascadeMapper.getElevatorCascadeListById", pd);
    }
	
    /**
     * edit ElevatorCascade.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int editElevatorCascade(PageData pd) throws Exception {
    	try {
    		return (int)dao.update("ElevatorCascadeMapper.updateElevatorCascade", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }
    
    /**
     * Delete ElevatorCascade.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int delElevatorCascade(PageData pd) throws Exception {
    	try {
    		return (int)dao.delete("ElevatorCascadeMapper.deleteElevatorCascade", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }
    
    /**
     * 根据parentId获取集合 
     * @return
     * @throws Exception 
     */
    public List<PageData> elevatorCascadeListByParentId(PageData pd) throws Exception{
    	return (List<PageData>) dao.findForList("ElevatorCascadeMapper.elevatorCascadeListByParentId", pd);
    }
    
    /**
     * 根据parentId获取所有父类对象
     * @param pd
     * @return
     * @throws Exception
     */
    public PageData findAllParentElevatorCascadeByParentId(PageData pd) throws Exception{
    	return (PageData) dao.findForObject("ElevatorCascadeMapper.findAllParentElevatorCascadeByParentId", pd);
    }
}
