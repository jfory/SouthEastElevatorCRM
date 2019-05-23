package com.dncrm.service.system.elevatorManage;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ElevatorManageService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    public List<PageData> listAllModels() throws Exception {
        return (List<PageData>) dao.findForList("ElevatorManageMapper" +
                ".findAllElevatorModels", null);
    }

    /**
     * 查询指定节点所有子节点
     */
    public List<PageData> findAllChildModels(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("ElevatorManageMapper" +
                ".findAllChildModels", pd);
    }

    /**
     * 查询指定节点父节点
     */
    public PageData findParentModels(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ElevatorManageMapper" +
                ".findParentModel", pd);
    }

    /**
     * 查询除开指定节点的所有其他节点
     */
    public List<PageData> findOtherModels(List<String> ids) throws Exception {
        return (List<PageData>) dao.findForList("ElevatorManageMapper" +
                ".findOtherModels", ids);
    }

    /**
     * 根据ID获取梯种信息.
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public List<PageData> getModelsById(PageData pd) throws Exception {
        try {
            return (List<PageData>) dao.findForList("ElevatorManageMapper" +
                    ".getElevatorModelById", pd);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 根据id修改节点
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void updateParentModel(PageData pd) throws Exception {
        dao.update("ElevatorManageMapper.updateModel", pd);
    }

    public void insertModel(PageData pd) throws Exception {
        dao.save("ElevatorManageMapper.insertModel", pd);
    }

    public void delModel(PageData pd) throws Exception {
        dao.delete("ElevatorManageMapper.deleteModel", pd);
    }

}
