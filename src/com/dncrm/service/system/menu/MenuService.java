package com.dncrm.service.system.menu;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.system.Menu;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("menuService")
public class MenuService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;


    public void deleteMenuById(String MENU_ID) throws Exception {
        dao.save("MenuMapper.deleteMenuById", MENU_ID);

    }

    public PageData getMenuById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("MenuMapper.getMenuById", pd);

    }

    //取最大id
    public PageData findMaxId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("MenuMapper.findMaxId", pd);

    }

    public List<Menu> listAllParentMenu() throws Exception {
        return (List<Menu>) dao.findForList("MenuMapper.listAllParentMenu", null);

    }

    public void saveMenu(Menu menu) throws Exception {
        if (menu.getMENU_ID() != null && menu.getMENU_ID() != "") {
            //dao.update("MenuMapper.updateMenu", menu);
            dao.save("MenuMapper.insertMenu", menu);
        } else {
            dao.save("MenuMapper.insertMenu", menu);
        }
    }

    public List<Menu> listSubMenuByParentId(String parentId) throws Exception {
        return (List<Menu>) dao.findForList("MenuMapper.listSubMenuByParentId", parentId);

    }

    public List<Menu> listAllMenu() throws Exception {
        List<Menu> rl = this.listAllParentMenu();
        for (Menu menu : rl) {
            List<Menu> subList = this.listSubMenuByParentId(menu.getMENU_ID());
            menu.setSubMenu(subList);
        }
        return rl;
    }

    public List<Menu> listAllSubMenu() throws Exception {
        return (List<Menu>) dao.findForList("MenuMapper.listAllSubMenu", null);

    }

    /**
     * 编辑
     */
    public PageData edit(PageData pd) throws Exception {
        return (PageData) dao.findForObject("MenuMapper.updateMenu", pd);
    }

    /**
     * 保存菜单图标 (顶部菜单)
     */
    public PageData editicon(PageData pd) throws Exception {
        return (PageData) dao.findForObject("MenuMapper.editicon", pd);
    }

    /**
     * 更新子菜单类型菜单
     */
    public PageData editType(PageData pd) throws Exception {
        return (PageData) dao.findForObject("MenuMapper.editType", pd);
    }
}
