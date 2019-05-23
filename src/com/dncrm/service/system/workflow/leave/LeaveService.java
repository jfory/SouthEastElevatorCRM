package com.dncrm.service.system.workflow.leave;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * The type leave service.
 */
@Service("leaveService")
public class LeaveService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**
     * List leave list.
     *
     * @param page the page
     * @return the list
     * @throws Exception the exception
     */
    public List<PageData> listLeaves(Page page) throws Exception {
        // TODO Auto-generated method stub
        return (List<PageData>) dao.findForList("LeaveMapper.leavelistPage", page);
    }

    /**
     * Insert leave.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void insertLeave(PageData pd) throws Exception {
        dao.save("LeaveMapper.insertLeave", pd);

    }

    /**
     * Update leave.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void updateLeave(PageData pd) throws Exception {
        dao.update("LeaveMapper.updateLeave", pd);
    }
    /**
     * Update leave ProcessInstanceId.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void updateLeaveProcessInstanceId(PageData pd) throws Exception {
        dao.update("LeaveMapper.updateLeaveProcessInstanceId", pd);
    }
    /**
     * Update leave Status.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void updateLeaveStatus(PageData pd) throws Exception {
        dao.update("LeaveMapper.updateLeaveStatus", pd);
    }

    /**
     * Delete leave.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void deleteLeave(PageData pd) throws Exception {
        dao.delete("LeaveMapper.deleteLeave", pd);
    }


    /**
     * Find by id page data.
     *
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("LeaveMapper.findById", pd);
    }

    /**
     * Delete all.
     *
     * @param ArrayDATA_IDS the array data ids
     * @throws Exception the exception
     */
/*
    * 批量删除
    */
    public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
        dao.delete("LeaveMapper.deleteAll", ArrayDATA_IDS);
    }
}
