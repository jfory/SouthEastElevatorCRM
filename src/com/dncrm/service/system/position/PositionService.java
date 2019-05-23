package com.dncrm.service.system.position;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;
import java.util.Set;

/**
 * The type position service.
 */
@Service("positionService")
public class PositionService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**
     * List position list.
     *
     * @return the list
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> listAllPositions() throws Exception {
        return (List<PageData>) dao.findForList("PositionMapper.listAllPositions", null);
    }

    /**
     * Add position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public String addPosition(PageData pd) throws Exception {
    	try {
    		int result = (int)dao.save("PositionMapper.insertPosition", pd);
    		if (result>0) {
				return (String) this.getMaxId(pd);
			}else{
				return "-1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
    }
    /**
     * Delete position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int delPosition(PageData pd) throws Exception {
    	try {
    		return (int)dao.delete("PositionMapper.deletePosition", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }
    /**
     * edit position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int editPosition(PageData pd) throws Exception {
    	try {
    		return (int)dao.update("PositionMapper.updatePosition", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }

    /**
     * 获取最大主键值 position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public Object getMaxId(PageData pd) throws Exception {
    	try {
    		return (Object)dao.findForObject("PositionMapper.getMaxId", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    /**
     * 根据父类ID获取position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public List<PageData> getPositionByParentId(PageData pd) throws Exception {
    	try {
    		return (List<PageData>) dao.findForList("PositionMapper.getPositionByParentId", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    /**
     * 根据ID获取position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public PageData getPositionById(PageData pd) throws Exception {
    	try {
    		return (PageData) dao.findForObject("PositionMapper.getPositionById", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * 根据用户ID获取position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public PageData findPositionInfoByUid(PageData pd) throws Exception {
    	try {
    		return (PageData) dao.findForObject("PositionMapper.findPositionInfoByUid", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * 根据用户ID关联查询获取position.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public PageData findPositionByUserId(String id) throws Exception {
    	try {
    		return (PageData) dao.findForObject("PositionMapper.findPositionByUserId", id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    
    /**
     *导出tb_position用 
     */
    public List<PageData> findPositionList()throws Exception{
    	return (List<PageData>)dao.findForList("PositionMapper.findPositionList", "");
    }
    /**
     *导入tb_position用 
     */
    public void savePosition(PageData pd)throws Exception{
    	dao.save("PositionMapper.savePosition", pd);
    }

}
