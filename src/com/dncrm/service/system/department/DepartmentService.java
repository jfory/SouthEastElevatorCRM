package com.dncrm.service.system.department;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * The type department service.
 */
@Service("departmentService")
public class DepartmentService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**
     * List department list.
     *
     * @return the list
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
    public List<PageData> listAllDepartments() throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.listAllDepartments", null);
    }

    /**
     * List department list.
     *
     * @return the list
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
    public List<PageData> listAllDepartmentsAndPositions() throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.listAllDepartmentsAndPositions", null);
    }

    public PageData getDepartmentByName(PageData pageData) throws Exception {
        return (PageData) dao.findForObject("DepartmentMapper.getDepartmentByName", pageData);
    }

    /**
     * Add department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public String addDepartment(PageData pd) throws Exception {
        try {
            int result = (int) dao.save("DepartmentMapper.insertDepartment", pd);
            if (result > 0) {
                return (String) this.getMaxId(pd);
            } else {
                return "-1";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "-1";
        }
    }

    /**
     * Delete department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int delDepartment(PageData pd) throws Exception {
        try {
            return (int) dao.delete("DepartmentMapper.deleteDepartment", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * edit department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public int editDepartment(PageData pd) throws Exception {
        try {
            return (int) dao.delete("DepartmentMapper.updateDepartment", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * 获取最大主键值 department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public Object getMaxId(PageData pd) throws Exception {
        try {
            return (Object) dao.findForObject("DepartmentMapper.getMaxId", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 根据父类ID获取department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public List<PageData> getDepartmentByParentId(PageData pd) throws Exception {
        try {
            return (List<PageData>) dao.findForList("DepartmentMapper.getDepartmentByParentId", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 根据ID获取department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public List<PageData> getDepartmentById(PageData pd) throws Exception {
        try {
            return (List<PageData>) dao.findForList("DepartmentMapper.getDepartmentById", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public List<PageData> getDepartmentById1(PageData pd) {
        try {
            return (List<PageData>) dao.findForList("DepartmentMapper.getDepartmentById1", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 根据type获取department.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public List<PageData> getDepartmentsByType(PageData pd) throws Exception {
        try {
            return (List<PageData>) dao.findForList("DepartmentMapper.getDepartmentsByType", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 根据id修改父类节点
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void updateParentDepartment(PageData pd) throws Exception {
        dao.update("DepartmentMapper.updateParentDepartment", pd);
    }

    public List<PageData> findAllOrgType() throws Exception {
        return (List<PageData>) dao.findForList("findAllOrgType", "");
    }

    public void insertOrganize(PageData pd) throws Exception {
        dao.save("insertOrganize", pd);
    }

    public List<PageData> findChildDepartment(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("findChildDepartment", pd);
    }

    /**
     * 查询指定节点所有子节点
     */
    public List<PageData> findAllChildDepartments(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("findAllChildDepartments", pd);
    }

    /**
     * 查询指定节点父节点
     */
    public PageData findAllParentDepartments(PageData pd) throws Exception {
        return (PageData) dao.findForObject("findAllParentDepartments", pd);
    }

    /**
     * 查询指定节点子节点
     */
    public List<PageData> findAllChildDepartment(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("findAllChildDepartments", pd);
    }

    /**
     * 查询除开指定节点的所有其他节点
     */
    public List<PageData> findOtherDepartments(List<String> ids) throws Exception {
        return (List<PageData>) dao.findForList("findOtherDepartments", ids);
    }

    /**
     * 查询区域节点 findAllSubCompanyNode
     */
    public List<PageData> findAllAreaNode() throws Exception {
        return (List<PageData>) dao.findForList("findAllAreaNode", "");
    }

    /**
     * 查询子公司节点
     */
    public List<PageData> findAllSubCompanyNode() throws Exception {
        return (List<PageData>) dao.findForList("findAllSubCompanyNode", "");
    }

    /**
     * 查询指定区域下的所有子公司节点
     */
    public List<PageData> findAllBranchNodeByParentId(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.findAllBranchNodeByParentId", pd);
    }

    /**
     * 查询除开该分子公司的其他分子公司节点
     */
    public List<PageData> findOtherAllBranchNode(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.findOtherAllBranchNode", pd);
    }

    /**
     * 查询父节点
     */
    public PageData findParentDepartment(PageData pd) throws Exception {
        return (PageData) dao.findForObject("findParentDepartment", pd);
    }

    public PageData findBranchByPosition(String str) throws Exception {
        return (PageData) dao.findForObject("DepartmentMapper.findBranchByPosition", str);
    }

    public PageData findAreaByPosition(String str) throws Exception {
        return (PageData) dao.findForObject("DepartmentMapper.findAreaByPosition", str);
    }

    public PageData findAreaByBranch(String str) throws Exception {
        return (PageData) dao.findForObject("DepartmentMapper.findAreaByBranch", str);
    }

    public List<PageData> findAllPositionNodeByBranchId(String str) throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.findAllPositionNodeByBranchId", str);
    }

    public List<PageData> findAllPositionNodeByAreaId(String str) throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.findAllPositionNodeByAreaId", str);
    }

    /**
     * 导出tb_department用
     */
    public List<PageData> findDepartmentList() throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.findDepartmentList", "");
    }

    public void saveDepartment(PageData pd) throws Exception {
        dao.save("DepartmentMapper.saveDepartment", pd);
    }

    /**
     * 查询子级职位
     */
    public List<PageData> findPosition(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("DepartmentMapper.findPosition", pd);
    }

}

