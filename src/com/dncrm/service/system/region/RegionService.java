package com.dncrm.service.system.region;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 * The type leave service.
 */
@Service("regionService")
public class RegionService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**
     * List region list.
     *
     * @param page the page
     * @return the list
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> listRegions(Page page) throws Exception {
        return (List<PageData>) dao.findForList("RegionMapper.resgionlistPage", page);
    }
    
    /**
     * List region list.
     *
     * @param page the page
     * @return the list
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> listAllRegions() throws Exception {
        return (List<PageData>) dao.findForList("RegionMapper.listAllRegions", null);
    }

    /**
     * Add region.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int addRegion(PageData pd) throws Exception {
    	try {
    		int result = (int)dao.save("RegionMapper.insertRegion", pd);
    		if (result>0) {
				return (int)this.getMaxId(pd);
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }
    /**
     * Delete region.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int delRegion(PageData pd) throws Exception {
    	try {
    		return (int)dao.delete("RegionMapper.deleteRegion", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }
    /**
     * edit region.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int editRegion(PageData pd) throws Exception {
    	try {
    		return (int)dao.delete("RegionMapper.updateRegion", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
    }

    /**
     * 获取最大主键值 region.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public Object getMaxId(PageData pd) throws Exception {
    	try {
    		return (Object)dao.findForObject("RegionMapper.getMaxId", pd);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * 获取地区 region.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public PageData findRegionById(PageData pd) throws Exception{
    	return (PageData)dao.findForObject("findRegionById", pd);
    }
    
    /**
     *导出tb_region用 
     */
    public List<PageData> findRegionList()throws Exception{
    	return (List<PageData>)dao.findForList("RegionMapper.findRegionList", "");
    }
    /**
     *导入tb_region用 
     */
    public void saveRegion(PageData pd)throws Exception{
    	dao.save("RegionMapper.saveRegion", pd);
    }

}
